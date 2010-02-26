From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] [patch 2/2] AC97: add full duplex support
 for atmel AT91 and AVR.
Date: Fri, 26 Feb 2010 09:15:24 +0000
Message-ID: <1267175724.3212.6.camel@odin>
References: <1267120780-1788-1-git-send-email-sedji.gaouaou@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 0893424407
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 10:15:28 +0100 (CET)
Received: by fxm20 with SMTP id 20so16717904fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 01:15:27 -0800 (PST)
In-Reply-To: <1267120780-1788-1-git-send-email-sedji.gaouaou@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-02-25 at 18:59 +0100, Sedji Gaouaou wrote:
> This patch add full duplex support on AT91 and AVR.
> It was a bug: we needed to check first if there are some chips opened so we
> could enable both reception and sending of the data.
> 
> Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
