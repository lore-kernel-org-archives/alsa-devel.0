From: Daniel Griscom <griscom@suitable.com>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Sat, 24 Nov 2012 22:33:33 -0500
Message-ID: <p06240802ccd72a8f5c3e@[192.168.1.12]>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]> <50AE99E7.6080008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway16.websitewelcome.com (gateway16.websitewelcome.com
 [70.85.130.5]) by alsa0.perex.cz (Postfix) with ESMTP id 59C3D264F34
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2012 04:33:39 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway16.websitewelcome.com (Postfix) with ESMTP id 2F1A37AB6CAD5
 for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2012 21:33:28 -0600 (CST)
In-Reply-To: <50AE99E7.6080008@gmail.com>
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
Cc: Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear Daniel,

To take your second email first:

At 10:32 PM +0100 11/22/12, Daniel Mack wrote:
>On 21.11.2012 21:13, Daniel Griscom wrote:
>> On to the next problem we're having with our USB audio card. Recap:
>> simple USB Audio Class embedded stereo audio card, running at 44.1kHz
>> or 48kHz, using the 3.6.6 kernel and its associated ALSA modules to
>> drive it, running on Jetway ND9D-2700, with an Atom D2700 and NM10
>> chipset. Output of "sudo lsusb -v" for card is appended below.
>>
>> Problem: we're experiencing strange hiccups in the delivery of audio
>> from the motherboard to the card. At 48kHz, the motherboard should
>> send a 6-frame packet to the card once per high-speed microframe
>> (every 125us). This usually works, but sometimes there are two
>> closely related failures:
>>
>> 1) Once in a while (every few seconds or minutes) a single packet
>> will be missed
>>
>> 2) Once in a longer while (every few minutes or hours), the system
>> will go into a continuing error condition where three of every eight
>> packets are missed.
>>
>> In both cases, "missed" means that ALSA consumes the output audio
>> from my motherboard application, but never sends a packet to the
>> audio card. No USB errors, no logged messages; it just disappears.
>
>I missed that detail before. What makes you so sure ALSA actually
>consumes audio it never sends out? Are you sending a test pattern which
>is interrupted in your USB analyzer traces?

Great idea, and it took me a few days to be able to do it (too much turkey to be dealt with). The answer is yes: ALSA is consuming data that doesn't make it onto the USB bus.

My app is completely clocked by ALSA, sending out whatever the ALSA output stream will accept, and taking in whatever the ALSA input stream will offer. I set my app to output stereo triangle waves (in different frequencies), captured the data with the Beagle 1200, and then graphed it as a function of sample count. When things were running fine, the graph looked nice and clean. When the packets were being lost, both lines in the graph periodically jump, skipping values. The sizes of the jumps alternate, matching the pattern I cited where in each set of eight microframes two adjacent frames are skipped, and then a single frame is skipped.

If ALSA hadn't taken the data, my app would just wait until it did, with no data lost (although the output graph would still be bad as a function of time). So, ALSA (or something deeper) must be discarding the data.


To respond to your first email:

At 10:01 PM +0100 11/22/12, Daniel Mack wrote:
>On 21.11.2012 21:13, Daniel Griscom wrote:
> > We've been chewing on this issue for a while. To me, it sounds like
>> this could only happen in the ALSA code where the stream of audio is
>> broken into individual USB packets. Unfortunately, I'm having a heck
>> of a time navigating the ALSA source code, and frankly have gotten no
>> traction at all.
>
>I guess the only reason for what you see is that
>snd_usb_endpoint_next_packet_size() returns an unusual value every time
>a packet is missing, and question is why.

I went into sound/usb/pcm.c, function prepare_playback_urb(). The loop that prepares the URBs begins by determining the size of the next packet:

>if (ctx->packet_size[i])
>	counts = ctx->packet_size[i];
>else
>	counts = snd_usb_endpoint_next_packet_size(ep);

Immediately afterwards, I added:

>snd_printk(KERN_ERR "usbaudio/prepare_playback_urb: %d, %d, %d\n",
>	   i, ctx->packet_size[i], counts);

The result, whether or not the USB packets were being lost, was:

>[   64.910851] ALSA sound/usb/pcm.c:1065 usbaudio/prepare_playback_urb: 1, 0, 6
>[   64.910855] ALSA sound/usb/pcm.c:1065 usbaudio/prepare_playback_urb: 2, 0, 6
>[   64.911336] ALSA sound/usb/pcm.c:1065 usbaudio/prepare_playback_urb: 0, 0, 6
>[   64.911341] ALSA sound/usb/pcm.c:1065 usbaudio/prepare_playback_urb: 1, 0, 6
>[   64.911345] ALSA sound/usb/pcm.c:1065 usbaudio/prepare_playback_urb: 2, 0, 6
>[   64.911364] ALSA sound/usb/pcm.c:1065 usbaudio/prepare_playback_urb: 0, 0, 6

Even when packets were lost, eight URBs per millisecond were being prepared (6 frames each => 48kHz audio). So, the packets are being lost somewhere later in the process.


What else should I look at? Personally, I'm still fixating on that rigid pattern of missed packets, with three of every eight missing in a repeating "FFFF--F-" pattern. That's gotta mean something, although darned if I know what.


Thanks for the continuing help,
Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
