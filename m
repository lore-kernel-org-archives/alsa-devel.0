From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio hang when rmmoding after unplugging
 midisport1x1
Date: Fri, 12 Mar 2004 13:17:28 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403121305470.14417-100000@studcom.urz.uni-halle.de>
References: <20040311204610.3766f038.geli@enseirb.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040311204610.3766f038.geli@enseirb.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mathieu Geli <geli@enseirb.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Mathieu Geli wrote:
> ok, what I did, is first to apply your patch to my source tree
> (1.0.3rc2), clean, compile, install, and even reboot. That doesn't
> output anymore the two lines "urb status -104", and
> "usb_submit_urb: -32" but still hang after printing:
> "drivers/usb/core/usb.c: deregistering driver snd-usb-audio"

It seems to work fine on my 2.4.25 kernel.

Can you unload the snd-usb-audio module?  If not, please apply the
patch below to see whether the driver or the USB core is the culprit.


Regards,
Clemens

-- 
--- alsa-kernel/usb/usbaudio.c	8 Mar 2004 09:29:51 -0000	1.87
+++ alsa-kernel/usb/usbaudio.c	12 Mar 2004 12:05:22 -0000
@@ -2928,6 +2928,7 @@
 		return;

 	chip = snd_magic_cast(snd_usb_audio_t, ptr, return);
+	snd_printk(KERN_INFO "snd_usb_audio_disconnect called, refcount = %d\n", chip->num_interfaces);
 	card = chip->card;
 	down(&register_mutex);
 	chip->shutdown = 1;
@@ -2947,6 +2948,7 @@
 	} else {
 		up(&register_mutex);
 	}
+	snd_printk(KERN_INFO "snd_usb_audio_disconnect finished!\n");
 }

 /*




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
