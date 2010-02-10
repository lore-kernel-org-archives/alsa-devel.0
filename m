From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add supply for audio serial
 interface control
Date: Wed, 10 Feb 2010 09:11:19 +0900
Message-ID: <4B71F9A7.7010504@samsung.com>
References: <1265721844-5065-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 230EA2432F
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 01:11:22 +0100 (CET)
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KXL00KJKN6VRW@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 10 Feb 2010 09:11:19 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KXL005O6N6U4U@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 10 Feb 2010 09:11:18 +0900 (KST)
In-reply-to: <1265721844-5065-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, x0052729@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 2/9/2010 10:24 PM, Peter Ujfalusi wrote:
> The serial interface (TDM/I2S) for the audio block have been
> constantly enabled.
> Introduce a new DAPM_SUPPLY for handling the AIF_EN bit, so
> the interface is only enabled, when there is a need for it.
> For example when only the analog loopback is enabled, there
> is no need to keep the serial interface active.
> 
> I have added the persons who contributed to the Voice path
> of twl4030 codec driver, so they might have the ability
> to test this patch, and send an update for the Voice path,
> if it is necessary
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
> 
> This patch has been tested in OPTION 1 mode, where the Voice
> path is not in use.
> I have looked for dependencies in the Voice path regarding to 
> the Audio interface enable bit, but I have not found any.
> If someone could test, if the Voice path also needs the AIF_EN
> bit set, than please send a patch, which adds this new supply
> to the DAPM rule for the Voice path.
> 

Unfortunately, i cannot test the twl4030 codec anymore, but i think
there is no dependency in the Voice path by this patch. The AIF_EN bit
is only for the audio interface(DIN, DOUT, SYNC, CLK).
