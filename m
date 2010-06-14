From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: wrong decibel data?
Date: Mon, 14 Jun 2010 20:54:17 +0200
Message-ID: <20100614185417.GF14916@tango.0pointer.de>
References: <AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
	<hulnlp$m00$1@dough.gmane.org>
	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
	<hur2pt$uaa$1@dough.gmane.org>
	<20100613135349.GB5818@tango.0pointer.de>
	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>
	<hv4pfi$gqr$3@dough.gmane.org>
	<AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>
	<hv4vs6$a6q$1@dough.gmane.org>
	<AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id C803D103866
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 20:54:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>
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

On Mon, 14.06.10 11:46, James Courtier-Dutton (james.dutton@gmail.com) wrote:

> One has very different problems with capture than one does with playback.
> With capture it is important to identify which are analog controls
> (applied to the analog part of the circuit) and which are digital
> controls (applied to the digital part of the circuit)
> So, for capture one might wish to adjust the analog control so that
> the signal going into the ADC is a suitable level, but once the signal
> is digital, one should really not adjust it further, and just record
> what you have.
> If one was to combine these two capture controls in one PA control, it
> would just be wrong.

Well, we apply volumes going from the "outer end" to the "inner end" of
the pipeline. That should have the affect that the biggest part is done
on the analog elements (i.e. "outer") and only minimal attenuation on the
digital elements (i.e. "inner").

In short: this should be covered nicely by PA already, at least if the
ALSA mixer used somewhat standard names for things.

> I think there is some indication with the name of the control. It
> sometimes has "Analog" or "Digital" attached to it.
> I think this would be better if alsa reported the "Analog" or
> "Digital" as meta data, like the dB Scales.
> PA could then make more informed decisions for capture. I.e. only
> display the "Analog" controls, and hide the digital ones, setting them
> to 0dB.

I think it is advisable to to attenuation in hw if possible, simply to
minimize CPU load. Hence we try to do the biggest volume adjustment in
analog hw, and everything we cannot apply there we do in digital hw, and
finally everything else in sw.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
