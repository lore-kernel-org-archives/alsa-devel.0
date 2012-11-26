From: Daniel Mack <zonque@gmail.com>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Mon, 26 Nov 2012 08:19:28 +0100
Message-ID: <50B31800.2000000@gmail.com>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]> <50AE99E7.6080008@gmail.com>
 <p06240802ccd72a8f5c3e@[192.168.1.12]> <50B21255.8080202@gmail.com>
 <p06240812ccd8489d6378@[192.168.1.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 35BA326167C
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 08:19:36 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so4145234bkc.38
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2012 23:19:35 -0800 (PST)
In-Reply-To: <p06240812ccd8489d6378@[192.168.1.12]>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Griscom <griscom@suitable.com>
Cc: Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 25.11.2012 23:23, Daniel Griscom wrote:
> At 1:43 PM +0100 11/25/12, Daniel Mack wrote:
>> Please do another test and change prepare_outbound_urb() so that instead
>> of calling ep->prepare_data_urb() to fill the URB, fill it directly with
>> some sort of easily recognizable test pattern (you can take the code
>>from "silence" case to access the buffers). Some kind of 16-bit counter
>> should do. And then check the payload with the Beagle and see whether
>> the pattern has gaps.
>>
>> This test will tell us whether data is in fact lost before it hits the
>> usb audio driver, or if it's dropped by the USB HCD.
> 
> I did the test, and expected to either a) see the incrementing data 
> be contiguous even though the USB packet transmission was stuttering, 
> or b) see the incrementing data have gaps where the "missing" packets 
> were. However, what I saw was c): the USB packets never misbehaved.
> 
> Here's the code I used in /usb/endpoint.c, prepare_outbound_urb():
> 
>> 	static short left = 0;
>> 	static short right = 0x0404;
>> 	short *sp;
> 
> ...
> 
>> 		if (ep->prepare_data_urb) {
>> #if 1
>> 			ep->prepare_data_urb(ep->data_subs, urb);
>> #else
>> 		  /* Fake constantly increasing samples */
>> 		  unsigned int offs = 0;
>> 		  for (i = 0; i < ctx->packets; ++i) {
>> 		      int counts;
>>
>> 		      if (ctx->packet_size[i])
>> 			counts = ctx->packet_size[i];
>> 		      else
>> 			counts = snd_usb_endpoint_next_packet_size(ep);
>>
>> 		      urb->iso_frame_desc[i].offset = offs * ep->stride;
>> 		      urb->iso_frame_desc[i].length = counts * ep->stride;
>> 		      offs += counts;
>> 		  }
>>
>> 		  urb->number_of_packets = ctx->packets;

Note that this is a potential difference between your two cases.

prepare_playback_urb() from pcm.c will not always set
urb->number_of_packets to the maximum value but cut packets short at PCM
period boundaries.

Could you move your pattern generating code down to that function? Just
look for the memcpy() calls there.


Daniel
