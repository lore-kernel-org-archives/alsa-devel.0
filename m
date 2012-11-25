From: Daniel Griscom <griscom@suitable.com>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Sun, 25 Nov 2012 17:23:20 -0500
Message-ID: <p06240812ccd8489d6378@[192.168.1.12]>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]>
 <50AE99E7.6080008@gmail.com> <p06240802ccd72a8f5c3e@[192.168.1.12]>
 <50B21255.8080202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway15.websitewelcome.com (gateway15.websitewelcome.com
 [67.18.72.137]) by alsa0.perex.cz (Postfix) with ESMTP id 07B662615E8
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2012 23:23:25 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway15.websitewelcome.com (Postfix) with ESMTP id D536FB8E6B809
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2012 16:23:23 -0600 (CST)
In-Reply-To: <50B21255.8080202@gmail.com>
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

At 1:43 PM +0100 11/25/12, Daniel Mack wrote:
>Please do another test and change prepare_outbound_urb() so that instead
>of calling ep->prepare_data_urb() to fill the URB, fill it directly with
>some sort of easily recognizable test pattern (you can take the code
>from "silence" case to access the buffers). Some kind of 16-bit counter
>should do. And then check the payload with the Beagle and see whether
>the pattern has gaps.
>
>This test will tell us whether data is in fact lost before it hits the
>usb audio driver, or if it's dropped by the USB HCD.

I did the test, and expected to either a) see the incrementing data 
be contiguous even though the USB packet transmission was stuttering, 
or b) see the incrementing data have gaps where the "missing" packets 
were. However, what I saw was c): the USB packets never misbehaved.

Here's the code I used in /usb/endpoint.c, prepare_outbound_urb():

>	static short left = 0;
>	static short right = 0x0404;
>	short *sp;

...

>		if (ep->prepare_data_urb) {
>#if 1
>			ep->prepare_data_urb(ep->data_subs, urb);
>#else
>		  /* Fake constantly increasing samples */
>		  unsigned int offs = 0;
>		  for (i = 0; i < ctx->packets; ++i) {
>		      int counts;
>
>		      if (ctx->packet_size[i])
>			counts = ctx->packet_size[i];
>		      else
>			counts = snd_usb_endpoint_next_packet_size(ep);
>
>		      urb->iso_frame_desc[i].offset = offs * ep->stride;
>		      urb->iso_frame_desc[i].length = counts * ep->stride;
>		      offs += counts;
>		  }
>
>		  urb->number_of_packets = ctx->packets;
>		  urb->transfer_buffer_length = offs * ep->stride;
>		  for (i = 0, sp = (short *)(urb->transfer_buffer);
>		       i < offs * ep->stride; /* no increment */) {
>		    *sp++ = left++;
>		    i += sizeof(short);
>		    *sp++ = right++;
>		    i += sizeof(short);
>		  }
>#endif
>		} else {

With the "#if 1", the code is stock, and about 30% of my tests 
resulted in the stuttering USB packets (but with data from my 
application). With it changed to "#if 0", I generated and saw the 
incrementing data, but the USB packets never misbehaved (even after 
more than 20 tries). I switched back and forth, and the problem 
clearly appeared and disappeared.

I think I should give more information about my tests. This problem 
is very intermittent, and difficult to reproduce. However, I found a 
case where it often happens: at boot, where my app starts up right 
about when the USB devices are starting up. So, each of the "tests" 
above consisted of me rebooting my system and watching the Beagle's 
trace for good versus bad packet patterns.


Thanks again for the continuing help,
Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
