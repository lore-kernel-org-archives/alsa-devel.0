From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: MSM DSP
Date: Wed, 4 Nov 2009 10:49:44 +0000
Message-ID: <20091104104943.GA25044@sirena.org.uk>
References: <1257264142.19223.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EAE810386F
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 11:49:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257264142.19223.17.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: GNUtoo <GNUtoo@no-log.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please fix your MUA to word wrap at 80 columns, not doing this makes
your posts much harder to read and reply to.  It'd also be helpful to
place blank lines between paragraphs to improve legibility.

On Tue, Nov 03, 2009 at 05:02:22PM +0100, GNUtoo wrote:

> codeaurora(
> https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git ) had alsa
> in its kenrel I first tried to compile that kernel...but due to
> numerous bugs(It didn't compile and needed too much fixing) in it
> android-msm-2.6.29 branch I decided to import alsa in the linuxtogo
> kernel,and I pushed the sources at a temporary htc-alsa branch at
> git://gitorious.org/replicant/gnulinuxkernel.git (it's called gnulinux
> in order to differentiate from an android kernel,I didn't find a good
> name for it)

Please submit any code you have to the mailing list, it's much easier to
review things via the standard workflows and getting the drivers into
mainline would be good.

The problems you're reporting suggest that the driver either isn't
communicating the requirements it has for data buffers to the
applications correctly or it isn't correctly notifying applications when
buffers have drained.  mplayer is much more sensitive to both of these
issues.
