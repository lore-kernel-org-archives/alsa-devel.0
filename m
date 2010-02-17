From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 11:55:17 +0000
Message-ID: <ad2655cb1002170355n7d2df930ha6cf036b6e00218@mail.gmail.com>
References: <4B7A5268.5050704@ladisch.de>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 8ABB8103859
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 12:55:18 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so179073fgg.2
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 03:55:17 -0800 (PST)
In-Reply-To: <20100216235658.GA6766@tango.0pointer.de>
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

On 16 February 2010 23:56, Lennart Poettering <mznyfn@0pointer.de> wrote:
>
> The reason I was asking how Jaroslav chose the 0dB position for his
> measurements was purely because I wanted to do my own measurements for
> that Aureon card. The dbmeasure tool I wrote for stuff like that puts
> 0dB at max amplification, however Jaroslav didn't, so I was wondering
> how he chose 0dB then.
>
> Lennart
>

I think the digital side is clear. So I will not go into that.

I think we need to separate the analogue side into a number of categories:
1) Standard consumer line-out levels.
2) Standard pro line-out levels.
3) Consumer line-in levels.
4) Pro line-in levels.
5) Consumer mic levels.
6) Pro mic levels.
7) Consumer speaker levels.
8) Pro speaker levels.

On the analogue side, I believe the 0dB gain point is intended to be
the point at which one can be fairly sure that the distortion will be
low for a sensible full scale input.
I think we can get better definition on items 1 to 4.
To this end, I think ALSA needs a new control type so the user can set
what line out voltages will occur using standard full scale digital
inputs.
http://en.wikipedia.org/wiki/Decibel
>From above pro-equipment works with 0.775V as reference volume (0dBu)
and consumer electronics with 1V as reference volume (0dBV).

So, the new level control types will show dBu and dBV. The current
"gain" controls will show dB.

I think we should focus on items 1 to 4 first, and then sort out 5 to 8 later.
Measurement should be with a volt meter if possible, but we will have
to get the correct output frequency right to match what the volt meter
is expecting, otherwise the readings will be wrong.
We could even be more specific. If we can get items 1 and 2 correct
for all sound cards, we can then more easily calibrate 3 and 4.
Considering that there are over 1000 different sound card variants out
there, this is going to take a long long time.

Kind Regards

James
