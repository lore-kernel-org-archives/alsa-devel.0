From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from
	USB	cards, especially Aureon 5.1 MkII
Date: Tue, 16 Feb 2010 23:38:25 +0000
Message-ID: <20100216233825.GB23623@sirena.org.uk>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DD4D6244BB
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 00:38:25 +0100 (CET)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>) id 1NhWzp-0007mL-Mf
	for alsa-devel@alsa-project.org; Tue, 16 Feb 2010 23:38:25 +0000
Content-Disposition: inline
In-Reply-To: <20100216224212.GA1486@tango.0pointer.de>
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

On Tue, Feb 16, 2010 at 11:42:12PM +0100, Lennart Poettering wrote:
> On Tue, 16.02.10 22:39, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:

> > Typically the DACs and ADCs will have a full scale signal at line
> > reference level - it should generally be a good approximation with
> > nothing else to go on.

> "line reference level"? What is that?

As I understand it (and bear in mind that I'm a software rather than
electrical engineer) it's not 100% fixed, though since the actual result
depends very much on what it's connected to an absolute answer isn't as
important as it might be.  1V RMS is very standard in consumer stuff at
least.

If you could frame exactly the information that you're looking for then
I should be able to ask a few people who are electrical engineers and
get a more coherent answer for you.   I guess you're looking at trying
to have PulseAudio set sensible levels by default?
