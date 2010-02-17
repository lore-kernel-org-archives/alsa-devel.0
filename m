From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from
	USB	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 14:12:33 +0000
Message-ID: <20100217141233.GF2032@sirena.org.uk>
References: <20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
	<20100217001047.GB6766@tango.0pointer.de>
	<alpine.LNX.2.00.1002170924570.28127@eeebox2.perex-int.cz>
	<20100217130612.GD24165@tango.0pointer.de>
	<ad2655cb1002170555l462981cheff2b1798a14c9d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B9B69103881
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 15:12:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ad2655cb1002170555l462981cheff2b1798a14c9d0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 01:55:08PM +0000, James Courtier-Dutton wrote:

> I personally think that PA should just set the hardware ALSA controls
> to 0dB and do all the volume control in software within PA.
> The 0dB points in hardware should result in the best sound quality.

That's not universally true - for example, with microphones you really
do want to have substantial amplification before the ADC sees them,
otherwise you'll at best get poor resolution due to the signal being
nowhere near full scale.  Sometimes this will be done by a fixed gain
stage that isn't visible to software, but not always.  Things in the
digital domain also tend to be at least equivalent to doing the work in
the CPU.
