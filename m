From: Martin Langer <martin-langer@gmx.de>
Subject: Re: still interested in us224 support?
Date: Mon, 2 Feb 2004 20:10:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040202191005.GA569@tuba.home>
References: <20040111142515.GA1140@tuba.home> <200401301804.09400.david@robot-droid.com> <20040130201251.GA536@tuba.home> <200402011358.07199.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200402011358.07199.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: David <david@robot-droid.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 01, 2004 at 01:58:06PM +0100, Karsten Wiese wrote:
> Am Freitag, 30. Januar 2004 21:12 schrieb Martin Langer:
> >
> > I guess it's time to create some official 224 driver/loader patches for
> > Alsa CVS now. Any objections?
> 
> You uncommented any section containing USB_ID_US224 in snd-usb-usx2y?

Yes, ATM there's nothing done except uncommenting two things in the driver
(see attached patch). And it's based on the usx2yloader patch from yesterday. 

martin

-- 
The only nice thing about spam is that it doesn't ring.

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usbusx2y-us224.patch"

--- usbusx2y.c.ORIGINAL	Mon Feb  2 19:33:45 2004
+++ usbusx2y.c	Mon Feb  2 19:35:14 2004
@@ -247,11 +247,11 @@
 		.idVendor =	0x1604,
 		.idProduct =	USB_ID_US122 
 	},
-/* 	{ FIXME: uncomment  to test us224 support*/
-/* 		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE, */
-/* 		.idVendor =	0x1604, */
-/* 		.idProduct =	USB_ID_US224  */
-/* 	}, */
+ 	{
+		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =	0x1604,
+		.idProduct =	USB_ID_US224
+	},
 	{ /* terminator */ }
 };
 
@@ -292,7 +292,7 @@
 	int		err;
 	snd_card_t*	card;
 	if (device->descriptor.idVendor != 0x1604 ||
-	    (device->descriptor.idProduct != USB_ID_US122 && /* device->descriptor.idProduct != USB_ID_US224 && */ device->descriptor.idProduct != USB_ID_US428) ||
+	    (device->descriptor.idProduct != USB_ID_US122 && device->descriptor.idProduct != USB_ID_US224 && device->descriptor.idProduct != USB_ID_US428) ||
 	    !(card = snd_usX2Y_create_card(device)))
 		return 0;
 	if ((err = snd_usX2Y_hwdep_new(card, device)) < 0  ||

--XsQoSWH+UP9D9v3l--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
