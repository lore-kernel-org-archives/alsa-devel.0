From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from
	USB	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 11:50:49 +0000
Message-ID: <20100217115048.GB2032@sirena.org.uk>
References: <20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
	<20100217001047.GB6766@tango.0pointer.de>
	<4B7B3DBB.30703@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 332A4103866
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 12:50:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B7B3DBB.30703@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 01:52:11PM +1300, Eliot Blennerhassett wrote:
> Lennart Poettering wrote:

> > I wonder how realistic it would even be to add an API for
> > this. i.e. can we even know the refernce level? On many cards most
> > likely not. For example, for my integrated USB speakers speaking of a
> > reference voltage would already be misleading...

> Certainly. Same for laptop speakers.

> Perhaps could define 0dB as the highest valid volume setting that
> doesn't cause distortion in the audio when playing a full scale digital
> signal.

I think it's something we can leave to be specified for a given bit of
hardware - the absolute level doesn't really mean a huge amount unless
the user is actually interacting it in some way and going with the
reference level that the hardware is using internally means that we get
an idea of how much the control is affecting the signal, which is useful
for getting an idea of the optimal level to set a given control to
(generally the specified 0dB will give the lowest noise, particularly
for amplification).

It's when the signal is being presented in a fashion which means it
might have to be matched with that on another device that the absolute
levels become interesting.
