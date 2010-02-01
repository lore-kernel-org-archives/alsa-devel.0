From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/10] sound/soc/blackfin: Fix continuation
	line formats
Date: Mon, 1 Feb 2010 14:47:46 +0000
Message-ID: <20100201144745.GC26011@rakim.wolfsonmicro.main>
References: <cover.1264967493.git.joe@perches.com>
	<aee58f4fc07709fe8a34021899e701824a0a6b53.1264967500.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5CE5D10380B
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 15:47:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <aee58f4fc07709fe8a34021899e701824a0a6b53.1264967500.git.joe@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 31, 2010 at 12:02:12PM -0800, Joe Perches wrote:
> String constants that are continued on subsequent lines with \
> are not good.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Gah, I thought I'd caught most of these when reviewing.  If you're using
a script to pick this stuff up it'd be worth checking for extraneous
continuations in the middle of code - outside of macros there's little
call for it.

Applied, thanks.
