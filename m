From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 1/3] ALSA: hda - Treat zero connection as
 non-error
Date: Thu, 17 Oct 2013 19:03:04 +0200
Message-ID: <52601848.6080101@canonical.com>
References: <1382027554-12370-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 317D02602F3
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 19:03:05 +0200 (CEST)
In-Reply-To: <1382027554-12370-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/17/2013 06:32 PM, Takashi Iwai wrote:
> The zero-length connection list happens so often on Haswell HDMI, and
> it results in warning messages like
>     ALSA: hda_codec: invalid CONNECT_LIST verb 5[1]:0
> at each time the codec resumes from the power-save, which is fairly
> annoying.

Agreed, but it's not the "invalid CONNECT_LIST verb" message you're
changing, it's the "invalid dep_range_val" message?

> 
> Since this is no real error, make it shown only in the verbose debug
> mode.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index 68801ba..d725bbf 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -574,7 +574,7 @@ int snd_hda_get_raw_connections(struct hda_codec *codec, hda_nid_t nid,
>  		if (range_val) {
>  			/* ranges between the previous and this one */
>  			if (!prev_nid || prev_nid >= val) {
> -				snd_printk(KERN_WARNING "hda_codec: "
> +				snd_printdd("hda_codec: "
>  					   "invalid dep_range_val %x:%x\n",
>  					   prev_nid, val);
>  				continue;
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
