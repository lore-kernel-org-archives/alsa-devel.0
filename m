From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] Missing exactly 3 of 8 audio packets?
Date: Tue, 27 Nov 2012 12:48:00 +0100
Message-ID: <50B4A870.7040201@gmail.com>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]> <50AE99E7.6080008@gmail.com> <p06240802ccd72a8f5c3e@[192.168.1.12]> <50B21255.8080202@gmail.com> <p06240812ccd8489d6378@[192.168.1.12]> <50B31800.2000000@gmail.com> <p06240804ccd98cef996c@[192.168.1.8]>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <p06240804ccd98cef996c@[192.168.1.8]>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Griscom <griscom-yI/1Hl18UA1Wk0Htik3J/w@public.gmane.org>
Cc: Alsa Developer <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 26.11.2012 22:23, Daniel Griscom wrote:
> At 8:19 AM +0100 11/26/12, Daniel Mack wrote:
>> On 25.11.2012 23:23, Daniel Griscom wrote:
>>>  At 1:43 PM +0100 11/25/12, Daniel Mack wrote:
>>>>  Please do another test and change prepare_outbound_urb() so that instead
>>>>  of calling ep->prepare_data_urb() to fill the URB, fill it directly with
>>>>  some sort of easily recognizable test pattern (you can take the code
>>> >from "silence" case to access the buffers). Some kind of 16-bit counter
>>>>  should do. And then check the payload with the Beagle and see whether
>>>>  the pattern has gaps.
>>>>
>>>>  This test will tell us whether data is in fact lost before it hits the
>>>>  usb audio driver, or if it's dropped by the USB HCD.
>>>
>>>  I did the test, and expected to either a) see the incrementing data
>>>  be contiguous even though the USB packet transmission was stuttering,
>>>  or b) see the incrementing data have gaps where the "missing" packets
>>  > were. However, what I saw was c): the USB packets never misbehaved.
>> Note that this is a potential difference between your two cases.
>>
>> prepare_playback_urb() from pcm.c will not always set
>> urb->number_of_packets to the maximum value but cut packets short at PCM
>> period boundaries.
>>
>> Could you move your pattern generating code down to that function? Just
>> look for the memcpy() calls there.
> 
> OK, this time I got some real results. I can still get the USB packet 
> stream to misbehave, and indeed the synthesized data is being lost. 
> The output data present on the USB bus smoothly increments during 
> each packet, continuing smoothly in adjacent packets. But, when one 
> or two packets are missed, the next output data is numbered as if the 
> packets (6 stereo frames each) had been generated but lost.
> 
> Here's my code in linux-3.6.6/sound/usb/pcm.c, prepare_playback_urb():
> 
>> 	static short left = 0;
>> 	static short right = 0x0404;
>> 	short *sp;
> 
> ...
> 
>> 	bytes = frames * stride;
>> #define FAKE_DATA
>> #ifdef FAKE_DATA
>> 	for (i = 0, sp = (short *)(urb->transfer_buffer);
>> 	   i < bytes; /* no increment */) {
>> 		*sp++ = left++;
>> 		i += sizeof(*sp);
>> 		*sp++ = right++;
>> 		i += sizeof(*sp);
>> 	}
>> #else
>> 	if (subs->hwptr_done + bytes > runtime->buffer_size * stride) {
>> 		/* err, the transferred area goes over buffer boundary. */
>> 		unsigned int bytes1 =
>> 			runtime->buffer_size * stride - subs->hwptr_done;
>> 		memcpy(urb->transfer_buffer,
>> 		       runtime->dma_area + subs->hwptr_done, bytes1);
>> 		memcpy(urb->transfer_buffer + bytes1,
>> 		       runtime->dma_area, bytes - bytes1);
>> 	} else {
>> 		memcpy(urb->transfer_buffer,
>> 		       runtime->dma_area + subs->hwptr_done, bytes);
>> 	}
>> #endif
>> 	subs->hwptr_done += bytes;
> 
> Did I place the generation code in the correct location?

Yes.

> And, what should I look at next?

As Clemens said, check the error fields in the isochronous frames when
the urb is given back to the driver. For isochronous data, there's
nothing the driver can do about failed transmissions, hence there's no
code to handle such conditions. But it might help understand what's
going on.

In any case, this now certainly looks more like a strange USB problem,
rather than a bug in snd-usb. I copied the USB list. The thread starts here:


http://mailman.alsa-project.org/pipermail/alsa-devel/2012-November/057259.html


Daniel



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
