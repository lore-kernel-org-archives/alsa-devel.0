From: Randolph Chung <rchung42@gmail.com>
Subject: Re: Problem with MX27 ASoC audio
Date: Mon, 16 Aug 2010 17:27:13 +0800
Message-ID: <AANLkTiks+PBmKf6UrxwfLR2jGHO47-p4=o10Y-EE0kJw@mail.gmail.com>
References: <AANLkTikAybX=rP-DfWm5z8eVcC1EaujyEofsSoSJQ1M8@mail.gmail.com>
	<20100812125625.GA27749@pengutronix.de>
	<AANLkTinCWxRNBeXxTHRFBDgmgM6vZTqTKgoCubNYSV5u@mail.gmail.com>
	<20100812150145.GC11362@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 79413103816
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 11:27:16 +0200 (CEST)
Received: by gwb17 with SMTP id 17so1700362gwb.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2010 02:27:15 -0700 (PDT)
In-Reply-To: <20100812150145.GC11362@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 12, 2010 at 11:01 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Aug 12, 2010 at 10:59:19PM +0800, Randolph Chung wrote:
>
>> I will double check tomorrow, but I have another version of the code
>> that checks all the return values and I am quite sure the set_channels
>> didn't fail....
>
> Actually, if the interval between the time periods doubles in the
> failure case that suggests that the hardware may have decided to start
> running in mono mode...
>

I investigated this a bit further. Sasha is right that only stereo
channels work. However in the end that is not really relevant to my
problem.

The below may be a related issue:

I initiate a recording using arecord from the command line:

arecord -D hw:0,0 -f S16_LE -r 8000 -c 2 -d 5 /dev/null
(this command actually takes 10 seconds to complete)

I check the clock rates on the physical connections from the codec:
MCLK = 13MHz
BCLK = 8kHz
WCLK = 256kHz

This seems to be correct. However, on the MX27 side I only get "half"
the data (i.e. the data arrives at a rate of 128kHz). This is checked
by instrumenting the DMA driver in the progression routine or the FIQ
driver in the timer routine. (Also from checking the time arecord
runs) If I hack my codec to double the datarate to 16kHz then I get
back data that plays back correctly at 8kHz (my earlier test was using
this hack, which I had forgotten about). So this seems to be a problem
on the MX27 side.

I am not sure if there is any special additional setup that might be
needed in my machine driver to match up the codec configuration. It
would seem to me that if the MX27 is the I2S slave, then it should
just clock in data using the external clock signals, so I don't quite
understand how the received data rate can not match what is coming
from the codec. Playback works fine without any hacks.

Any ideas? I do not see any in-tree drivers that use MX27+I2S codecs,
only MX27+AC97, which goes through a different path. Just wondering if
the I2S path works for others in the capture case?

randolph
