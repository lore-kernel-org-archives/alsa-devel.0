From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: Re: usx2y 0.8.2: files different from linux-2.6.9-rc2-mm4-VP-S7
Date: Mon, 4 Oct 2004 02:57:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410040257.58241.annabellesgarden@yahoo.de>
References: <200410031408.44770.annabellesgarden@yahoo.de> <32886.192.168.1.5.1096846514.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32886.192.168.1.5.1096846514.squirrel@192.168.1.5>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Rui Nuno Capela <rncbc@rncbc.org>
List-Id: alsa-devel@alsa-project.org

Am Montag 04 Oktober 2004 01:35 schrieb Rui Nuno Capela:
>
> Looking to dmesg output, some pattern has been found, or kind of. For
> example, the following message is quite repetitive, and is coincidental to
> most of the XRUNs:
>
>   ALSA .../alsa-kernel/usb/usx2y/usbusx2yaudio.c:251: Sequence
>   Error!(ep=8;wait=0,frame=65536).

This looks like I still not got ohci's start_frame numbering scheme right.
I thought it would go from 0 to 0xffff while 65536 is 0x10000 ?-)
Well no. Its propably line 272 in ohci-hcd.c thats generating 0x10000 instead 
of 0:
	urb->start_frame = ed->last_iso + ed->interval;
when ed->last_iso is 0xffff.
Ok, you might submit a patch request to the usb people to let that line look 
like:
	urb->start_frame = (u16)(ed->last_iso + ed->interval);

and/or you might change line 267 of usbusx2yaudio.c and line 211 of 
usx2yhwdeppcm.c to:
	if ((0xFFFF & urb->start_frame) == usX2Y->wait_iso_frame)

The rawusb thingy is not built cause I forgot to put the right usx2y/Makefile 
into the tar.bz. sorry.

Here is the correct usx2yMakefile's content:
>>>
snd-usb-usx2y-objs := usbusx2y.o usX2Yhwdep.o usx2yhwdeppcm.o

obj-$(CONFIG_SND_USB_USX2Y) += snd-usb-usx2y.o
<<<

Karsten


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
