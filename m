From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tlv320dac33: Move codec power up to
 DAPM
Date: Sat, 26 Mar 2011 15:52:55 +0000
Message-ID: <1301154775.3455.52.camel@odin>
References: <1300950709-13695-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C9A5244D0
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 16:53:00 +0100 (CET)
Received: by wwf26 with SMTP id 26so1355412wwf.20
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 08:52:59 -0700 (PDT)
In-Reply-To: <1300950709-13695-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-03-24 at 09:11 +0200, Peter Ujfalusi wrote:
> Move the codec power on (in reg 0x01, bit 4) from
> set_bias_level:SND_SOC_BIAS_ON to a DAPM supply.
> In this way we can be sure, that all the things within
> the codec is powered before the external amp is
> going to be enabled.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied.

Thanks

Liam
