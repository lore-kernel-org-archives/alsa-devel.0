From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: support for hardware encode/decode of compressed
 formats
Date: Sat, 05 Apr 2008 13:26:40 +1300
Message-ID: <47F6C740.4020108@audioscience.com>
References: <1207330707.1496.199.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BBE0248F7
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Apr 2008 02:26:46 +0200 (CEST)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JYT00K3NT8HXW30@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Sat, 05 Apr 2008 13:26:42 +1300 (NZDT)
In-reply-to: <1207330707.1496.199.camel@razman>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Tobin Davis wrote:
> Are there any alsa supported sound cards that do hardware audio decoding
> for MP3/WMA and otehr formats?  I'd like to look at the mechanism used
> to connect the cards to the data stream.

This has come up a couple of times recently.

Todays answer is that ALSA has no support for getting the encoded data 
through to the cards.

We are interested in this and would like to see it happen because our 
cards do support MP2 and MP3 decode and encode in DSP on the cards.

Applications wanting to use this capability currently must use our HPI 
driver directly (the primary example on Linux is Rivendell radio 
automation software http://www.rivendellaudio.org)

One assumption that alsa makes is that a "period" equates to a fixed 
amount of time, and a fixed amount of audio data.  This is not the case 
for Variable bitrate mpeg etc.  And even with fixed bitrate, the bits 
per sample is fractional E.g. 128kbps/44.1k = 2.90249... bits per sample 
frame.

One of the two assumptions about the period would have to be relaxed to 
allow alsa to maybe work with compressed data. Probably the time one.
I.e. a period means the decoder has consumed X bytes, but this doesn't 
correspond to any particular amount of time.


regards


Eliot Blennerhassett                       *:-{)>
AudioScience, Inc. (New Zealand Office)
<http://www.audioscience.com>
