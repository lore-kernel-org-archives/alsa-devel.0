From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [LAD] [alsa-devel] Fw: Using loopback card to Connect GSM two
	way call	to the real sound card UDA1345TS
Date: Thu, 02 Apr 2015 11:43:17 +0200
Message-ID: <551D0F35.6010709@ladisch.de>
References: <1425878251963.1340@tataelxsi.co.in>
 <1425878360800.70892@tataelxsi.co.in>,
 <54FD552C.7020902@ladisch.de>,
 <1425922601141.50130@tataelxsi.co.in>
 <1425964490006.15084@tataelxsi.co.in>,
 <54FECC69.9020600@ladisch.de> <1427510661706.37789@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <1427510661706.37789-Ig93jE4/MIihbFNETrL9Qw@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-dev>,
 <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev/>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
 <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Sender: "Linux-audio-dev" <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
To: Srinivasan S <srinivasan.s-Ig93jE4/MIihbFNETrL9Qw@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org" <linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Srinivasan S wrote:
> CPU consumption is 18%, with above asound.conf & the app
> alsa_loopback_min_mono.c for establishing my GSM two way call (ie.,
> VINR to VOUTR & VINL to VOUTL) , this is very huge & I want to reduce
> this CPU consumption drastically, Is there any other ways in alsa where
> I can do this two way GSM call (ie., VINR to VOUTR & VINL to VOUTL)
> without using alsa_loopback_min_mono.c application

dmix needs more CPU than dshare because it needs to mix multiple streams
together; if possible, use dshare instead of dmix.

dshare needs more CPU than direct access to the device because the data
needs to be copied and reformatted.  dshare is needed only when the
application(s) cannot handle the format of the actual device; if
possible, change your application to handle the two-channel devices.

> And am hearing echo, when I do GSM calls when using the above attachd
> asound.conf & the app alsa_loopback_min_mono.c, could you please help
> me out is there any options to do echo cancellation in alsa?

ALSA has not built-in echo cancellation.  You have to implement this
yourself, or use some third-party library.

If dmix/dshare alone eats 18 % CPU, it is unlikely that this is feasible
without hardware support.

> Am trying to completely understand the above attched asound.conf, but
> am not still very clear w.r.t the understanding of bindings

"bindings.x y" or "bindings { x y }" maps channel x of this device to
channel y of the slave device.


Regards,
Clemens
