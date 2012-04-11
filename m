From: Daniel Mack <zonque@gmail.com>
Subject: Re: USB audio devices on Audio 4DJ and similar
Date: Wed, 11 Apr 2012 19:10:52 +0200
Message-ID: <4F85BB1C.20903@gmail.com>
References: <201204062209.21564.gineera@aspect135.co.uk>
	<201204111159.18537.gineera@aspect135.co.uk>
	<4F85A083.2020302@gmail.com>
	<201204111800.11300.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E886E104148
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 19:10:58 +0200 (CEST)
Received: by bkwj10 with SMTP id j10so936587bkw.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2012 10:10:58 -0700 (PDT)
In-Reply-To: <201204111800.11300.gineera@aspect135.co.uk>
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

On 11.04.2012 19:00, Alan Horstmann wrote:
> On Wednesday 11 April 2012 16:17, Daniel Mack wrote:
>> On 11.04.2012 12:59, Alan Horstmann wrote:
>>> These are essentially issues in the way Portaudio interfaces; I am not
>>> suggesting driver bugs etc, but in summary:
>>>
>>> a) The Audio 4DJ uses fixed _BE format, almost uniquely AFAICT from
>>> grepping driver source tree.  Portaudio at present requests formats in
>>> the host platform endianness - so on a x86 PC an acceptable format is not
>>> available from the 'hw' device.  Users seem reluctant to use 'plughw'.
>>
>> Erm. Class compliant USB cards speak _LE formats only, and I'm not aware
>> of any hardware that is able to switch endianess on a run-time
>> configuration base.
> 
> Are you referring to USB cards?  It looked to me like several PCI cards listed 
> _BE and _LE variants of some formats in the driver?

Might be that there is hardware out there that lets the driver stack
choose the audio format, but you can't rely on it. And from a hardware
engineer's perspective, this is probably not easy to do in hardware, as
the streaming code is likely implemented in programmable logic that is
not that versatile.

>> From what I know, PortAudio is just a thin layer on top of ALSA and
>> other sound APIs to ease the pain of cross-platform development of audio
>> applications, right? What's wrong with letting ALSA convert the samples
>> for you then?
> 
> That has been my perspective too, to use 'plughw' but some audio users believe 
> the plug layer will necessarily give worse latency etc, and always want to 
> get "as close as possible to the hardware".

Understood. But then you would at least need to take care for endianess
format conversions and maybe even zero-padding in PortAudio.

>> Ok, I see your problem, but certainly, PortAudio is the place to get
>> this fixed, not the driver.
> 
> Yes, but listing all subdevices does have it's own problems, as some cards 
> have large numbers of them, for some reason.

The problem is probably which substreams to export to the user-API. But
the PortAudio core should certainly be capable of handling subdevices.

>> So clearly, the issues you're seeing are due to missing features in
>> PortAudio, and it should be fairly easy to add them there.
> 
> Well, I don't think it will be easy in fact, due to the constraints of a 
> multi-platform API that is largely shaped by platforms other than Alsa, but 
> it should be resolved in Portaudio, one way or another.
> 
> Thanks for your assistance,

No problem :) Let me know if I can help any further.


Daniel
