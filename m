From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: snd-usb-usx2y 0.8.7 hwdep pcm oopses!
Date: Thu, 16 Dec 2004 00:41:09 -0000 (WET)
Message-ID: <33037.192.168.1.5.1103157669.squirrel@192.168.1.5>
References: <64648.195.245.190.93.1103017646.squirrel@195.245.190.93>
    <200412151532.35006.annabellesgarden@yahoo.de>
    <s5hr7lrr5hf.wl@alsa2.suse.de>
    <200412152354.06616.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041216004109_38219"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200412152354.06616.annabellesgarden@yahoo.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

------=_20041216004109_38219
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Karsten,

I've took the dirty path, so to speak, and this attached patch/fix is what
I just come along--it's now working with snd-usb-usx2y 0.8.7.1. It avoids
the new usx2y backend driver argument -c as you suggested, by deriving the
soundcard index from the given playback device name (default is 0). I
think it works for the most usual cases.

BTW, one can be also derive the pcm_name (as "hw:%d,2"), so there will be
no need to give it explicitly on the jackd command line, you just give
hw:n instead of hw:n,2 (which looks too magic to my taste :)

Now,... some notes for your thoughts: IMO, and I think we must keep that
in clear mind, is that (y)our new experimental usx2y_driver.c will be only
accepted, officially and made into the JACK tree, if and only if we can
manage to merge it into the current jack/drivers/alsa/alsa_driver.c.

I might start working on that tentative merge ASAP. My will is that next
time I propose this usx2y stuff to be included on the jack cvs tree, it
will be under the form of a alsa_driver patch, not a cloned one (as it is
right now). I hope I(we) get it in time for the next jack release ;)

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


diff -up jack.0/drivers/usx2y/usx2y_driver.c
jack.1/drivers/usx2y/usx2y_driver.c
--- jack.0/drivers/usx2y/usx2y_driver.c	2004-12-13 21:34:13.000000000 +0000
+++ jack.1/drivers/usx2y/usx2y_driver.c	2004-12-15 22:01:57.000000000 +0000
@@ -2087,6 +2087,10 @@ usx2y_driver_new (char *name, char *play

 	usx2y_driver_t *driver;

+	char *hwdep_colon;
+	int   hwdep_card;
+	char  hwdep_name[9];
+
 	printf ("experimental alsa driver ... %s|%s|%" PRIu32 "|%" PRIu32
 		"|%" PRIu32"|%" PRIu32"|%" PRIu32 "|%s|%s|%s|%s\n",
 		playing ? playback_usx2y_device : "-",
@@ -2155,7 +2159,11 @@ usx2y_driver_new (char *name, char *play
 	driver->xrun_count = 0;
 	driver->process_count = 0;

-	snd_hwdep_open(&driver->hwdep_handle, "hw:1,1", O_RDWR);
+	hwdep_card = 0;
+	if ((hwdep_colon = strrchr(playback_usx2y_device, ':')) != NULL)
+		sscanf(hwdep_colon, ":%d", &hwdep_card);
+	snprintf(hwdep_name, sizeof(hwdep_name) - 1, "hw:%d,1", hwdep_card);
+	snd_hwdep_open(&driver->hwdep_handle, hwdep_name, O_RDWR);

 	if (playing) {
 		if (snd_pcm_open (&driver->playback_handle,


------=_20041216004109_38219
Content-Type: application/x-gzip; name="jack-0.99.35-usx2y-fix.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="jack-0.99.35-usx2y-fix.patch.gz"

H4sICFPMwEEAA2phY2stMC45OS4zNS11c3gyeS1maXgucGF0Y2gAlVLRbpswFH2Gr7hDSgsFU0zK
shJ160NfJlVdFWnawzYhD5zBRhxkhybd9vG7xiRQtZoyZMHl+Pgc7rkU1XIJpGib+zsJP1j+M4zO
C1k9cKnOW7WLH809M1iYGw79J8cmhByjZcVRdEFoTOgUYppOL1I6DaP9Bb6+277vH+M5aCUQx2lE
02T2TOv6GkgcvZkFr8HvnjQCxMZKmeBbcPOSSTgTbMUDMHVTs0cbbLCekDdwZqo57vmWoZbbgjdZ
vq7XYo5gJTYA0INMFvM9sce0y+fLrwijeiORvgTX4buGy2rFxYbVwGrFwBhBGIYwUX/0cuB+8b6d
xuAMNWpYo9eXS31AHdYX4QT6mG6xEt/hHejqG2ae9c3yhyrnkIJDkNmFSJMkmGGINLkMKP2/EC1D
Im93shWYU4sBXUE0H+00cp1zpZ5s2sRSoshMaOuGC/dkTzdYyURRo5dTblMaUCeAD9ni5tPC04kP
+Rs5nAvG7I5mhbjaSJmX0n2x/wBO01PPg1dXcPfx9tZDCUupnInlWAXt00mB3ieDY/cBSpjZusPU
A1DVL74eQx4QoKaFSdH18EzmmAjGHocQ9N+rm+7n7MFvPXWNaNEmX3WSMGgeYuhl7b8UgFGLLQQA
AA==
------=_20041216004109_38219--




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
