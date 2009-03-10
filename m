From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/4] ALSA: ASoC: Davinci: Fix SFFSDR
	FPGA	module codec FS bug
Date: Tue, 10 Mar 2009 15:53:25 +0000
Message-ID: <20090310155325.GC12297@sirena.org.uk>
References: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
	<1236655929-31688-2-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 53CF31037FC
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 16:53:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236655929-31688-2-git-send-email-hugo@hugovil.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 09, 2009 at 11:32:06PM -0400, Hugo Villeneuve wrote:
> This prevented the FPGA from properly configuring the codec FS when
> the SFFSDR FPGA was compiled as a module.

This doesn't apply against mainline either.  Please regenerate against
the topic/asoc branch of:

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
