From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: S3C24XX : Align the peroid size to
 the buffer size
Date: Thu, 20 Aug 2009 19:44:19 +0100
Message-ID: <20090820184419.GC5032@sirena.org.uk>
References: <1250677339.3516.17.camel@shinel> <s5hd46scctf.wl%tiwai@suse.de>
	<1250679571.500.20.camel@shinel> <s5h7hx0c8l2.wl%tiwai@suse.de>
	<1250780543.1404.57.camel@sl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 643A6103857
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 21:06:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250780543.1404.57.camel@sl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shine Liu <shinel@foxmail.com>
Cc: ben@simtec.co.uk, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 20, 2009 at 11:02:23PM +0800, Shine Liu wrote:

> This patch will fix the bug metioned in the above mail. Force the peroid
> size to be aligned with the buffer size.

Applied (with a slightly updated commit message) - thanks!
