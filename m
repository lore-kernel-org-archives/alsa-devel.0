From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] usb-audio: Add mixer control for
 Digidesign Mbox 1 clock source
Date: Fri, 31 Oct 2014 12:29:22 +0900
Message-ID: <54530212.7000804@sakamocchi.jp>
References: <5452EC80.8060005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 35A2C260668
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 04:29:26 +0100 (CET)
In-Reply-To: <5452EC80.8060005@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Damien,

On Oct 31 2014 10:57, Damien Zammit wrote:
> This patch provides a mixer control for selecting the clock source of
> the Digidesign Mbox 1 to either internal clock or S/PDIF external.
> Trial and error and bus snooping were the only way to get this
> information, but it works on the hardware.

This patch includes lines over 80 characters. Furthermore, these lines 
include inappropriate white-space for indentation. How about indenting 
with tab only and add more line-breaks between each function parameter?

$ ./scripts/checkpatch.pl /tmp/0001-mbox1-spdif.patch
WARNING: line over 80 characters
#134: FILE: sound/usb/mixer_quirks.c:641:
+                                     usb_rcvctrlpipe(mixer->chip->dev, 
0), 0x81,

WARNING: line over 80 characters
#135: FILE: sound/usb/mixer_quirks.c:642:
+                                     USB_DIR_IN | USB_TYPE_CLASS | 
USB_RECIP_INTERFACE,

WARNING: line over 80 characters
#140: FILE: sound/usb/mixer_quirks.c:647:
+                                     usb_rcvctrlpipe(mixer->chip->dev, 
0), 0x81,

WARNING: line over 80 characters
#141: FILE: sound/usb/mixer_quirks.c:648:
+                                     USB_DIR_IN | USB_TYPE_CLASS | 
USB_RECIP_ENDPOINT,

WARNING: line over 80 characters
#159: FILE: sound/usb/mixer_quirks.c:666:
+                                     usb_rcvctrlpipe(mixer->chip->dev, 
0), 0x81,

WARNING: line over 80 characters
#160: FILE: sound/usb/mixer_quirks.c:667:
+                                     USB_DIR_IN | USB_TYPE_CLASS | 
USB_RECIP_ENDPOINT,

WARNING: line over 80 characters
#165: FILE: sound/usb/mixer_quirks.c:672:
+                                     usb_rcvctrlpipe(mixer->chip->dev, 
0), 0x81,

WARNING: line over 80 characters
#166: FILE: sound/usb/mixer_quirks.c:673:
+                                     USB_DIR_IN | USB_TYPE_CLASS | 
USB_RECIP_ENDPOINT,

total: 0 errors, 8 warnings, 226 lines checked

/tmp/0001-mbox1-spdif.patch has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
