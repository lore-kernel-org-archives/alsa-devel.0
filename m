From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Jack sensing in snd_usb_audio ?
Date: Wed, 12 Oct 2016 07:10:11 +0200
Message-ID: <1476249011.6699.15.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hey,

I recently bought some cheap USB soundcards for a computer that doesn't
have any audio output other than through the HDMI output, and the
screen I'm attaching doesn't have an audio output.

So I'm looking to plug in 2 of those USB soundcards, and switch between
them depending on whether I'm using headphones, or want to use the
standalone speaker.

Obviously, it would be so much nicer if I didn't have to switch between
the outputs by hand, and ignored the "headphones" sound card when not
plugged in.

My questions are:
- does the USB audio driver support jack sensing?
- is this something standard that's just not implemented yet? In which
case, I'd be up for at least trying, given specs.
- or is it something that depends on the device, and in which case, how
would I find out?

Some details about the device itself below.

Cheers

/proc/asound/cards:
 4 [Device         ]: USB-Audio - USB Audio Device
                      GeneralPlus USB Audio Device at usb-0000:00:14.0-9, full speed

$ amixer -c 4
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 30
  Mono:
  Front Left: Playback 16 [53%] [-21.00dB] [on]
  Front Right: Playback 16 [53%] [-21.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined cvolume cvolume-joined pswitch
pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: Playback 0 - 14 Capture 0 - 30
  Mono: Playback 1 [7%] [-10.50dB] [off] Capture 26 [87%] [27.00dB]
[on]
Simple mixer control 'Auto Gain Control',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
