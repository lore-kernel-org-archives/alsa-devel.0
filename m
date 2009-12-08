From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: Re: [PATCH] Use "Skeaper" instead of "chname" by
	deafult.
Date: Tue, 08 Dec 2009 13:39:23 +0100
Message-ID: <1260275963.10891.45.camel@zwerg>
References: <1260125844-3650-1-git-send-email-bug-track@fisher-privat.net>
	<s5hr5r5sp1v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 9F86E2454D
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 13:39:32 +0100 (CET)
In-Reply-To: <s5hr5r5sp1v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Dienstag, den 08.12.2009, 12:06 +0100 schrieb Takashi Iwai:
> At Sun,  6 Dec 2009 19:57:24 +0100,
> Alexey Fisher wrote:
> > 
> > If you use Speacker by defaut, Surround volume controls will have bad names.
> > For example:
> > before patch  ->  after patch
> > -----------------------------
> > Speaker       ->  Front
> > Speaker 1     ->  Surround
> > Speaker 2     ->  Side
> > 
> > Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
> 
> No, it's no-go.  Your patch would break many other machines badly.
> 
> The problem here is that the speakers are assigned to your default pin
> configs.  I suppose they are line-out jacks, not built-in speakers (or
> is it a monster PC with 4 speakers? :)  If my guess is right, the
> default pincfgs have to be fixed.

Your guess is correct :) What bit should be fixed? Do you mean
SET_CONFIG_DEFAULT_BYTES_2? 

This is the part from my previous patch.

> +static unsigned int intel_dg45id_pin_configs[14] = {
> +     0x02214230, 0x02A19240, 0x01113214, 0x01114210,
> +     0x01A19250, 0x01111212, 0x01116211, 0x40f000f0,
> +     0x40f000f0, 0x40f000f0, 0x40f000f0, 0x014510A0,
> +     0x074510B0, 0x40f000f0
> +};


> 
> > 
> > 	modified:   sound/pci/hda/patch_sigmatel.c
> > ---
> >  sound/pci/hda/patch_sigmatel.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/sound/pci/hda/patch_sigmatel.c b/sound
> /pci/hda/patch_sigmatel.c
> > index e604bae..121a93e 100644
> > --- a/sound/pci/hda/patch_sigmatel.c
> > +++ b/sound/pci/hda/patch_sigmatel.c
> > @@ -3152,13 +3152,13 @@ static int create_multi_out_ctls(struct hda_codec *codec, int num_outs,
> >  				idx = i;
> >  				break;
> >  			case AUTO_PIN_SPEAKER_OUT:
> > -				name = "Speaker";
> > -				idx = i;
> > -				break;
> > -			default:
> >  				name = chname[i];
> >  				idx = 0;
> >  				break;
> > +			default:
> > +				name = "Speaker";
> > +				idx = i;
> > +				break;
> >  			}
> >  			err = create_controls_idx(codec, name, idx, nid, 3);
> >  			if (err < 0)
> > -- 
> > 1.6.3.3
> > 
