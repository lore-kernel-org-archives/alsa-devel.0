From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ARM DaVinci: Add PCM3008 ALSA SoC driver
	for the Lyrtech SFFSDR board
Date: Fri, 21 Nov 2008 10:55:35 +0000
Message-ID: <20081121105534.GA31866@sirena.org.uk>
References: <1226968079-1624-1-git-send-email-hugo@hugovil.com>
	<20081118113150.GC23217@sirena.org.uk>
	<87fxlm7yjv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4570D24405
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 11:55:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87fxlm7yjv.fsf@deeprootsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: alsa-devel@alsa-project.org, Hugo Villeneuve <hugo.villeneuve@lyrtech.com>, davinci-linux-open-source@linux.davincidsp.com, Hugo Villeneuve <hugo@hugovil.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 03:44:20PM -0800, Kevin Hilman wrote:

> I agree.  In addition, I believe the board-specific init
> (sound/soc/davinci/davinci-sffsdr.c) should not be under sound/*, but
> rather belongs in the board init code in arch/arm/mach-davinci/board*.

If you want to do that please do something like what's been done for the
s3c24xx-uda134x or soc-of-simple drivers which keeps the ASoC code in
sound/soc and has the per-board configuration in the platform directory.
