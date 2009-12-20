From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Installing a "different" version of Alsa
Date: Sun, 20 Dec 2009 12:47:28 +0000
Message-ID: <20091220124727.GA2881@sirena.org.uk>
References: <0640B473256C4948B7A16988809F8AB2@brianoffice>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DF8871037F7
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 13:47:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <0640B473256C4948B7A16988809F8AB2@brianoffice>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Welch <Brian-Welch@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 19, 2009 at 09:48:16PM -0700, Brian Welch wrote:

[Please fix your MUA to word wrap lines at ~80 columns, it would make
your mails much easier to read.]

> When I use kbuild to build my custom sound hardware driver against the SDK in the kernel, it always trys to pick up the older ALSA header files that are in the SDK, but I want to use the newer versions that are in the directory with the newer version of ALSA.  What the best way to make sure I get the correct headers?  Is what I'm trying "dangerous" and should I be going about this a different way?

The best way of integrating with the toolchain you're using will usually
depend on the toolchain - you'll generally be able to get better advice
about how to work with the toolchain by asking people who work with the
toolchain.
