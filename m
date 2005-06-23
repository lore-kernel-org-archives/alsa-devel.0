From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] Fw: BUG: Kernel panic when disconnecting Edirol USB2 audio interface
Date: Thu, 23 Jun 2005 13:45:09 +0200
Message-ID: <1119527109.42baa0c5df4ea@www.domainfactory-webmail.de>
References: <20050623024635.5b873305.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ11195271095e607abc2d9e56f11802ed1e29c93060"
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050623024635.5b873305.akpm@osdl.org>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Colin Fletcher <colinf@axicon.com>
Cc: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

This message is in MIME format.

---MOQ11195271095e607abc2d9e56f11802ed1e29c93060
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Colin Fletcher wrote:
> I hope this is the right place for this sort of bug report: if
> there's a better place, please do point me there.

Anything related to the snd-usb-audio driver should go to alsa-devel,
but this bug seems to be in the EHCI driver.

> [2.] I have an Edirol UA-1000 USB 2.0 Audio Capture unit. When
> disconnected (or powered down), it repeatably causes a kernel panic,
> in (I think) linux/drivers/usb/host/ehci-q.c, start_unlink_async(),

You didn't mention that the device was currently playing/recording, so
I assume it wasn't.  In this case, the oops apparently happens when the
MIDI URBs are canceled (the MIDI input URBs are active as long as the
driver is loaded).  Please try the attached patch; it adds two printk()s
around the snd_usbmidi_disconnect() function.  If my theory is correct,
the oops should happen immediately after the "killing MIDI URBs..."
message.


BTW: I never had the opportunity to test my code for the UA-1000.
Does playback/capture/MIDI work?


Regards,
Clemens

---MOQ11195271095e607abc2d9e56f11802ed1e29c93060
Content-Type: text/plain; name="umidi-disconnect.diff.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="umidi-disconnect.diff.txt"

LS0tIGxpbnV4L3NvdW5kL3VzYi91c2JtaWRpLmMJMjcgTWF5IDIwMDUgMTI6MTA6NTMgLTAwMDAJ
MS40OQorKysgbGludXgvc291bmQvdXNiL3VzYm1pZGkuYwkyMyBKdW4gMjAwNSAxMTozMjo1NyAt
MDAwMApAQCAtOTE3LDYgKzkxNyw3IEBACiAJc25kX3VzYl9taWRpX3QqIHVtaWRpOwogCWludCBp
OwogCisJc25kX3ByaW50aygia2lsbGluZyBNSURJIFVSQnMuLi5cbiIpOwogCXVtaWRpID0gbGlz
dF9lbnRyeShwLCBzbmRfdXNiX21pZGlfdCwgbGlzdCk7CiAJZm9yIChpID0gMDsgaSA8IE1JRElf
TUFYX0VORFBPSU5UUzsgKytpKSB7CiAJCXNuZF91c2JfbWlkaV9lbmRwb2ludF90KiBlcCA9ICZ1
bWlkaS0+ZW5kcG9pbnRzW2ldOwpAQCAtOTI4LDYgKzkyOSw3IEBACiAJCWlmIChlcC0+aW4gJiYg
ZXAtPmluLT51cmIpCiAJCQl1c2Jfa2lsbF91cmIoZXAtPmluLT51cmIpOwogCX0KKwlzbmRfcHJp
bnRrKCIuLi5kb25lXG4iKTsKIH0KIAogc3RhdGljIHZvaWQgc25kX3VzYm1pZGlfcmF3bWlkaV9m
cmVlKHNuZF9yYXdtaWRpX3QqIHJtaWRpKQo=

---MOQ11195271095e607abc2d9e56f11802ed1e29c93060--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
