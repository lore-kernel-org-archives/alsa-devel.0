From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove bogus check for register
 validity in debugfs write
Date: Fri, 18 Mar 2011 09:36:29 +0000
Message-ID: <1300440989.3539.9.camel@odin>
References: <1300299570-20223-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D696E1039DA
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 10:36:32 +0100 (CET)
Received: by wyj26 with SMTP id 26so3327636wyj.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 02:36:32 -0700 (PDT)
In-Reply-To: <1300299570-20223-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-16 at 18:19 +0000, Mark Brown wrote:
> Since not all registers need to be cached and the cache is entirely
> optional anyway we shouldn't be checking that a register is in the
> cached range. If the register is invalid then the actual I/O code
> can determine that and report an error.
> 
> Similarly, the step size can and should be enforced by the lower level
> code if it's important.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
