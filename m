From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: PATCH - ESI Juli driver - OK
Date: Thu, 20 Mar 2008 22:49:38 +0100
Message-ID: <47E2DBF2.1050901@insite.cz>
References: <47DD1934.3000003@insite.cz>	<s5hod9du6gb.wl%tiwai@suse.de>	<47DE328D.1080009@insite.cz>	<s5htzj5r9d6.wl%tiwai@suse.de>	<47DE3BD2.5090007@insite.cz>	<s5hwso1pkms.wl%tiwai@suse.de>	<47DE7B70.2040407@insite.cz>	<s5hd4ptpefs.wl%tiwai@suse.de>	<47DE934F.3060308@insite.cz>	<s5hy78hnxy7.wl%tiwai@suse.de>	<47DF678B.3000605@insite.cz>	<s5h7ig0w01l.wl%tiwai@suse.de>	<47DFE6C8.7040306@insite.cz>
	<47E272A8.3070306@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A6D82438E
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 22:49:47 +0100 (CET)
In-Reply-To: <47E272A8.3070306@insite.cz>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



Pavel Hofman wrote:

> 
> Takashi, thanks for commiting the patch. I just noticed the final patch 
> does not change the native rates flags in snd_vt1724_playback_pro for 
> juli, keeping the unsupported values 8000 - 12000 in the flags. I guess 
> if 8kHz rate is played via plughw, plughw will not resample and juli 
> will switch to gpios = 0, corresponding to 32kHz.
> 
> I can test in the evening, but this is very likely.
> 

The test proved the current version of the driver works correctly. 
plughw correctly oversampled input 8kHz signal to 16kHz on Juli, and 
played 8kHz directly on Prodigy192.

Thanks for the clean work :)

Pavel.
