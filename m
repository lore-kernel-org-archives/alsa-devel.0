From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from
	USB	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 12:06:44 +0000
Message-ID: <20100217120644.GC2032@sirena.org.uk>
References: <20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
	<20100217001047.GB6766@tango.0pointer.de>
	<alpine.LNX.2.00.1002170924570.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CE1610386D
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 13:06:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1002170924570.28127@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 10:04:50AM +0100, Jaroslav Kysela wrote:

> I think that having a reference level is good for users. For example,
> some AC97 codecs have Line Out range from -94.5dB .. 0dB , Mixed Line In
> is in range -34.5dB .. 12dB. So if I set 0dB to Line In and 0dB to Line
> Out, I would expect to get (if analog parts of soundcard are not
> assymetric) identical output level as input level.

That'll tend to be the case for most hardware - the main issues are the
fact that we don't currently have a way to tell userspace about the
signal path in the device (so knowing which amplifiers are in use at a
given time can be tricky) and the fact that you're likely to run into
are that you do get fixed gain or attenuation stages in the signal path
for various reasons and those currently aren't exposed to user space at
all (but that'd probably flop out of doing the routing information).

> The second question is if the represented dB range and scale reported from 
> the driver (hardware and audio chip datasheets) really matches the 
> hardware and how we can measure these values. I suspect a lot of trouble 
> here, because the analog parts of soundcards might have strange curves - 
> it's probably thing you deal with in PA now.

Datasheets really should be reliable, and if the curve in the datsheet
is too unusual to handle with a range the TLV data format does always
allow us to specify subranges (down to individual values for each step)
so there's no fundamental problem exposing the information to user
space.

I'd actually be surprised if there were too much of an issue with this
beyond the data collection one (especially for USB devices).
