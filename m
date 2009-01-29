From: Philippe Carriere <philippe-f.carriere@wanadoo.fr>
Subject: Re: (no subject)
Date: Thu, 29 Jan 2009 09:35:53 +0100
Message-ID: <1233218153.3257.25.camel@localhost.localdomain>
References: <8230211.582121223895071540.JavaMail.www@wwinf1d32>
	<200810141154.27011.fzu@wemgehoertderstaat.de>
	<1223980887.2915.4.camel@pollux.mecaflu.ec-lyon.fr>
	<200901270116.02701.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-dobKouP8FS/1zrk0tiRm"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp20.orange.fr (smtp20.orange.fr [80.12.242.26])
	by alsa0.perex.cz (Postfix) with ESMTP id B0FFC103864
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 09:36:15 +0100 (CET)
In-Reply-To: <200901270116.02701.fzu@wemgehoertderstaat.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Federico Briata <federicobriata@gmail.com>
List-Id: alsa-devel@alsa-project.org


--=-dobKouP8FS/1zrk0tiRm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Karsten,

I successfully tested your new version of the patch and sent a
"tested:by" to linux-usb@vger.kernel.org today (see attached).
Hope it will speed up the process.

Regards,

Phil.

Le mardi 27 janvier 2009 =C3=A0 01:16 +0100, Karsten Wiese a =C3=A9crit :
> Am Dienstag, 14. Oktober 2008 schrieb Philippe Carriere:
> > Might this patch (the original one, without features yet implemented =
in
> > 2.6.26, and an extremely slight modification to fit it) I use on Fedo=
ra
> > kernel (the patch also applies as it stands to vanilla) save works an=
d
> > time ?
>=20
> I resent the patch to linux-usb@vger.kernel.org today.
> Maybe it helps, if you post a "tested-by:" there.
>=20
> Regards,
> Karsten
>=20
> pi=C3=A8ce jointe message de courriel (forwarded message), "Karsten Wie=
se
> <fzu@wemgehoertderstaat.de>: [RESEND][PATCH] USB: Prevent EHCI ITDs
> reusage while frame is active"
> > -------- Message transf=C3=A9r=C3=A9 --------
> > De: Karsten Wiese <fzu@wemgehoertderstaat.de>
> > =C3=80: David Brownell <david-b@pacbell.net>
> > Cc: linux-usb@vger.kernel.org
> > Sujet: [RESEND][PATCH] USB: Prevent EHCI ITDs reusage while frame is
> > active
> > Date: Mon, 26 Jan 2009 14:32:51 +0100
> >=20
> > pi=C3=A8ce jointe document texte brut (forwarded message)
> > Hi,
> >=20
> > this is a refresh to let patch fit ontop 2.6.29-rc2.
> > Changes from previous version:
> > - use variable clock_frame instead of hw_frame
> > - Patch Description exactified
> > snd_usb_us122l (in kernel since .28) needs it, if device is attached =
to
> > ehci.
> >=20
> > thanks,
> > Karsten
> >=20
> >=20
> >=20
> > ---------------------------------------------------------------------=
-
> > From: Karsten Wiese <fzu@wemgehoertderstaat.de>
> > Date: Wed, 13 Feb 2008 22:22:09 +0100
> > Subject: [PATCH] USB: Prevent EHCI ITDs reusage while frame is active
> >=20
> > ITDs can be detached from urbs, before the frame elapses. Now those I=
TDs are
> > immediately recycled.
> > If the ITD is reused before the frame elapses, the ITD becomes invali=
d
> > regarding the not yet elapsed frame.
> > Patch takes care of those ITDs by moving them into a new ehci member =
list
> > cached_itd_list. ITDs resting in cached_itd_list are moved back into =
their
> > stream's free_list once scan_periodic() detects that the active frame=
 has
> > elapsed.
> >=20
> > Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
> >=20
> > ---
> >  drivers/usb/host/ehci-hcd.c   |    2 +
> >  drivers/usb/host/ehci-mem.c   |    1 +
> >  drivers/usb/host/ehci-sched.c |   54 +++++++++++++++++++++++++++++++=
+++------
> >  drivers/usb/host/ehci.h       |    5 ++++
> >  4 files changed, 54 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.=
c
> > index 4725d15..e551bb3 100644
> > --- a/drivers/usb/host/ehci-hcd.c
> > +++ b/drivers/usb/host/ehci-hcd.c
> > @@ -485,6 +485,7 @@ static int ehci_init(struct usb_hcd *hcd)
> >  	 * periodic_size can shrink by USBCMD update if hcc_params allows.
> >  	 */
> >  	ehci->periodic_size =3D DEFAULT_I_TDPS;
> > +	INIT_LIST_HEAD(&ehci->cached_itd_list);
> >  	if ((retval =3D ehci_mem_init(ehci, GFP_KERNEL)) < 0)
> >  		return retval;
> > =20
> > @@ -497,6 +498,7 @@ static int ehci_init(struct usb_hcd *hcd)
> > =20
> >  	ehci->reclaim =3D NULL;
> >  	ehci->next_uframe =3D -1;
> > +	ehci->clock_frame =3D -1;
> > =20
> >  	/*
> >  	 * dedicate a qh for the async ring head, since we couldn't unlink
> > diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.=
c
> > index 0431397..10d5291 100644
> > --- a/drivers/usb/host/ehci-mem.c
> > +++ b/drivers/usb/host/ehci-mem.c
> > @@ -128,6 +128,7 @@ static inline void qh_put (struct ehci_qh *qh)
> > =20
> >  static void ehci_mem_cleanup (struct ehci_hcd *ehci)
> >  {
> > +	free_cached_itd_list(ehci);
> >  	if (ehci->async)
> >  		qh_put (ehci->async);
> >  	ehci->async =3D NULL;
> > diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sc=
hed.c
> > index a081ee6..c1f7d5f 100644
> > --- a/drivers/usb/host/ehci-sched.c
> > +++ b/drivers/usb/host/ehci-sched.c
> > @@ -1004,7 +1004,8 @@ iso_stream_put(struct ehci_hcd *ehci, struct eh=
ci_iso_stream *stream)
> > =20
> >  		is_in =3D (stream->bEndpointAddress & USB_DIR_IN) ? 0x10 : 0;
> >  		stream->bEndpointAddress &=3D 0x0f;
> > -		stream->ep->hcpriv =3D NULL;
> > +		if (stream->ep)
> > +			stream->ep->hcpriv =3D NULL;
> > =20
> >  		if (stream->rescheduled) {
> >  			ehci_info (ehci, "ep%d%s-iso rescheduled "
> > @@ -1653,14 +1654,26 @@ itd_complete (
> >  			(stream->bEndpointAddress & USB_DIR_IN) ? "in" : "out");
> >  	}
> >  	iso_stream_put (ehci, stream);
> > -	/* OK to recycle this ITD now that its completion callback ran. */
> > +
> >  done:
> >  	usb_put_urb(urb);
> >  	itd->urb =3D NULL;
> > -	itd->stream =3D NULL;
> > -	list_move(&itd->itd_list, &stream->free_list);
> > -	iso_stream_put(ehci, stream);
> > -
> > +	if (ehci->clock_frame !=3D itd->frame || itd->index[7] !=3D -1) {
> > +		/* OK to recycle this ITD now. */
> > +		itd->stream =3D NULL;
> > +		list_move(&itd->itd_list, &stream->free_list);
> > +		iso_stream_put(ehci, stream);
> > +	} else {
> > +		/* HW might still start transactions based on this ITD.
> > +		   If its content changed that is. Move it to a safe place. */
> > +		list_move(&itd->itd_list, &ehci->cached_itd_list);
> > +		if (stream->refcount =3D=3D 2) {
> > +			/* If iso_stream_put() would be called here, stream
> > +			   would be freed. Prevent stream's reusage instead. */
> > +			stream->ep->hcpriv =3D NULL;
> > +			stream->ep =3D NULL;
> > +		}
> > +	}
> >  	return retval;
> >  }
> > =20
> > @@ -2101,6 +2114,20 @@ done:
> > =20
> >  /*------------------------------------------------------------------=
-------*/
> > =20
> > +static void free_cached_itd_list(struct ehci_hcd *ehci)
> > +{
> > +	struct ehci_itd *itd, *n;
> > +
> > +	list_for_each_entry_safe(itd, n, &ehci->cached_itd_list, itd_list) =
{
> > +		struct ehci_iso_stream	*stream =3D itd->stream;
> > +		itd->stream =3D NULL;
> > +		list_move(&itd->itd_list, &stream->free_list);
> > +		iso_stream_put(ehci, stream);
> > +	}
> > +}
> > +
> > +/*------------------------------------------------------------------=
-------*/
> > +
> >  static void
> >  scan_periodic (struct ehci_hcd *ehci)
> >  {
> > @@ -2115,10 +2142,17 @@ scan_periodic (struct ehci_hcd *ehci)
> >  	 * Touches as few pages as possible:  cache-friendly.
> >  	 */
> >  	now_uframe =3D ehci->next_uframe;
> > -	if (HC_IS_RUNNING (ehci_to_hcd(ehci)->state))
> > +	if (HC_IS_RUNNING(ehci_to_hcd(ehci)->state)) {
> >  		clock =3D ehci_readl(ehci, &ehci->regs->frame_index);
> > -	else
> > +		clock_frame =3D (clock >> 3) % ehci->periodic_size;
> > +	} else  {
> >  		clock =3D now_uframe + mod - 1;
> > +		clock_frame =3D -1;
> > +	}
> > +	if (ehci->clock_frame !=3D clock_frame) {
> > +		free_cached_itd_list(ehci);
> > +		ehci->clock_frame =3D clock_frame;
> > +	}
> >  	clock %=3D mod;
> >  	clock_frame =3D clock >> 3;
> > =20
> > @@ -2277,6 +2311,10 @@ restart:
> >  			/* rescan the rest of this frame, then ... */
> >  			clock =3D now;
> >  			clock_frame =3D clock >> 3;
> > +			if (ehci->clock_frame !=3D clock_frame) {
> > +				free_cached_itd_list(ehci);
> > +				ehci->clock_frame =3D clock_frame;
> > +			}
> >  		} else {
> >  			now_uframe++;
> >  			now_uframe %=3D mod;
> > diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> > index fb7054c..5262fb7 100644
> > --- a/drivers/usb/host/ehci.h
> > +++ b/drivers/usb/host/ehci.h
> > @@ -86,6 +86,9 @@ struct ehci_hcd {			/* one per controller */
> >  	union ehci_shadow	*pshadow;	/* mirror hw periodic table */
> >  	int			next_uframe;	/* scan periodic, start here */
> >  	unsigned		periodic_sched;	/* periodic activity count */
> > +	struct list_head	cached_itd_list; /* list of itds completed
> > +						    while frame hadn't yet elapsed */
> > +	unsigned		clock_frame;
> > =20
> >  	/* per root hub port */
> >  	unsigned long		reset_done [EHCI_MAX_ROOT_PORTS];
> > @@ -220,6 +223,8 @@ timer_action (struct ehci_hcd *ehci, enum ehci_ti=
mer_action action)
> >  	}
> >  }
> > =20
> > +static void free_cached_itd_list(struct ehci_hcd *ehci);
> > +
> >  /*------------------------------------------------------------------=
-------*/
> > =20
> >  #include <linux/usb/ehci_def.h>

--=20
Philippe Carriere <philippe-f.carriere@wanadoo.fr>

--=-dobKouP8FS/1zrk0tiRm
Content-Disposition: attachment; filename="tested_by:_Philippe_Carriere.txt"
Content-Type: text/plain; name="tested_by:_Philippe_Carriere.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From philippe-f.carriere@wanadoo.fr Thu Jan 29 09:30:07 2009
Subject: [RESEND][PATCH] USB: Prevent EHCI ITDs reusage while frame is
 active: tested by: Philippe Carriere.
From: Philippe Carriere <philippe-f.carriere@wanadoo.fr>
To: linux-usb@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-VmmaepDIq/JbLd+TeS0C"
Message-Id: <1233217786.3257.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 (2.24.3-1.fc10) 
Date: Thu, 29 Jan 2009 09:30:07 +0100
X-Evolution-Format: text/plain
X-Evolution-Account: 1197104178.3652.20@pollux.mecaflu.ec-lyon.fr
X-Evolution-Transport:
 smtp://philippe-f.carriere;auth=PLAIN@smtp.wanadoo.fr/;use_ssl=never
X-Evolution-Fcc: mbox:/home/philippe/.evolution/mail/local#Sent


--=-VmmaepDIq/JbLd+TeS0C
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

 Hi,

I successfully tested the refreshed patch of Karsten using Fedora
rawhide packages. Following are  some informations on the test:

original kernel: 2.6.29-0.53.rc2.git1.fc11.x86_64
patched kernel: Linux 2.6.29-0.53.rc2.git1.ehcius122l.fc11.x86_64 #1 SMP
Wed Jan 28 22:48:01 CET 2009 x86_64 x86_64 x86_64 GNU/Linux
alsa: alsa-lib-1.0.19-1.fc11, alsa-plugins-usbstream-1.0.18
jack: jack-audio-connection-kit-0.116.1-3.fc11
qjackctl: qjackctl-0.3.3-1.fc10
audacious: audacious-1.5.1-5.fc11

after plugin the Tascam US-122L:

[root@pollux Test]# tail /var/log/messages
Jan 29 08:05:53 pollux kernel: usb 2-6: new high speed USB device using
ehci_hcd and address 4
Jan 29 08:05:53 pollux kernel: usb 2-6: config 1 interface 1 altsetting
1 bulk endpoint 0x83 has invalid maxpacket 9
Jan 29 08:05:53 pollux kernel: usb 2-6: New USB device found,
idVendor=0644, idProduct=800e
Jan 29 08:05:53 pollux kernel: usb 2-6: New USB device strings: Mfr=1,
Product=2, SerialNumber=3
Jan 29 08:05:53 pollux kernel: usb 2-6: Product: US-122L
Jan 29 08:05:53 pollux kernel: usb 2-6: Manufacturer: TASCAM
Jan 29 08:05:53 pollux kernel: usb 2-6: SerialNumber: no serial number
Jan 29 08:05:53 pollux kernel: usb 2-6: configuration #1 chosen from 1
choice
Jan 29 08:06:08 pollux kernel: ALSA sound/usb/usx2y/usb_stream.c:457:
underrun, status=4294967278
Jan 29 08:06:08 pollux kernel: ALSA sound/usb/usx2y/usb_stream.c:457:
underrun, status=4294967278

[root@pollux Test]# cat /proc/asound/cards
0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfebfc000 irq 21
1 [US122L         ]: USB US-122L - TASCAM US-122L
                      TASCAM US-122L (644:800e if 0 at 002/004)


and jack messages were

08:50:00.226 /usr/bin/jackd -R -P89 -dalsa -dusb_stream:1 -r48000 -p512
-n2
jackd 0.116.1
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK compiled with System V SHM support.
08:50:00.251 JACK was started with PID=6417.
loading driver ..
apparent rate = 48000
creating alsa driver ... usb_stream:1|usb_stream:1|512|2|48000|0|0|
nomon|swmeter|-|32bit
ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL usb_stream:1
control open "usb_stream:1" (No such file or directory)
configuring for 48000Hz, period = 512 frames (10.7 ms), buffer = 2
periods
ALSA: final selected sample format for capture: 24bit little-endian
ALSA: use 2 periods for capture
ALSA: final selected sample format for playback: 24bit little-endian
ALSA: use 2 periods for playback
08:50:02.397 Server configuration saved to "/home/Test/.jackdrc".
08:50:02.398 Statistics reset.
08:50:02.547 Client activated.
08:50:02.550 JACK connection change.
08:50:02.558 JACK connection graph change.

Tested by .mp3 file playback using audacious (with plugin jack).

Additional notes: the previous version of the patch is routinely used by
myself, at least some Fedora users using my packages at
http://pagesperso-orange.fr/La-page-Web-of-Phil/Tascam_US-122L/Telechargement_us122l.html , and under Debian and Ubuntu (Federico Briata web site at http://wiki.briata.org/doku.php?id=testing_us122l_under_linux ) under 2.6.26 and 2.6.27 kernel.

Hope it will be soon integrated to 2.6.29 devel.

Regards

Phil.


--=-VmmaepDIq/JbLd+TeS0C
Content-Disposition: attachment; filename="forwarded_message"
Content-Type: message/rfc822; name="forwarded_message"

From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: David Brownell <david-b@pacbell.net>
Subject: [RESEND][PATCH] USB: Prevent EHCI ITDs reusage while frame is
 active
Date: Mon, 26 Jan 2009 14:32:51 +0100
User-Agent: KMail/1.9.9
Cc: linux-usb@vger.kernel.org
References: <200802132238.51929.fzu@wemgehoertderstaat.de>
	 <200803171405.02530.fzu@wemgehoertderstaat.de>
	 <200805201315.08008.fzu@wemgehoertderstaat.de>
In-Reply-To: <200805201315.08008.fzu@wemgehoertderstaat.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200901261432.51974.fzu@wemgehoertderstaat.de>
Content-Transfer-Encoding: 8bit

Hi,

this is a refresh to let patch fit ontop 2.6.29-rc2.
Changes from previous version:
- use variable clock_frame instead of hw_frame
- Patch Description exactified
snd_usb_us122l (in kernel since .28) needs it, if device is attached to
ehci.

thanks,
Karsten



----------------------------------------------------------------------
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Date: Wed, 13 Feb 2008 22:22:09 +0100
Subject: [PATCH] USB: Prevent EHCI ITDs reusage while frame is active

ITDs can be detached from urbs, before the frame elapses. Now those ITDs are
immediately recycled.
If the ITD is reused before the frame elapses, the ITD becomes invalid
regarding the not yet elapsed frame.
Patch takes care of those ITDs by moving them into a new ehci member list
cached_itd_list. ITDs resting in cached_itd_list are moved back into their
stream's free_list once scan_periodic() detects that the active frame has
elapsed.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>

---
 drivers/usb/host/ehci-hcd.c   |    2 +
 drivers/usb/host/ehci-mem.c   |    1 +
 drivers/usb/host/ehci-sched.c |   54 ++++++++++++++++++++++++++++++++++------
 drivers/usb/host/ehci.h       |    5 ++++
 4 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 4725d15..e551bb3 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -485,6 +485,7 @@ static int ehci_init(struct usb_hcd *hcd)
 	 * periodic_size can shrink by USBCMD update if hcc_params allows.
 	 */
 	ehci->periodic_size = DEFAULT_I_TDPS;
+	INIT_LIST_HEAD(&ehci->cached_itd_list);
 	if ((retval = ehci_mem_init(ehci, GFP_KERNEL)) < 0)
 		return retval;
 
@@ -497,6 +498,7 @@ static int ehci_init(struct usb_hcd *hcd)
 
 	ehci->reclaim = NULL;
 	ehci->next_uframe = -1;
+	ehci->clock_frame = -1;
 
 	/*
 	 * dedicate a qh for the async ring head, since we couldn't unlink
diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
index 0431397..10d5291 100644
--- a/drivers/usb/host/ehci-mem.c
+++ b/drivers/usb/host/ehci-mem.c
@@ -128,6 +128,7 @@ static inline void qh_put (struct ehci_qh *qh)
 
 static void ehci_mem_cleanup (struct ehci_hcd *ehci)
 {
+	free_cached_itd_list(ehci);
 	if (ehci->async)
 		qh_put (ehci->async);
 	ehci->async = NULL;
diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index a081ee6..c1f7d5f 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1004,7 +1004,8 @@ iso_stream_put(struct ehci_hcd *ehci, struct ehci_iso_stream *stream)
 
 		is_in = (stream->bEndpointAddress & USB_DIR_IN) ? 0x10 : 0;
 		stream->bEndpointAddress &= 0x0f;
-		stream->ep->hcpriv = NULL;
+		if (stream->ep)
+			stream->ep->hcpriv = NULL;
 
 		if (stream->rescheduled) {
 			ehci_info (ehci, "ep%d%s-iso rescheduled "
@@ -1653,14 +1654,26 @@ itd_complete (
 			(stream->bEndpointAddress & USB_DIR_IN) ? "in" : "out");
 	}
 	iso_stream_put (ehci, stream);
-	/* OK to recycle this ITD now that its completion callback ran. */
+
 done:
 	usb_put_urb(urb);
 	itd->urb = NULL;
-	itd->stream = NULL;
-	list_move(&itd->itd_list, &stream->free_list);
-	iso_stream_put(ehci, stream);
-
+	if (ehci->clock_frame != itd->frame || itd->index[7] != -1) {
+		/* OK to recycle this ITD now. */
+		itd->stream = NULL;
+		list_move(&itd->itd_list, &stream->free_list);
+		iso_stream_put(ehci, stream);
+	} else {
+		/* HW might still start transactions based on this ITD.
+		   If its content changed that is. Move it to a safe place. */
+		list_move(&itd->itd_list, &ehci->cached_itd_list);
+		if (stream->refcount == 2) {
+			/* If iso_stream_put() would be called here, stream
+			   would be freed. Prevent stream's reusage instead. */
+			stream->ep->hcpriv = NULL;
+			stream->ep = NULL;
+		}
+	}
 	return retval;
 }
 
@@ -2101,6 +2114,20 @@ done:
 
 /*-------------------------------------------------------------------------*/
 
+static void free_cached_itd_list(struct ehci_hcd *ehci)
+{
+	struct ehci_itd *itd, *n;
+
+	list_for_each_entry_safe(itd, n, &ehci->cached_itd_list, itd_list) {
+		struct ehci_iso_stream	*stream = itd->stream;
+		itd->stream = NULL;
+		list_move(&itd->itd_list, &stream->free_list);
+		iso_stream_put(ehci, stream);
+	}
+}
+
+/*-------------------------------------------------------------------------*/
+
 static void
 scan_periodic (struct ehci_hcd *ehci)
 {
@@ -2115,10 +2142,17 @@ scan_periodic (struct ehci_hcd *ehci)
 	 * Touches as few pages as possible:  cache-friendly.
 	 */
 	now_uframe = ehci->next_uframe;
-	if (HC_IS_RUNNING (ehci_to_hcd(ehci)->state))
+	if (HC_IS_RUNNING(ehci_to_hcd(ehci)->state)) {
 		clock = ehci_readl(ehci, &ehci->regs->frame_index);
-	else
+		clock_frame = (clock >> 3) % ehci->periodic_size;
+	} else  {
 		clock = now_uframe + mod - 1;
+		clock_frame = -1;
+	}
+	if (ehci->clock_frame != clock_frame) {
+		free_cached_itd_list(ehci);
+		ehci->clock_frame = clock_frame;
+	}
 	clock %= mod;
 	clock_frame = clock >> 3;
 
@@ -2277,6 +2311,10 @@ restart:
 			/* rescan the rest of this frame, then ... */
 			clock = now;
 			clock_frame = clock >> 3;
+			if (ehci->clock_frame != clock_frame) {
+				free_cached_itd_list(ehci);
+				ehci->clock_frame = clock_frame;
+			}
 		} else {
 			now_uframe++;
 			now_uframe %= mod;
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index fb7054c..5262fb7 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -86,6 +86,9 @@ struct ehci_hcd {			/* one per controller */
 	union ehci_shadow	*pshadow;	/* mirror hw periodic table */
 	int			next_uframe;	/* scan periodic, start here */
 	unsigned		periodic_sched;	/* periodic activity count */
+	struct list_head	cached_itd_list; /* list of itds completed
+						    while frame hadn't yet elapsed */
+	unsigned		clock_frame;
 
 	/* per root hub port */
 	unsigned long		reset_done [EHCI_MAX_ROOT_PORTS];
@@ -220,6 +223,8 @@ timer_action (struct ehci_hcd *ehci, enum ehci_timer_action action)
 	}
 }
 
+static void free_cached_itd_list(struct ehci_hcd *ehci);
+
 /*-------------------------------------------------------------------------*/
 
 #include <linux/usb/ehci_def.h>
-- 
1.6.0.6


--=-VmmaepDIq/JbLd+TeS0C--

--=-dobKouP8FS/1zrk0tiRm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-dobKouP8FS/1zrk0tiRm--
