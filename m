From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL and
 SACR1_DREC separately
Date: Tue, 12 May 2009 11:59:03 +0200
Message-ID: <4A094867.2010600@gmail.com>
References: <4A03748B.1010302@gmail.com> <20090508104229.GD5654@sirena.org.uk>
	<20090511190504.GF20283@sirena.org.uk> <4A087FCF.2080304@gmail.com>
	<20090511210729.GA4404@sirena.org.uk> <4A08A001.4050003@gmail.com>
	<20090512085838.GB29889@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A96D103839
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 11:59:07 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3593036fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2009 02:59:05 -0700 (PDT)
In-Reply-To: <20090512085838.GB29889@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Eric Miao <eric.miao@marvell.com>, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, May 12, 2009 at 12:00:33AM +0200, Karl Beldan wrote:
> 
>> Then it is perfectly normal since reset enables both REC and RPL, 2/4 needs 1/4.
>> The current tree disables the clocks anytime one function is disabled.
> 
> That doesn't seem to tie up - I can see the initialisation changing the
> behaviour on first run but it seems surprising that this should happen
> on subsequent runs too.  Alternatively, is your initialisation patch
> safe to apply by itself?
> 
Well 2/4 stops the clocks only if both REC and RPL are disabled.
Without 1/4 you end up with REC enabled at startup.
In a scenario where you have never used REC you end up RPLing with REC always on.
REC being on at shutdown(),clocks won't stop.

>> I resent 1/4 and will make it 1/5 with the whole serie once everything is Clear.
> 
> As previously discussed you need to rework the patch to not do the reset
> on initial probe not when the module is loaded, you need to address this
> rather than reposting.
> 
The patch in question is moving the reset in probe rather than module init - with comment updated.
What is wrong ?

> I'll try to find time to re-review the series but I'm going to need to
> sit down with the datasheet and check this in much more detail.
For 1/4 and 2/4 there should not be great need, Really.

-- 
Karl
