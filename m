From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: Fix compile breakage in jz4740.c
 and smartq_wm8987.c
Date: Mon, 22 Nov 2010 14:06:14 +0000
Message-ID: <20101122140613.GD18960@rakim.wolfsonmicro.main>
References: <1290361727-25162-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B6FD1039C0
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 15:06:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1290361727-25162-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 21, 2010 at 07:48:44PM +0200, Jarkko Nikula wrote:
> Commit ce6120c require that soc-dapm.h cannot be included before soc.h but
> these two drivers were not checked. Fix them by including only soc.h as it
> includes soc-dapm.h.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Applied all these, thanks.  When referencing commits please include an
excerpt from the subject line as well as the commit ID - saves having to
look up what the commit that's being fixed is for those of us who don't
have IDs memorized.
