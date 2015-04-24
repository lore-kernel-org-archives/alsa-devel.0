From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [LAD] [alsa-devel] Fw: Using loopback card to Connect GSM two
	way call	to the real sound card UDA1345TS
Date: Fri, 24 Apr 2015 14:45:15 +0200
Message-ID: <553A3ADB.7040108@ladisch.de>
References: <1425878251963.1340@tataelxsi.co.in>
 <1425878360800.70892@tataelxsi.co.in>,
 <54FD552C.7020902@ladisch.de>,
 <1425922601141.50130@tataelxsi.co.in>	<1425964490006.15084@tataelxsi.co.in>,
 <54FECC69.9020600@ladisch.de>	<1427510661706.37789@tataelxsi.co.in>,
 <551D0F35.6010709@ladisch.de> <1427970980529.96067@tataelxsi.co.in>,
 <551D5B78.60703@ladisch.de> <1429683117651.11394@tataelxsi.co.in>,
 <5539F971.2030407@ladisch.de> <1429877130444.23317@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <1429877130444.23317-Ig93jE4/MIihbFNETrL9Qw@public.gmane.org>
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
> did you mean that , If I use Jack plugin , does it resolve this
> problem (ie., does the CPU consumption reduce drastically instead of
> dshare)

It is unlikely that running your two programs on top of Jack will use
less CPU than with dshare.  However, I don't know the details of your
architecture, so the only way to find out would be for you to try it.


Regards,
Clemens
