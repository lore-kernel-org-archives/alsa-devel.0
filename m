From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tlv320dac33: Fix inconsistent
 spinlock usage
Date: Tue, 22 Mar 2011 18:10:48 +0000
Message-ID: <1300817448.3356.13.camel@odin>
References: <1300454111-27452-1-git-send-email-peter.ujfalusi@nokia.com>
	<20110318132023.GB677@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A06112443B
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 19:10:56 +0100 (CET)
Received: by wyj26 with SMTP id 26so6696122wyj.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 11:10:56 -0700 (PDT)
In-Reply-To: <20110318132023.GB677@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-03-18 at 13:20 +0000, Mark Brown wrote:
> On Fri, Mar 18, 2011 at 03:15:11PM +0200, Peter Ujfalusi wrote:
> > The lock is used within the interrupt handler.
> > Correct the spinlock usage, and use irqsave/irqrestore
> > flavour of spin_lock/unlock.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> _______________________________________________

Applied.

Thanks

Liam
