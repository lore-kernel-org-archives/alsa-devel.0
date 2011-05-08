From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/12] ASoC: Create codec DAPM widgets
 before calling the codecs probe function
Date: Sun, 8 May 2011 14:56:13 +0100
Message-ID: <20110508135613.GA15968@opensource.wolfsonmicro.com>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
	<1304791860.3470.15.camel@odin>
	<20110507182115.GB26700@opensource.wolfsonmicro.com>
	<1304853361.3246.3.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E01310380C
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 15:56:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304853361.3246.3.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

On Sun, May 08, 2011 at 12:16:01PM +0100, Liam Girdwood wrote:

> Ok, cool. This is a better commit message.

> All.

> Acked-by: Liam Girdwood <lrg@ti.com>

I tried to apply these but probably due to patch 7 not being applied
most of the patches after it failed.  Please resubmit anything that
hasn't turned up in my tree.

Please also remember to pull bug fixes to the front of the patch series
so they can be sent to Linus without getting tied in with random new
feature additions and ensure that your commit messages have lines less
than 80 characters long.
