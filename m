From: Chris Cavey <chris-alsa@rauros.net>
Subject: Re: M-Audio FastTrack C400
Date: Sat, 21 Apr 2012 12:07:37 -0400
Message-ID: <4F92DB49.8040502@rauros.net>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F911629.5090704@gmail.com>
	<4F920D73.7070309@rauros.net>
	<CAFz=ag4viHQ-K7qbpCk-G+H3Q8GKe=7-anfOeCy3jhUCYUJ5BQ@mail.gmail.com>
	<CACckToUVQu=p0ZSaGw-oRn2ASgfQ_Po2im1ha5-yUVeyt7JUaQ@mail.gmail.com>
Reply-To: chris-alsa@rauros.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vms173001pub.verizon.net (vms173001pub.verizon.net
	[206.46.173.1]) by alsa0.perex.cz (Postfix) with ESMTP id 8848224958
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Apr 2012 18:08:18 +0200 (CEST)
Received: from rauros.net ([unknown] [74.107.69.179])
	by vms173001.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M2U00L7A7GU4L92@vms173001.mailsrvcs.net> for
	alsa-devel@alsa-project.org; Sat, 21 Apr 2012 11:07:43 -0500 (CDT)
In-reply-to: <CACckToUVQu=p0ZSaGw-oRn2ASgfQ_Po2im1ha5-yUVeyt7JUaQ@mail.gmail.com>
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

speaker-test plughw:C400 got me further but complains still

Setting of hwparams failed: Invalid argument

 From the manual:

2 analog mono inputs, 1 stereo SPDIF gives a total 4 inputs
4 analog mono outputs, 1 stereo SPDIF gives a total 6 outputs

Does SPDIF factor into channels?

I noticed, the endpoint attributes are slightly different that the FTU. 
Could this be an issue? I'm also guessing that the mixer lacking 
channels is probably an issue. I wonder if the some the FTU mixer 
"workarounds" may fit.

On 4/21/2012 5:19 AM, Grant Diffey wrote:
>>> (channels = 2, ifnum = 2).
>>
>> Why do you use channels=2. As fas as I can tell the device has 6
>> channels. Try that.
>>
>>
>>> Except I can't get it to play anything (figure it would all be too good
>>> to be true)
>>>
>>> $ speaker-test -Dfront:C400
>>> speaker-test 1.0.25
>>>
>>> Playback device is front:C400
>>> Stream parameters are 48000Hz, S16_LE, 1 channels
>>> Using 16 octaves of pink noise
>>> Sample format not available for playback: Invalid argument
>>> Setting of hwparams failed: Invalid argument
>>>
>>
>> The device probably supports only S24_3LE audio. At least that's what
>> you tell Alsa with the FTU quirk. Try to play something through the
>> corresponding hw device or use Jack or convert some audio file to
>> S24_3LE and play through aplay etc...
>>
>>
> that's a good point
>
> try speaker-test -D plughw:C400
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
