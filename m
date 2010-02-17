From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 13:52:11 +1300
Message-ID: <4B7B3DBB.30703@audioscience.com>
References: <4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
	<20100217001047.GB6766@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id ABD3324389
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 01:53:03 +0100 (CET)
Received: from [192.168.1.6]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KXY0077MNSAM560@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 17 Feb 2010 13:53:00 +1300 (NZDT)
In-reply-to: <20100217001047.GB6766@tango.0pointer.de>
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

Lennart Poettering wrote:
> On Wed, 17.02.10 12:47, Eliot Blennerhassett (linux@audioscience.com) wrote:
> 
>> For our cards this is adjustable, but lets say for consumer cards it is
>> fixed.  This information is not currently available via the ALSA
>> API.
> 
> I wonder how realistic it would even be to add an API for
> this. i.e. can we even know the refernce level? On many cards most
> likely not. For example, for my integrated USB speakers speaking of a
> reference voltage would already be misleading...

Certainly. Same for laptop speakers.

Perhaps could define 0dB as the highest valid volume setting that
doesn't cause distortion in the audio when playing a full scale digital
signal.

Otherwise the absolute reference might be dBSPL at X metres from the
speaker ;)  (before anyone answers - in this context I'm joking.)

> Yepp, that's the exactly what I was asking, Jaroslav's measurements
> suggested to shift one of the mixer controls from 0..x dB to -x..0 dB
> and I was just wondering why, since we don't define the ref level in
> ALSA, hence the shift is kinda arbitrary...
> 
> Anyway, I am not pushing for adding an API for reference levels to
> ALSA. 

We define controls with names like "LineIn0 Level","LineOut1 Level"
which we document as having units of dBu.

Given that no other driver has this, its the de-facto standard ;)

> As mentioned for the PA case I decided to shift 0dB to max
> amplification in any case, which I think is a workable way to avoid
> this problem.

Sure.
