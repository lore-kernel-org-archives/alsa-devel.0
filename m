From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: git trees
Date: Thu, 31 Mar 2011 09:33:28 +0900
Message-ID: <20110331003327.GF21487@opensource.wolfsonmicro.com>
References: <4D93C892.6080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 274D3103A1E
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 02:33:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4D93C892.6080602@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 30, 2011 at 05:19:30PM -0700, Steve Calfee wrote:

> I am starting to look at a new codec driver. I have been looking at the
> alsa-project wiki describing the various git trees. I am confused
> because they seem to be lagging the linux releases (ie 2.6.38 is out,
> not in the two trees I have tried.

You should be developing against the Linux kernel, not against the out
of tree ALSA, for ASoC.  This is mostly true for regular ALSA drivers
too.

> So I checked out origin/for-2.6.39 when i built that I got a kernel
> version 2.6.38-rc1 or something. (and it built but didn't boot)

If it won't boot there's some non-audio issue on your system that you
need to figure out - other than audio it's just straight upstream.  For
current work you should use the latest for-2.6.xx branch, currently
2.6.40.

> What I need to know is which tree and which branch or tag I should use
> to develop on and to submit alsa patches from.

Just follow the standard kernel patch submission process as you would
for any other system.
