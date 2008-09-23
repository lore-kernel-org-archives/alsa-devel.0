From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Some idea about usb audio gadget driver.
Date: Tue, 23 Sep 2008 17:50:33 +0800
Message-ID: <386072610809230250w2e43c20ei89076a8db62c5044@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ALSA devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi ALSA and USB folks,

I plan to develop a usb audio gadget driver on Blackfin platform (can
be shared for other embedded system).

 - A new usb gadget driver which recognized by Linux/Windows PC as an
USB audio card.
 - There is an ALSA sound card on the same embedded device.
 - The usb gadget driver receives audio data from host and send them
to ALSA sound card to playback
 - The usb gadget driver send the audio data recorded by ALSA sound
card to host as recording.
 - The usb gadget driver response to some audio card control command
such as volume/mute control

Questions,

 - Is there any similar things on this planet?
 - How about gmidi usb midi gadget driver?
 - How can I open/playback/record/close a ALSA sound card in kernel
space not using alsalib in user space?

Thanks a lot
-Bryan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
