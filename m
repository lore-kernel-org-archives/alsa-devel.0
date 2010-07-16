From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Accessing snd_soc_read/snd_soc_write directly
	for	diagnostics
Date: Fri, 16 Jul 2010 09:41:10 +0100
Message-ID: <20100716084110.GB18376@sirena.org.uk>
References: <AANLkTimRMrKi-HNOB68jWSiX6TYTuOjRCySAqvRtpWLy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 85A9B243AD
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 10:41:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimRMrKi-HNOB68jWSiX6TYTuOjRCySAqvRtpWLy@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Crowe <drmikecrowe@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 16, 2010 at 09:33:25AM +0800, Mike Crowe wrote:

> I know this is a strange request, however, for diagnostic purposes in our
> embedded system, we would like to talk directly to the codec registers of
> our sound chip, bypassing alsa.  I have the driver compiled into the kernel
> (not loaded as a module).

> Is it possible to create a program which can talk to the snd_soc_read and
> snd_soc_write functions directly?  I'm not sure if this is an option, but if
> it is, I'd appreciate a pointer to something similar to use as a guide.

This is provided by the codec_reg file in debugfs - mount debugfs and
look in the 'asoc' directory.  Note that there is also a codec_reg file
in sysfs but this is read only.

When mailing Linux mailing lists please always CC the maintainers for
subsystems, this ensures messages don't get lost in the noise on mailing
lists.
