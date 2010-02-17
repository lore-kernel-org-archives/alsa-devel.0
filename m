From: Mads Kiilerich <mads@kiilerich.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 14:15:31 +0100
Message-ID: <4B7BEBF3.6000403@kiilerich.com>
References: <20100216143200.GB25489@tango.0pointer.de>	<20100216144047.GB10586@sirena.org.uk>	<20100216154015.GA612@tango.0pointer.de>	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>	<20100216210703.GA18109@tango.0pointer.de>	<20100216223938.GA23623@sirena.org.uk>	<20100216224212.GA1486@tango.0pointer.de>	<20100216233825.GB23623@sirena.org.uk>	<20100216235658.GA6766@tango.0pointer.de>	<20100217111721.GA2032@sirena.org.uk>
	<20100217130155.GC24165@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 8113B103897
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 14:15:33 +0100 (CET)
Received: by ewy5 with SMTP id 5so2659459ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 05:15:33 -0800 (PST)
In-Reply-To: <20100217130155.GC24165@tango.0pointer.de>
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

On 02/17/2010 02:01 PM, Lennart Poettering wrote:
> On Wed, 17.02.10 11:17, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:
>
>> On Wed, Feb 17, 2010 at 12:56:58AM +0100, Lennart Poettering wrote:
>>
>>> Nah. I actually don't need this value for PulseAudio. In PulseAudio I
>>> chose to shift all scales so that maximum amplification becomes 0 dB,
>>> so that the UIs are similar to how most hifi racks do it, and which I
>>
>> Interesting.  The hifi equipment I've dealt with typically doesn't
>> present any units at all in the UI outside of level monitors.
>
> My old Yamaha hifi rack had a volume dial where the max was labeled 0
> dB and the min setting was -inf dB. My new Yamaha shows the dB level
> on an LCD screen whever you touch the volume dial, and it too goes
> from -inf dB to 0 dB. I kinda assumed that stereos from other
> manufacturers would do the exact same thing, but tbh never checked.

At least some of them do it differently:
http://en.wikipedia.org/wiki/Up_to_eleven

/Mads
