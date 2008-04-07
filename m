From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: support for hardware encode/decode of compressed
 formats
Date: Mon, 07 Apr 2008 10:37:59 +0200
Message-ID: <47F9DD67.6060807@insite.cz>
References: <1207330707.1496.199.camel@razman>
	<47F6C740.4020108@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id BAD1F2440A
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Apr 2008 10:38:10 +0200 (CEST)
In-Reply-To: <47F6C740.4020108@audioscience.com>
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
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Eliot Blennerhassett wrote:
> Tobin Davis wrote:
>> Are there any alsa supported sound cards that do hardware audio decoding
>> for MP3/WMA and otehr formats?  I'd like to look at the mechanism used
>> to connect the cards to the data stream.
> 
> This has come up a couple of times recently.
> 
> Todays answer is that ALSA has no support for getting the encoded data 
> through to the cards.
> 
> We are interested in this and would like to see it happen because our 
> cards do support MP2 and MP3 decode and encode in DSP on the cards.
> 
> Applications wanting to use this capability currently must use our HPI 
> driver directly (the primary example on Linux is Rivendell radio 
> automation software http://www.rivendellaudio.org)
> 
> One assumption that alsa makes is that a "period" equates to a fixed 
> amount of time, and a fixed amount of audio data.  This is not the case 
> for Variable bitrate mpeg etc.  And even with fixed bitrate, the bits 
> per sample is fractional E.g. 128kbps/44.1k = 2.90249... bits per sample 
> frame.
> 
> One of the two assumptions about the period would have to be relaxed to 
> allow alsa to maybe work with compressed data. Probably the time one.
> I.e. a period means the decoder has consumed X bytes, but this doesn't 
> correspond to any particular amount of time.
> 

Hi, you probably know the workarounds of spdif-passthrough in 
alsa-enabled applications. Perhpaps these techniques could be of some help.

E.g. mplayer padds the missing data with zeroes for AC3/DTS passthrough. 
My AVR decoder does not seem to mind.

http://www.mplayerhq.hu/DOCS/tech/hwac3.txt

http://svn.mplayerhq.hu/mplayer/trunk/libmpcodecs/ad_hwac3.c?view=markup

Though I guess the zeroes would probably corrupt the MP3 stream.

Regards,

Pavel.
