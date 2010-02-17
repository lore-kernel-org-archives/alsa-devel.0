From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from
	USB	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 13:32:52 +0000
Message-ID: <20100217133251.GE2032@sirena.org.uk>
References: <20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
	<20100217001047.GB6766@tango.0pointer.de>
	<alpine.LNX.2.00.1002170924570.28127@eeebox2.perex-int.cz>
	<20100217120644.GC2032@sirena.org.uk>
	<20100217131548.GE24165@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E4DD10388A
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 14:32:53 +0100 (CET)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>) id 1Nhk1N-0003Cw-0l
	for alsa-devel@alsa-project.org; Wed, 17 Feb 2010 13:32:53 +0000
Content-Disposition: inline
In-Reply-To: <20100217131548.GE24165@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 02:15:48PM +0100, Lennart Poettering wrote:

> I wonder if we could harvest this in some way from the Windows
> drivers? Does Windows care about the dB data at all? Maybe one could
> extract this information from their .inf files or so, if they store it
> there?

It could well be, for this sort of stuff grovelling around in the MSDN
driver kit documentation will normally turn something up.

> I wonder where they get that data from and what they do with broken
> hardware like the Aureon... Now I wished I had access to a Windows
> machine to figure that out...

IME this is dealt with by the manufacturer providing a driver, a device
specific driver will bind in preference to a class driver and with
Windows it's much more normal to ship a device specific driver along
with the device.  I've no knowledge of Windows audio drivers, though.
