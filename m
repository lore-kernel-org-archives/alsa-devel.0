From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC/kirkwood: the 'break' is useless
Date: Tue, 1 Jun 2010 11:27:21 +0100
Message-ID: <20100601102721.GB863@rakim.wolfsonmicro.main>
References: <4C0492EB.2040003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB4451039F1
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jun 2010 12:27:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C0492EB.2040003@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: apatard@mandriva.com, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 01, 2010 at 12:56:11PM +0800, Wan ZongShun wrote:
> Dear Mark,
> 
> The 'break' is useless here, I think it should be removed.
> 
> Thanks!
> 
> Signed-off-by: Wan ZongShun<mcuos.com@gmail.com>

Just to emphasise my previous comments about patch formatting it's
particularly important to get stuff like that right with cleanup patches
like this - with simple updates the effort required to apply the patch
(cleaning up the commit message and so on) can be greater than the
effort required to make the original change.
