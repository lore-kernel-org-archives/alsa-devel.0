From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/2] ASoC: tlv320dac33: DSP mode and
 clocking updates
Date: Fri, 19 Mar 2010 09:38:03 +0000
Message-ID: <1268991483.3757.14.camel@odin>
References: <1268989820-18262-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6914E10389C
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 10:38:08 +0100 (CET)
Received: by vws5 with SMTP id 5so242095vws.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 02:38:07 -0700 (PDT)
In-Reply-To: <1268989820-18262-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-03-19 at 11:10 +0200, Peter Ujfalusi wrote:
> Hello,
> 
> tlv320dac33 can not support DSP_B mode since the data delay can not be set to be
> actually 0. Only DSP_A mode can be supported, so fix the DSP_A mode, and remove
> the DSP_B.
> 
> The original internal clock distribution config has been found to be not
> optimal, so fix that as well.
> 

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
