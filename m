From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2] USB audio gadget driver
Date: Wed,  3 Jun 2009 09:17:56 -0400
Message-ID: <1244035078-1775-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This is largely a PoC in case people are looking for this kind of thing and
want to build upon something.  Just throwing it out there at this point.

Bryan Wu (2):
  USB: audio: add USB audio class definitions
  USB: gadget: add USB Audio Gadget driver

 drivers/usb/gadget/Kconfig   |   14 +
 drivers/usb/gadget/Makefile  |    2 +
 drivers/usb/gadget/audio.c   |  302 ++++++++++++++++++
 drivers/usb/gadget/f_audio.c |  707 ++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/u_audio.c |  319 +++++++++++++++++++
 drivers/usb/gadget/u_audio.h |   56 ++++
 include/linux/usb/audio.h    |  265 ++++++++++++++++-
 7 files changed, 1663 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/gadget/audio.c
 create mode 100644 drivers/usb/gadget/f_audio.c
 create mode 100644 drivers/usb/gadget/u_audio.c
 create mode 100644 drivers/usb/gadget/u_audio.h

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
