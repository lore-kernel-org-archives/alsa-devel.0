From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: tlv320dac33 fixes
Date: Thu, 11 Mar 2010 16:46:28 +0200
Message-ID: <20100311164628.f6c08a0b.jhnikula@gmail.com>
References: <1268317582-10284-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B58B103905
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 15:45:09 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 26so16130eyw.16
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 06:45:08 -0800 (PST)
In-Reply-To: <1268317582-10284-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Mar 2010 16:26:20 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> It has been found that OMAP3 McBSP needs the BCLK continuously running
> on the serial interface when it is configured to be slave.
> 
Just curious: what would happen if the BCLK is cut while the McBSP is
operating? I'm thinking are there also other similar problems, e.g. if
the rate is not correct.


-- 
Jarkko
