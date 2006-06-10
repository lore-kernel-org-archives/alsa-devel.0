From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [alsa-cvslog] alsa-kernel: Control API - TLV
 implementation for additional	information like dB scale
Date: Sat, 10 Jun 2006 10:24:26 +0100
Message-ID: <448A8FCA.3020808@superbug.co.uk>
References: <ALOGGER1149179663.38@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <ALOGGER1149179663.38@alsa-project.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> changeset:   4278:d194ae01b0ba9d5614ff29a82f4aacae9edd1212
> tag:         tip
> user:        perex
> date:        Thu Jun  1 18:34:01 2006 +0200
> files:       core/control.c include/asound.h include/control.h include/tlv.h pci/ca0106/ca0106_mixer.c
> description:
> Control API - TLV implementation for additional information like dB scale
> 
> This patch implements a TLV mechanism to transfer an additional information
> like dB scale to the user space. The types might be extended in future.
> 
> Acked-by: Takashi Iwai <tiwai@suse.de>
> 
> 
> +struct snd_ctl_tlv {
> +        unsigned int numid;	/* control element numeric identification */
> +        unsigned int length;	/* in bytes aligned to 4 */
> +        unsigned int tlv[0];	/* first TLV */
> +};
> +

> +static int snd_ctl_tlv_read(struct snd_card *card,
> +                            struct snd_ctl_tlv __user *_tlv)
> +{
> +	struct snd_ctl_tlv tlv;
> +	struct snd_kcontrol *kctl;
> +	unsigned int len;
> +	int err = 0;
> +
> +	if (copy_from_user(&tlv, _tlv, sizeof(tlv)))
> +		return -EFAULT;
> +        if (tlv.length < sizeof(unsigned int) * 3)
> +                return -EINVAL;
> +        down_read(&card->controls_rwsem);
> +        kctl = snd_ctl_find_numid(card, tlv.numid);
> +        if (kctl == NULL) {
> +                err = -ENOENT;
> +                goto __kctl_end;
> +        }
> +        if (kctl->tlv == NULL) {
> +                err = -ENXIO;
> +                goto __kctl_end;
> +        }
> +        len = kctl->tlv[1] + 2 * sizeof(unsigned int);
> +        if (tlv.length < len) {
> +                err = -ENOMEM;
> +                goto __kctl_end;
> +        }
> +        if (copy_to_user(_tlv->tlv, kctl->tlv, len))
> +        	err = -EFAULT;
> +      __kctl_end:
> +        up_read(&card->controls_rwsem);
> +        return err;
> +}

I have been away for the last week, so I was not able to comment on this
commit.

How do you intend to expand this for requests for anything apart from
db_scale? For example, how could we get it to return all the current
"info" (min,max etc.) information instead of the db_scale? Or, are you
keeping it simple, and make a general request for info from the numid,
and receive a group of TLVs back for all the different information that
the numid might contain? I.e. one gets the entire group of information,
regardless of what is actually needed.

My intention was to place a TLV or multiple TLVs in the request to
select the information needed, and then receive the TLVs in return.

For example, audio professionals don't like any volume steps at all.
They like continuous volume gain adjustment. For example, they request
+1dB up, the software then gradually increases the actual gain in really
small steps until a +1dB is reached. This permits totally click free
volume adjustments. This is all achievable on any sound cards with DSP
based volume control. (i.e. not cheep hardware based volume control with
defined steps.). To achieve this, one would pass the raw linear gain
values from the DSP control (.e.g. 32bit values), and then use some more
complicated userland (alsa-lib), possibly floating point, conversion
function to convert it to dB gain levels (e.g.linear to log conversion).
In this case, one might want the raw linear gain via the
snd_ctl_tlv_read IOCTL, instead of the stepwise value currently returned
using the current snd_ca0106_volume_get API. In which case, one would
need a TLV in the request, to differentiate it from the db_scale request.

What I am trying to say, is that your "simplification" of the API, has
resulted in this sort of functionality being excluded, so I would need
to implement yet another IOCTL to support it! My whole point of using
the full request/response TLV api, was to not restrict us. I was also
intending to maybe use the TLVs to set values, as well as just get
values. For example, another way to implement the "continuous gain"
feature would be to use the TLV api to set a flag, so that the 32bit
values are returned via the current snd_ca0106_volume_get(), but only
for this particular mixer open/close cycle, for backward compatibility
with the current api.

Do you prefer separate new IOCTLs for all these features?

James
