From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from
	USB	cards, especially Aureon 5.1 MkII
Date: Tue, 16 Feb 2010 14:40:47 +0000
Message-ID: <20100216144047.GB10586@sirena.org.uk>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DD84F103827
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 15:40:48 +0100 (CET)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>) id 1NhObX-0007Jg-BZ
	for alsa-devel@alsa-project.org; Tue, 16 Feb 2010 14:40:47 +0000
Content-Disposition: inline
In-Reply-To: <20100216143200.GB25489@tango.0pointer.de>
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

On Tue, Feb 16, 2010 at 03:32:01PM +0100, Lennart Poettering wrote:
> On Tue, 16.02.10 09:24, Jaroslav Kysela (perex@perex.cz) wrote:

> > Line: 0dB..47.81dB		# seems correct -47.81dB..0dB
> > Line Capture: -0.18dB..23.81dB	# seems correct
> > -17.81dB..6.18dB

> Hmm, how did you choose where to put 0dB?

The Line one looks like someone got attenuation and gain confused, which
is a fairly common mistake for people to make when copying information
from one place to another.  Possibly a similar thing going on with the
Line Capture control, plus a fixed 6dB gain (which may well be a
separate amp...).
