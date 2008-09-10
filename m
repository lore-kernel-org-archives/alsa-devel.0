From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/4] Separate common pxa2xx-ac97 code
Date: Wed, 10 Sep 2008 12:57:20 +0100
Message-ID: <20080910115717.GC23682@sirena.org.uk>
References: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D324324343
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Sep 2008 13:57:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 10, 2008 at 05:01:17AM +0400, Dmitry Baryshkov wrote:
> ASoC and non-ASoC drivers for ACLINK on PXA share lot's of common code.
> Move all common code into separate module snd-pxa2xx-lib.
> 
> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>

These look good from code review but I'd like to do some testing on the
systems I have here before acking.  Could you confirm which platforms
you're able to test on?
