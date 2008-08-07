From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM9712 Not Giving output
Date: Thu, 7 Aug 2008 12:14:07 +0100
Message-ID: <20080807111405.GA19334@sirena.org.uk>
References: <20080806092559.GA26169@sirena.org.uk>
	<584334.24810.qm@web50106.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CE6AC103878
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Aug 2008 15:07:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <584334.24810.qm@web50106.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nitin Mahajan <nitinm76@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 06, 2008 at 03:04:07AM -0700, Nitin Mahajan wrote:

> I am not able to make the Mic recording work now. Apart from the mixer controls, I identified these registers to be programmed with following values, which again to seperate out the problem area, H/w or S/w.I am using single ended mono microphone on Left i.e Mic 1.

Please work in terms of the ALSA controls - it is much easier to provide
support when working through the exposed interfaces and direct register
writes may be overwritten by the driver, causing additional confusion.

> Also , If I take the Linux-2.6.26 kernel from mips, can you tell me how to get the patch from wolfson ASOC git so that I have all the latest ASOC and WM related code?
> I am not familiar with git :(.

To get the latest development code:

	git clone git://opensource.wolfsonmicro.com/linux-2.6-asoc
	cd linux-2.6-asoc

You can generate a diff from a tag to the latest development branch like
this:

	git diff v2.6.26..origin/dev

(Linux releases are tagged in that format - 'git tag' will list the
known tags) specifying directories lets you filter what's included so:

	git diff v2.6.26..origin/dev sound include/sound

will only give you ALSA related changes.
