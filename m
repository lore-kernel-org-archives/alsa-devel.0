From: Brian Heung <bheung@berkeley.edu>
Subject: Re: gstreamer distortion w/ thinkpad buttons (tpb) polling nvram
 (CS46xx new DSP)
Date: Mon, 26 Apr 2004 18:47:47 -0700
Sender: gstreamer-devel-admin@lists.sourceforge.net
Message-ID: <408DBBC3.20109@berkeley.edu>
References: <Pine.A41.4.44.0404261047270.31198-100000@public.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <gstreamer-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.A41.4.44.0404261047270.31198-100000@public.uni-hamburg.de>
Errors-To: gstreamer-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/gstreamer-devel>,
	<mailto:gstreamer-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:gstreamer-devel@lists.sourceforge.net>
List-Help: <mailto:gstreamer-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/gstreamer-devel>,
	<mailto:gstreamer-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=gstreamer-devel>
To: Benjamin Otte <in7y118@public.uni-hamburg.de>
Cc: gstreamer-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Anyone in alsa-devel have any ideas/clues for this bug? Should I file it 
there?

On Apr 26, 2004, at 1:51 AM, Benjamin Otte wrote:

> On Sun, 25 Apr 2004, Brian Heung wrote:
>
>> I'm not sure if this is a bug or not. In both the 0.6 and 0.8 
>> releases,
>> osssink output is distorted when TPB (Thinkpad Buttons) is running. 
>> TPB
>> is a program that polls /dev/nvram for changes when using extra 
>> builtin
>> buttons on IBM Thinkpads.
>>
>> If I set TPB to a longer polling period, the distortion is minimized,
>> although it doesn't disappear. This only occurs with osssink and not
>> alsasink or esdsink.
>>
>> Is this a bug?
>>
> It's definitely a bug. The interesting question is who is responsible 
> for
> this bug?
> If it only happens with GStreamer/OSS combo and not with other OSS 
> using
> apps and if it happens on any kernel, it's pretty likely that we're at
> fault. It doesn't hurt to file this as a bug in our bugzilla though I
> don't think anybody from the GStreamer team has a Thinkpad so it's not
> very likely that we can do something about it.
>
> Benjamin

I did some more testing on this problem. It only appears with the
GStreamer/OSS combo when using the cs46xx Alsa driver with OSS
emulation. Specifically, it only occurs on the "New DSP support"
option. The new DSP enables SPDIF and dual codecs but I only use it for
the hardware mixer.

I tested using the old DSP and OSS drivers and the problem did not
appear. No other OSS applications cause the problems using the New DSP 
either.

Brian


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
