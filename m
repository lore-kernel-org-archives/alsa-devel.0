From: sdaau <sd-0eUWFqAKQRd/SzgSGea1oA@public.gmane.org>
Subject: AudioArduino - an ALSA soundcard driver for FTDI-based Arduinos
Date: Mon, 30 May 2011 06:41:08 +0200
Message-ID: <4DE31FE4.4040807@imi.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi all,

(cross-posting to alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org and 
gmane.linux.usb.general/linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; apologies if it's 
inappropriate)


I'd just like to inform that the AudioArduino project has been posted 
online:

http://imi.aau.dk/~sd/phd/index.php?title=AudioArduino

It contains links to open-source Arduino microcontroller code, and 
corresponding ALSA driver source code - which can demonstrate mono, 
full-duplex, 8-bit / 44.1 kHz soundcard operation on an FTDI-based Arduino.

There is also a related post on the (new) Arduino Forum:
http://arduino.cc/forum/index.php/topic,62582.0.html


The driver essentially represents an ALSA extension to ftdi-sio (which 
is why I thought it would be relevant to both alsa-devel, and 
linux-usb). Many thanks to the community for critical help, like in:

ftdi_sio, and usb_serial->interface->dev->driver_data being null
http://comments.gmane.org/gmane.linux.usb.general/30455

Help with dummy.c (where/how to write?)
http://comments.gmane.org/gmane.linux.alsa.devel/74487


Looking forward to any feedback regarding this project,

Cheers!

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
