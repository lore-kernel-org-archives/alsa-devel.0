From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH 1/3 v2] speaker-test: Fix chmapped channel
	selection without specified chmap
Date: Tue, 12 Nov 2013 14:34:22 +0200
Message-ID: <a16a7b4a6b92231c911b2432504ffc87@mail.onse.fi>
References: <52813CD4.30600@iki.fi>
 <1384207442-830-1-git-send-email-anssi.hannula@iki.fi>
 <s5ha9haca4n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F89A2616FA
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 13:34:27 +0100 (CET)
In-Reply-To: <s5ha9haca4n.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Olivier Langlois <olivier@trillion01.com>, alsa-devel@alsa-project.org, =?UTF-8?Q?Peter_Fr=C3=BChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai kirjoitti 2013-11-12 10:11:
> At Tue, 12 Nov 2013 00:04:02 +0200,
> Anssi Hannula wrote:
> 
> The channel selection currently does not work properly when there is a
> driver-provided non-ALSA-traditional channel map but no manual channel
> map was explicitely requested with "-m".
[...]
> 
> Thanks, applied all three patches now.

OK, will you also be sending this to stable as I suggested a few 
messages before (otherwise the patch 2 will work badly, as noted in the 
patch description as well)?
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_hdmi.c?id=56cac413dd6d43af8355f5d1f90a199b540f73fc

--
Anssi Hannula
