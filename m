From: Mohammad Bahathir Hashim <bahathir@gmail.com>
Subject: Re: [PATCH] ALSA: hda - apply CS420X erratum fix for
	CS4207 only
Date: Thu, 3 Mar 2011 14:13:32 +0000 (UTC)
Message-ID: <iko7mc$nvf$1@dough.gmane.org>
References: <1298955969.12314.12.camel@snowflake>
	<1299102498-29063-1-git-send-email-arun.raghavan@collabora.co.uk>
	<1299102498-29063-2-git-send-email-arun.raghavan@collabora.co.uk>
	<s5hfwr4jtuw.wl%tiwai@suse.de> <1299154822.5858.12.camel@snowflake>
	<s5h8vwwjog5.wl%tiwai@suse.de>
Reply-To: Mohammad Bahathir Hashim <bahathir@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A4151038FC
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2011 15:13:49 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Pv9Ho-0005Hm-JP
	for alsa-devel@alsa-project.org; Thu, 03 Mar 2011 15:13:48 +0100
Received: from 118.100.41.128 ([118.100.41.128])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2011 15:13:48 +0100
Received: from bahathir by 118.100.41.128 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2011 15:13:48 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am happy to report, that the patch works on my MacBookPro6,2 with
vanilla Linux 2.6.37. 

Arigatou Gozaimasita. :)
Thank you.

On 2011-03-03, Takashi Iwai <tiwai@suse.de> wrote:
> OK, to be sure, try the patch below.
>
>
> thanks,
>
> Takashi
>
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Date: Thu, 3 Mar 2011 14:54:19 +0100
> Subject: [PATCH] ALSA: hda - Don't set to D3 in Cirrus errata init verbs
>
> The errata init verbs for CS42xx codecs contain the verbs to set
> the power-state of SPDIF nodes to D3, which seem to break the SPDIF
> output on some MacBooks.  Since this is executed during the power-up
> initialization, we shouldn't turn them down there.
>
> Reported-by: Arun Raghavan <arun.raghavan@collabora.co.uk>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/patch_cirrus.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
> index a07b031..067982f 100644
> --- a/sound/pci/hda/patch_cirrus.c
> +++ b/sound/pci/hda/patch_cirrus.c
> @@ -1039,9 +1039,11 @@ static struct hda_verb cs_errata_init_verbs[] = {
>  	{0x11, AC_VERB_SET_PROC_COEF, 0x0008},
>  	{0x11, AC_VERB_SET_PROC_STATE, 0x00},
>  
> +#if 0 /* Don't to set to D3 as we are in power-up sequence */
>  	{0x07, AC_VERB_SET_POWER_STATE, 0x03}, /* S/PDIF Rx: D3 */
>  	{0x08, AC_VERB_SET_POWER_STATE, 0x03}, /* S/PDIF Tx: D3 */
>  	/*{0x01, AC_VERB_SET_POWER_STATE, 0x03},*/ /* AFG: D3 This is already handled */
> +#endif
>  
>  	{} /* terminator */
>  };
