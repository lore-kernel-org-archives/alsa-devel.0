From: Tyson Whitehead <twhitehe@uwo.ca>
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Tue, 18 Mar 2008 09:55:50 -0400
Message-ID: <47DFC9E6.5050304@uwo.ca>
References: <20080314131344.62A59DBA2@gherkin.frus.com>
 <200803142118.31974.twhitehe@uwo.ca> <47DEEB07.7010504@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_98liMu7+TuUKDPKBB+/fRw)"
Return-path: <linux-alpha-owner@vger.kernel.org>
In-reply-to: <47DEEB07.7010504@keyaccess.nl>
Sender: linux-alpha-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bob Tracy <rct@frus.com>, Michael Cree <mcree@orcon.net.nz>, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Krzysztof Helt <krzysztof.h1@wp.pl>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Boundary_(ID_98liMu7+TuUKDPKBB+/fRw)
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7BIT

Rene Herman wrote:
> On 15-03-08 02:18, Tyson Whitehead wrote:
> 
> Could you attach that patch? Links I'm finding are to
> 
> http://whitehead.apmaths.uwo.ca/~tyson/
> 
> which seems to be dead.

Sorry about that.  I finally graduated.  : )

Cheers!  -Tyson

--Boundary_(ID_98liMu7+TuUKDPKBB+/fRw)
Content-type: text/x-diff; name=alpha-alsa.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=alpha-alsa.patch

--- sound/isa/es18xx.c~	2003-04-23 06:01:33.000000000 -0400
+++ sound/isa/es18xx.c	2003-06-24 15:14:25.000000000 -0400
@@ -736,10 +736,10 @@
 		/* Read Interrupt status */
 		status = inb(chip->ctrl_port + 6);
+#if 0
 	} else {
 		/* Read Interrupt status */
 		status = snd_es18xx_mixer_read(chip, 0x7f) >> 4;
-	}
-#if 0
-	else {
+#else
+	} else {
 		status = 0;
 		if (inb(chip->port + 0x0C) & 0x01)

--Boundary_(ID_98liMu7+TuUKDPKBB+/fRw)--
