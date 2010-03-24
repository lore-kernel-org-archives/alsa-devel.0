From: Jan Depner <eviltwin69@cableone.net>
Subject: TASCAM US-1641
Date: Tue, 23 Mar 2010 20:34:43 -0500
Message-ID: <1269394483.6635.11.camel@eviltwin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s7.cableone.net (s7.cableone.net [24.116.0.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E65E2414B
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 02:34:46 +0100 (CET)
Received: from [192.168.0.2] (unverified [96.19.139.143])
	by s7.cableone.net (CableOne SMTP Service s7) with ESMTP id
	31283629-1872270
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 18:34:44 -0700
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA_DEVEL <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

A couple of weeks ago I purchased a TASCAM US-1641 on the off chance
that I might be able to get the thing working on Linux (or give up and
use it in Windows ;-)  I have built the 2.6.33 kernel and started
playing around in Karsten Wiese's US-122L module to see what I could get
to happen.  I did this on the off chance that TASCAM just increased the
number of ports but used the same protocol for communication that they
used for the US-122L.  I added an entry for the US-1641 in us122l.h
(#define USB_ID_US1641 0x8017) and then added an entry to the
snd_us122l_usb_id_table in us122l.c.  After recompiling and installing
the modules I get the following in my dmesg output when I turn the
device on:

usb 1-2: new high speed USB device using ehci_hcd and address 3
couldn't __get_free_pages()
snd-usb-us122l: probe of 1-2:1.1 failed with error -22


I don't have any problem with spending a lot of time on this (actually,
it's kind of fascinating) and I am proficient in C but I could use some
help.  I'm hoping that someone on this list might have some information
that could help me in trying to get this thing working (I've even got
UsbSnoop installed on my Windows partition).  Any information that could
help would be greatly appreciated.

Cheers,
Jan Depner
