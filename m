From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: usx2y 0.8.2: files different from linux-2.6.9-rc2-mm4-VP-S7
Date: Mon, 4 Oct 2004 00:35:14 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32886.192.168.1.5.1096846514.squirrel@192.168.1.5>
References: <200410031408.44770.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200410031408.44770.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Karsten,

> this is my latest.
> if you want to try it,
> cp this archive into a clean linux-2.6.9(-rc2(-mm4(-VP-S7))) tree and
build alsa stuffs inside kernel.
>
> Karsten
>

I have tested both ways of these 0.8.2 files. For one, a whole kernel was
built, after taking the untarred archive. The other way, the earlier sent
patch was applied to alsa-kernel cvs and then built from alsa-driver and
installed accordingly. Into the field, both methods resulted in very
similar behaviors, if not identical.

First thing to note is, as expected, the new hwdep pcm interface is not
included, which makes jackd missing that nice experimental usx2y backend.

While using the alsa backend, jackd behaves as similarly as reported once
before:

- jackd -R (realtime) crashes badly :( not a kernel oops however.

- jackd (non realtime) starts apparently fine, but prone to plenty and
annoying XRUNs.

I noticed that the XRUN frequency decreases a lot if I disable ACPI
(setting acpi=off on the boot prompt). However, these XRUNs are still
annoying and quite repetitive (almost every other minute or so).

Looking to dmesg output, some pattern has been found, or kind of. For
example, the following message is quite repetitive, and is coincidental to
most of the XRUNs:

  ALSA .../alsa-kernel/usb/usx2y/usbusx2yaudio.c:251: Sequence
  Error!(ep=8;wait=0,frame=65536).
  Most propably some urb of usb-frame 0 is still missing.
  Cause could be too long delays in usb-hcd interrupt handling.
  This driver definitely wants 1 interrupt per ms.
  To make it work for a system that can't deliver interrupts reliably at
that rate,
  You'd have to make it work for NRPACKS > 1. To start, grep for NRPACKS
in this code ;-)

Other interesting, but less frequent messages are:

  ALSA .../alsa-kernel/core/pcm_lib.c:158: BUG: stream = 0, pos = 0x2b11,
buffer size = 0x2b11, period size = 0xac4
  ALSA .../alsa-kernel/usb/usx2y/usbusx2yaudio.c:116: should not be here
with counts=0

All these tests were mainly conducted with jackd -r 44100 -p 1024 -n 2.
Using fewer frames per buffer (-p), or periods (-n), just leads to
increasing the XRUN frequency, ultimately to the point of disaster.
Obviously, the sound crackling due to the XRUNs is very, very noticeable.

OTHO, while taking some latency traces in attempt to match those XRUN
occurrencies, nothing has popped up, even with latency thresholds of less
than 200us. So I guess that astray or long kernel critical sections are
not to blame here, IIUC.

Probably, attention should be given towards that "Sequence Error!" message
verbosity, no?

Nuff said now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org








-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
