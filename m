From: Smilen Dimitrov <sd-0eUWFqAKQRd/SzgSGea1oA@public.gmane.org>
Subject: Re: AudioArduino - an ALSA soundcard driver for FTDI-based Arduinos
Date: Mon, 30 May 2011 22:37:57 +0200
Message-ID: <4DE40025.4010108@imi.aau.dk>
References: <4DE31FE4.4040807@imi.aau.dk> <4DE3EF4A.7090306@blueyonder.co.uk>
Reply-To: sd-0eUWFqAKQRd/SzgSGea1oA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DE3EF4A.7090306-QgLWrMLu8clzjhtm8Ag3mw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sboyce-QgLWrMLu8clzjhtm8Ag3mw@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Sid,

> Are there any possibilities of extending it beyond 8-bit / 44.1 kHz?

The driver currently exposes a stereo, 16-bit, 44.1 kHz on the ALSA 
side, since that is the lowest quality with which Audacity works in the 
playback direction.

However, Arduino Duemillanove's ATMega328 is not really capable of 
16-bit reproduction in this context: it has one 16-bit and two 8-bit 
counters, and the 16-bit one is used to derive the 44.1 kHz (PCM) rate, 
so the only thing available for PWM (analog) reproduction are the 8-bit 
counters (there is a bit more on this in the paper on the webpage).

So what happens during stereo, 16-bit, 44.1 kHz playback, is that the 
driver simply extracts the MSB of the left channel, and sends it as an 
8-bit sample representation to the Arduino for PWM reproduction.

So in brief - as far as ALSA interfaces are concerned, I believe it is 
possible to specify any rate you want (which is supported) - however, 
"by default", it would be easy to only get 8-bit resolution (hardware) 
reproduction on the Arduino (however, higher rates should in principle 
be possible; as I think there should still some of bandwidth left, since 
a duplex operation can be demonstrated at 2Mbps).


Hope this helps,
Cheers!





> Regards
> Sid.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
