From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/10] soc - tlv320aic3x - Convert to use
	bulk registration APIs
Date: Tue, 13 May 2008 13:43:45 +0100
Message-ID: <20080513124328.GC21292@sirena.org.uk>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080513153419.360c23e6.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 24F051037F4
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 15:12:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080513153419.360c23e6.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 13, 2008 at 03:34:19PM +0300, Jarkko Nikula wrote:

> Hmm. I applied patches 2, 3, 5 and 10 to my n810-aic33 setup and
> following codec controls below disappear. Probably I miss some patch
> from asoc-dev since I build this test on top of linux-omap with two
> recent aic3x patches from Daniel?

No, there shouldn't be any other dependencies.  I'll take a look but I
don't have any relevant hardware.  Are there any complaints in dmesg?
