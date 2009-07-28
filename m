From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Using Alsa for AD1981b on 9263
Date: Tue, 28 Jul 2009 10:54:34 +0100
Message-ID: <20090728095434.GA26452@sirena.org.uk>
References: <33A0EEB8D50198449794A1AB9DEB1E01866417C950@copuex01.coreobjects.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CD54824633
	for <Alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 11:54:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <33A0EEB8D50198449794A1AB9DEB1E01866417C950@copuex01.coreobjects.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shilpa Kedar Walvekar <shilpa.walvekar@coreobjects.com>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 28, 2009 at 02:00:21PM +0530, Shilpa Kedar Walvekar wrote:

> I am using AT91SAM9263 evaluation kit with AD1981b codec. I want to use alsa to play and record audio on this kit.

> I tried to install the alsa library, alsa-oss, alsa-util. Alsa driver was part of kernel (2.6.27). I did, ./configure && make && make install for library, oss and util. Now when I try to do aplay -l following happens:
> aplay: device_list:223: no soundcards found...

> Don't know what is happening. Am I missing any step? What else should be done?
> Please help me asap.

You need an audio driver for the card; Linux 2.6.27 does not have an
AC97 driver for the Atmel CPUs.  The out of tree Atmel patches for
2.6.27 may have had one.
