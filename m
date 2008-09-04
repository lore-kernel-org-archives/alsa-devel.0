From: William Estrada <MrUmunhum@popdial.com>
Subject: Re: Using GDB for ALSA How to?
Date: Thu, 04 Sep 2008 15:11:50 -0700
Message-ID: <48C05D26.9020005@popdial.com>
References: <48BC4E6A.1070508@popdial.com> <20080901202407.GL15719@lug-owl.de>
	<48BC5198.1050906@popdial.com> <20080901211326.GM15719@lug-owl.de>
	<20080902070836.GO15719@lug-owl.de>
Reply-To: MrUmunhum@popdial.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FC39244AC
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 00:11:52 +0200 (CEST)
In-Reply-To: <20080902070836.GO15719@lug-owl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jan,

  I have several programs that use the ALSA interface, most work the way 
they are supposed to.
The one that require real time record and then play back are not working 
the way I want them
to,   There is a 4.09 second delay in the read interrupt. I think it is 
because the period value
of the handle is not being saved correctly? So I wrote a test program to 
try and debug my
problem. It would be helpful if these structures where not hidden.

  I wrote a test program to try and debug my problem. From the output I 
can see that the data
in the handle is getting messed up? I am not sure if this is another 
programming problem with
in the display program (status.c)? The program works but the delay makes 
it unusable for my application.
'show_1' and 'show_2' are the same code just compiled differently.

 The program(s) are
here: http://64.124.13.3/_ALSA_ along with the source. The output 
<64.124.13.3/_ALSA_>of show_1 is:
> $ ./show_1
> 14:37:52.266 Display_Audio_From_Function
> Device: 8c477b8
> PCM Device name = 'default'         PCM state         = PREPARED
> access type     = MMAP_NONINTERLEAV format            = 'U8' (Unsigned 
> 8 bit)
> subformat       = 'STD' (Standard)  channels          = 1
> rate            = 8000 bps          period time       = 10000 us
> period size     = 80 frame          buffer time       = 8192000 us
> buffer size     = 65536 frames      periods/buffer    = 819 frames
> exact rate      = 8000/1 bps        significant bits  = 8000
> is batch        = 0                 is block transfer = 1
> is double       = 0                 is half duplex    = 0
> is joint duplex = 0                 can overrange     = 0
> can mmap        = 1                 can pause         = 0
> can resume      = 1                 can sync start    = 1
> --------------------------------------------------------------------------------
> Device: 8c47b00
> PCM Device name = 'default'         PCM state         = PREPARED
> access type     = MMAP_NONINTERLEAV format            = 'U8' (Unsigned 
> 8 bit)
> subformat       = 'STD' (Standard)  channels          = 1
> rate            = 8000 bps          period time       = 10000 us
> period size     = 80 frame          buffer time       = 8192000 us
> buffer size     = 65536 frames      periods/buffer    = 819 frames
> exact rate      = 8000/1 bps        significant bits  = 8000
> is batch        = 0                 is block transfer = 1
> is double       = 0                 is half duplex    = 0
> is joint duplex = 0                 can overrange     = 0
> can mmap        = 1                 can pause         = 0
> can resume      = 1                 can sync start    = 1
> --------------------------------------------------------------------------------
> 14:37:52.267 Voice On
> 14:37:52.267 Display_Audio_After_Function_Return
> Label: In, Device: 8c477b8
> PCM Device name = 'default'         PCM state         = PREPARED
> access type     = (null)            format            = 'FLOAT_LE' 
> (Float 32 bit Little Endian)
> subformat       = 'STD' (Standard)  channels          = 0
> rate            = 0 bps             period time       = -1081229612 us
> period size     = 80 frame          buffer time       = 0 us
> buffer size     = 0 frames          periods/buffer    = -1081229612 frames
> exact rate      = 0/-1081229612 bps significant bits  = 0
> is batch        = 0                 is block transfer = 1
> is double       = 0                 is half duplex    = 0
> is joint duplex = 0                 can overrange     = 0
> can mmap        = 0                 can pause         = 0
> can resume      = 1                 can sync start    = 1
> --------------------------------------------------------------------------------
> Label: Out, Device: 8c47b00
> PCM Device name = 'default'         PCM state         = PREPARED
> access type     = (null)            format            = 'FLOAT_LE' 
> (Float 32 bit Little Endian)
> subformat       = 'STD' (Standard)  channels          = 0
> rate            = 0 bps             period time       = -1081229612 us
> period size     = 80 frame          buffer time       = 0 us
> buffer size     = 0 frames          periods/buffer    = -1081229612 frames
> exact rate      = 0/-1081229612 bps significant bits  = 0
> is batch        = 0                 is block transfer = 1
> is double       = 0                 is half duplex    = 0
> is joint duplex = 0                 can overrange     = 0
> can mmap        = 0                 can pause         = 0
> can resume      = 1                 can sync start    = 1
> --------------------------------------------------------------------------------
> 14:37:52.284 Starting Callback
> 14:37:52.284 Sleep 5
> 14:37:56.380 Enter Callback
> Label: Callback, Device: 8c477b8
> PCM Device name = 'default'         PCM state         = RUNNING
> access type     = (null)            format            = 'FLOAT_LE' 
> (Float 32 bit Little Endian)
> subformat       = 'STD' (Standard)  channels          = 0
> rate            = 0 bps             period time       = -1081230956 us
> period size     = 80 frame          buffer time       = 0 us
> buffer size     = 0 frames          periods/buffer    = -1081230956 frames
> exact rate      = 0/-1081230956 bps significant bits  = 0
> is batch        = 0                 is block transfer = 1
> is double       = 0                 is half duplex    = 0
> is joint duplex = 0                 can overrange     = 0
> can mmap        = 0                 can pause         = 0
> can resume      = 1                 can sync start    = 1
> --------------------------------------------------------------------------------
> 14:37:56.381 Audio Ready: 32768
> 14:37:56.381 Voice 1
> 14:38:00.479 Exit Callback
> 14:38:00.479 Voice off
> 14:38:05.486
> Exiting
  If you have any ideas I would like to hear them.

  Thanks again for your time.


 Jan-Benedict Glaw wrote:
> On Mon, 2008-09-01 23:13:26 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
>> On Mon, 2008-09-01 13:33:28 -0700, William Estrada <MrUmunhum@popdial.com> wrote:
>>> Jan-Benedict Glaw wrote:
>>>> On Mon, 2008-09-01 13:19:54 -0700, William Estrada <MrUmunhum@popdial.com> wrote:
>>>>>   I am trying to use GDB with my ALSA program. I wish to display (print) 
>>>>> a handle for
>>>>> an snd_pcm_t pointer. I am getting the following error:
>>>>>     
>>>>>> (gdb) p Device
>>>>>> $9 = (snd_pcm_t *) 0x92be458
>>>>>> (gdb) p *Device
>>>>>> $10 = <incomplete type>
>>>>>   How do I display the snd_pcm_t structure?
>
> So... Looking at it, snd_pcm_t is willfully specified as a hidden
> struct, the real definition is only used where *really* needed, that
> is: inside libasound2. It's in pcm_local.h, to not allow an arbitrary
> user to easily fiddle with the lib's internal state.
>
> As you want to peek into it, I guess you're facing a problem
> somewhere. It would probably help if you describe your actual problem.
>
> MfG, JBG
>


-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum
