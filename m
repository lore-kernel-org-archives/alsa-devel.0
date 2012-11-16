From: Daniel Griscom <griscom@suitable.com>
Subject: Re: USB hardware that supports implicit feedback?
Date: Thu, 15 Nov 2012 21:39:15 -0500
Message-ID: <p06240807cccb56d116e2@[192.168.1.12]>
References: <p06240805cccafc72f23b@[192.168.1.36]>
 <alpine.LNX.2.00.1211152158440.2632@xoschi>
 <p06240809cccb09820207@[192.168.1.8]> <50A57933.9070607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway07.websitewelcome.com (gateway07.websitewelcome.com
 [69.56.216.30]) by alsa0.perex.cz (Postfix) with ESMTP id 3CCA6265D33
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 03:39:20 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway07.websitewelcome.com (Postfix) with ESMTP id 2D9E4815858B0
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 20:39:18 -0600 (CST)
In-Reply-To: <50A57933.9070607@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Eldad Zack <eldad@fogrefinery.com>, Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

At 7:22 AM +0800 11/16/12, Daniel Mack wrote:
>Hi Daniel,
>Hi Elad,
>
>On 16.11.2012 05:32, Daniel Griscom wrote:
>>  At 10:02 PM +0100 11/15/12, Eldad Zack wrote:
>>>  Hi Daniel,
>>>
>>>  On Thu, 15 Nov 2012, Daniel Griscom wrote:
>>>>   I'm having trouble getting implicit feedback working with my custom
>>>>   capture/playback USB audio class device, even with the latest kernel. I
>>>>   presume it's a problem with my device's configuration, but 
>>>>can't figure out
>>>>   exactly what the problem is (after a whole lotta investigation).
>>>
>>>  What exactly doesn't work?
>>
>>  The audio output stream (from the computer to my device) runs at a
>>  few frames per second higher or lower rate than that of the input
>>  stream (from my device to the computer). The actual difference seems
>>  to be stable on a specific machine, but varies greatly between
>>  machines (I've seen differences from +7fps to -2fps; I presume this
>>  is due to differences in CPU clock frequencies).
>
>So you're saying that this is what you experience after you added code
>to make the driver use the implicit feedback mechanism? Over which time
>did you measure this and how exactly? Because frankly, I doubt that -
>the data rate is purely derived from the number of incoming samples.

This has been the case for a while; we started work with ALSA 1.0.23, 
but upgrading to kernel 3.6.6 (with included ALSA code) didn't change 
anything. We have yet to do any patching of ALSA for this matter.

>Does your device demand the same number of *bytes* or samples/channel to
>be sent?

I'll have to check that.

>  >>  > Is there any commercial USB hardware out there that supports implicit
>>>>   feedback? I assume the ALSA developers are testing against 
>>>>something, but I
>>>>   can't find anything appropriate.
>>>
>>>  I'm not an ALSA dev, but I recently posted a series of patches for the
>>>  M-Audio Fast Track C400, which uses the implicit feedback code that was
>>>  already in the tree for other devices.
>
>Yes, sorry for not responding. I've seen this, but didn't have time yet
>to respond. Thanks for doing this.
>
>>  So, this device uses implicit feedback to tell ALSA to send output
>>  data at the same rate as its input data? Very cool; I've ordered one
>>  to test.
>
>The code I wrote for implicit feedback is used by the M-Audio FTU
>devices,

So, with an FTU the implicit feedback code works? What version of 
kernel/ALSA should I use - the latest?

>  although I would actually not recommend buying one.

Too late...

>  >> Take a look at sound/usb/pcm.c, there are quite a few hints to how this
>>>  is discovered currently.
>>
>>  We've been looking there already, but will dig deeper.
>
>I might help if you posted a patch with the changes you made to support
>your device.

No such patch.

>  >        AudioStreaming Interface Descriptor:
>>           bLength                17
>>           bDescriptorType        36
>>           bDescriptorSubtype      2 (FORMAT_TYPE)
>>           bFormatType             1 (FORMAT_TYPE_I)
>>           bNrChannels             2
>>           bSubframeSize           2
>>           bBitResolution         16
>>           bSamFreqType            3 Discrete
>>           tSamFreq[ 0]        32000
>>           tSamFreq[ 1]        44100
>>           tSamFreq[ 2]        48000
>>         Endpoint Descriptor:
>>           bLength                 9
>>           bDescriptorType         5
>>           bEndpointAddress     0x82  EP 2 IN
>>           bmAttributes           37
>>             Transfer Type            Isochronous
>>             Synch Type               Asynchronous
>>             Usage Type               Implicit feedback Data
>
>Note that I never tested the automatic discovery of that mode. The
>device I wrote the code for doesn't announce it that way, and so a quirk
>was needed in pcm.c to make it happen. Ideally though, what you did is
>the right thing to do, just just need to make sure the driver really
>obeys that setting :)

Well, that's good to know anyway.


Lots to think about, and thanks,
Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
