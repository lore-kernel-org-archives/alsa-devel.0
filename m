From: Daniel Mack <zonque@gmail.com>
Subject: Re: USB audio devices on Audio 4DJ and similar
Date: Wed, 11 Apr 2012 17:17:23 +0200
Message-ID: <4F85A083.2020302@gmail.com>
References: <201204062209.21564.gineera@aspect135.co.uk>
	<4F819CBD.2010809@gmail.com>
	<201204111159.18537.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FD76104388
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 17:17:33 +0200 (CEST)
Received: by bkwj10 with SMTP id j10so833903bkw.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2012 08:17:33 -0700 (PDT)
In-Reply-To: <201204111159.18537.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Alan,

On 11.04.2012 12:59, Alan Horstmann wrote:
> Thanks for your helpful replies; responses below.
> 
> On Sunday 08 April 2012 15:12, Daniel Mack wrote:
>> On 06.04.2012 23:09, Alan Horstmann wrote:
>>> At present I am involved with resolving some issues that have arisen from
>>> people using the Audio 4DJ interface with Portaudio, and I hoped it would
>>> be OK to check a few Alsa details with you?  Unfortunately I have limited
>>> experience of USB audio.
>>
>> What are those issues? Can you elaborate?
> 
> These are essentially issues in the way Portaudio interfaces; I am not 
> suggesting driver bugs etc, but in summary:
> 
> a) The Audio 4DJ uses fixed _BE format, almost uniquely AFAICT from grepping 
> driver source tree.  Portaudio at present requests formats in the host 
> platform endianness - so on a x86 PC an acceptable format is not available 
> from the 'hw' device.  Users seem reluctant to use 'plughw'.

Erm. Class compliant USB cards speak _LE formats only, and I'm not aware
of any hardware that is able to switch endianess on a run-time
configuration base. Does that mean PortAudio is unable to feed these
cards on BE hosts like PowerPC? Does the sound output endianess always
have to match the audio stream format? I certainly doubt that.

>From what I know, PortAudio is just a thin layer on top of ALSA and
other sound APIs to ease the pain of cross-platform development of audio
applications, right? What's wrong with letting ALSA convert the samples
for you then?

> b) Subdevices are not enumerated by Portaudio at present, and so only 2 of the 
> 4 channels can be accessed.  If the unit had presented a single 4-channel 
> device all the channels would have been available.

Ok, I see your problem, but certainly, PortAudio is the place to get
this fixed, not the driver.

>> The device itself implements 4 audio channels which are synced to each
>> other. In other words: the hardware is not able to only enable one of
>> them and leave the other ones paused or set sample rates individually.
>>
>> When I implemented the driver, it seem most logical to follow the way
>> the device denotes it channels though. The documentation and silk screen
>> presents them as pairs of stereo, and so the driver does the same thing.
> 
> I am just interested whether you think it would be possible for the driver to 
> be modified to support a single 4-ch device, perhaps through a module option?

Technically, it would certainly. But the problem is that there are quite
a number of applications out there using these devices and making their
assumptions about the implementation as it stands. So we won't accept a
patch that changes the behaviour of these cards for all users.

So clearly, the issues you're seeing are due to missing features in
PortAudio, and it should be fairly easy to add them there.


Daniel
