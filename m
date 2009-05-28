From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
Subject: Re: Roland/Edirol M-16DX
Date: Thu, 28 May 2009 14:03:39 +0300
Message-ID: <4A1E6F8B.3000308@trn.iki.fi>
References: <487F10EE.6030405@trn.iki.fi>
	<48883AAC.6060101@ladisch.de>	<49BC62A5.9070103@trn.iki.fi>
	<s5hsklerlsa.wl%tiwai@suse.de>	<4A1DA767.1030909@trn.iki.fi>
	<s5hr5ya1cg3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070902010208090204010009"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jenni2.inet.fi (mta-out.inet.fi [195.156.147.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B14F24567
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 13:04:19 +0200 (CEST)
In-Reply-To: <s5hr5ya1cg3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070902010208090204010009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Related messages attached. Didn't see any from you, actually. Maybe 
something you sent didn't reach me?

Capture works properly but playback has sync issues. The proper fix 
(based on what the Windows driver does) would be to capture while 
playing and to use the capture clock to synchronize playback, but no-one 
had time to implement that.

Hopefully this helps.


--------------070902010208090204010009
Content-Type: message/rfc822;
 name="Liitetty viesti"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Liitetty viesti"

Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Original-To: tronic@trn.iki.fi
Delivered-To: tronic@trn.iki.fi
Received: from trn.iki.fi (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP id 8074245B7BE01
	for <tronic@trn.iki.fi>; Mon, 10 Nov 2008 05:53:31 +0200 (EET)
Received: from alsa0.perex.cz (alsa0.perex.cz [212.20.107.51])
	by trn.iki.fi (Postfix) with ESMTP
	for <tronic+rlk9@trn.iki.fi>; Mon, 10 Nov 2008 05:53:31 +0200 (EET)
Received: by alsa0.perex.cz (Postfix, from userid 1000)
	id 52A601038B4; Mon, 10 Nov 2008 04:53:24 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on mail1.perex.cz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=disabled
	version=3.2.4
Received: from alsa0.perex.cz (localhost [127.0.0.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EBD410382C;
	Mon, 10 Nov 2008 04:53:20 +0100 (CET)
X-Original-To: alsa-devel@alsa-project.org
Delivered-To: alsa-devel@alsa-project.org
Received: by alsa0.perex.cz (Postfix, from userid 1000)
	id C2C47103820; Mon, 10 Nov 2008 04:53:18 +0100 (CET)
Received: from kirsi1.inet.fi (mta-out.inet.fi [195.156.147.13])
	by alsa0.perex.cz (Postfix) with ESMTP id F08E2103815
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 04:53:17 +0100 (CET)
Received: from trn.iki.fi (88.195.48.158) by kirsi1.inet.fi (8.5.014)
	id 48FC5AC9010BC178 for alsa-devel@alsa-project.org;
	Mon, 10 Nov 2008 05:53:17 +0200
Received: from trn.iki.fi (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP id 7F7BC45B7BE0D
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 05:53:16 +0200 (EET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 05:53:16 +0200 (EET)
Message-ID: <4917B029.7010809@trn.iki.fi>
Date: Mon, 10 Nov 2008 05:53:13 +0200
From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To: alsa-devel@alsa-project.org
References: <487F10EE.6030405@trn.iki.fi> <48883AAC.6060101@ladisch.de>
In-Reply-To: <48883AAC.6060101@ladisch.de>
Subject: Re: [alsa-devel] Roland/Edirol M-16DX
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
	http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
X-LimZero: valid lzID=rlk9

Sorry about late reply.

> It appears to have most of the audio class descriptors, so it should be
> possible to tell the driver to just use it.
> 
> Please try to add the following entry somewhere in sound/usb/usbquirks.h
> and to recompile the driver:
> 
> 
> {
> 	/* Edirol M-16DX */
> 	USB_DEVICE(0x0582, 0x00c4),
> 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
> 		.ifnum = QUIRK_ANY_INTERFACE,
> 		.type = QUIRK_COMPOSITE,
> 		.data = (const struct snd_usb_audio_quirk[]) {
> 			{
> 				.ifnum = 0,
> 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
> 			},
> 			{
> 				.ifnum = 1,
> 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
> 			},
> 			{
> 				.ifnum = 2,
> 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
> 				.data = & (const struct snd_usb_midi_endpoint_info) {
> 					.out_cables = 0x0001,
> 					.in_cables  = 0x0001
> 				}
> 			},
> 			{
> 				.ifnum = -1
> 			}
> 		}
> 	}
> },

This allows the device to be detected correctly and capture seems to be 
working flawlessly. Playback also works, but there is a severe three 
second distortion in audio once every 30 seconds, at 48 kHz. This seems 
to be related to the device sampling rate, as the cycle is only 15 
seconds when the device is running at 96 kHz.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070902010208090204010009
Content-Type: message/rfc822;
 name="Liitetty viesti"
Content-Disposition: inline;
 filename="Liitetty viesti"
Content-Transfer-Encoding: 7bit

Return-Path: <james@jamestrev.com>
X-Original-To: tronic@trn.iki.fi
Delivered-To: tronic@trn.iki.fi
Received: from trn.iki.fi (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP id A34BA45B7D28C
	for <tronic@trn.iki.fi>; Fri, 14 Nov 2008 01:55:13 +0200 (EET)
Received: from bigbox.jt.com (host-83-217-174-146.sta.dsl.vispa.com [83.217.174.146])
	by trn.iki.fi (Postfix) with ESMTP
	for <tronic+cv5n@trn.iki.fi>; Fri, 14 Nov 2008 01:55:12 +0200 (EET)
Received: from [192.168.10.13] (babybox.jt.com [::ffff:192.168.10.13])
  by bigbox.jt.com with esmtp; Fri, 14 Nov 2008 00:07:29 +0000
  id 0084C005.491CC141.00005F44
Subject: Re: [alsa-devel] Roland/Edirol M-16DX
From: James Trevelyan <james@jamestrev.com>
To: "Lasse =?ISO-8859-1?Q?K=E4rkk=E4inen?=" <tronic+cv5n@trn.iki.fi>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de,
  james@jamestrevelyan.com, timc@wnsp.com
In-Reply-To: <491C6E10.7090308@trn.iki.fi>
References: <487F10EE.6030405@trn.iki.fi> <48883AAC.6060101@ladisch.de>
	 <4917B029.7010809@trn.iki.fi>  <491C6E10.7090308@trn.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Fri, 14 Nov 2008 00:55:01 +0000
Message-Id: <1226624101.4836.95.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.0 
X-LimZero: valid lzID=cv5n
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-11-13 at 20:12 +0200, Lasse K=E4rkk=E4inen wrote:
> Has anyone been able to solve the distortion problem yet?
>=20
> It seems like a broken ringbuffer implementation. The distortion itself=
=20
> seems to be just the signal itself in different phase. I tested this=20
> with a 441 Hz (100 samples) sine wave played thru the device and=20
> recorded back. The recording is here:
> http://zi.fi/debug/M16DX-bug.flac

I haven't solved it yet, though I exchanged emails with Tim Camp who
reported that he had this working when the device was set to 44.1khz (I
haven't had a chance to try this)

I had previously done something similar to Lasse in re-recording a test
signal and noticed the same interesting patterns.  However, I also did
some usb-logging, and when I reassembled the data stream being sent to
the device it was as it should be, i.e. uncorrupted, suggesting that the
distortion is being caused in the device, and the driver isn't sending a
corrupted data stream (though obviously something in the way it is sent
is upsetting the device)

I also did some usb-logging under Windows (where it works) and
disappointingly couldn't see any obvious difference in the way the data
was sent.  I played around with things like the size of the urbs in the
driver to try to make the raw usb data look the same, but it had no
effect.

However, what I did notice is that in all circumstances the windows
driver was capturing at the same time as playback, even when I was not
asking it to record.  This suggests to me that the comment in the driver
source about synchronising playback to capture has some relevance ...

James


--------------070902010208090204010009
Content-Type: message/rfc822;
 name="Liitetty viesti"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Liitetty viesti"

Return-Path: <clemens@ladisch.de>
X-Original-To: tronic@trn.iki.fi
Delivered-To: tronic@trn.iki.fi
Received: from trn.iki.fi (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP id 1C73145B7D280
	for <tronic@trn.iki.fi>; Fri, 14 Nov 2008 10:12:39 +0200 (EET)
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com [66.111.4.25])
	by trn.iki.fi (Postfix) with ESMTP
	for <tronic+cv5n@trn.iki.fi>; Fri, 14 Nov 2008 10:12:39 +0200 (EET)
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 19C3D1B4B4D;
	Fri, 14 Nov 2008 03:12:38 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 14 Nov 2008 03:12:38 -0500
X-Sasl-enc: oLLt9i8Rmbv9HSIss5FczHuwW6BR64JrNx3YjspqLxA6 1226650357
Received: from [10.1.2.10] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F361F1EAC1;
	Fri, 14 Nov 2008 03:12:36 -0500 (EST)
Message-ID: <491D3300.5050405@ladisch.de>
Date: Fri, 14 Nov 2008 09:12:48 +0100
From: Clemens Ladisch <clemens@ladisch.de>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: James Trevelyan <james@jamestrev.com>
CC: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+cv5n@trn.iki.fi>,
 alsa-devel@alsa-project.org, james@jamestrevelyan.com, timc@wnsp.com
Subject: Re: [alsa-devel] Roland/Edirol M-16DX
References: <487F10EE.6030405@trn.iki.fi> <48883AAC.6060101@ladisch.de>	 <4917B029.7010809@trn.iki.fi>  <491C6E10.7090308@trn.iki.fi> <1226624101.4836.95.camel@localhost>
In-Reply-To: <1226624101.4836.95.camel@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-LimZero: valid lzID=cv5n

James Trevelyan wrote:
> ...
> However, what I did notice is that in all circumstances the windows
> driver was capturing at the same time as playback, even when I was not
> asking it to record.  This suggests to me that the comment in the driver
> source about synchronising playback to capture has some relevance ...

Indeed.  The driver would have to send the data at the exact speed of
the device's internal clock, and the only way to determine that clock's
speed is to capture data.

So far I haven't found the time to rewrite the driver to support this
synchronization mechanism.


Best regards,
Clemens

--------------070902010208090204010009
Content-Type: message/rfc822;
 name="Liitetty viesti"
Content-Disposition: inline;
 filename="Liitetty viesti"
Content-Transfer-Encoding: 7bit

Return-Path: <timc@wnsp.com>
X-Original-To: tronic@trn.iki.fi
Delivered-To: tronic@trn.iki.fi
Received: from trn.iki.fi (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP id 63FFA45B7D2A5
	for <tronic@trn.iki.fi>; Fri, 14 Nov 2008 17:00:58 +0200 (EET)
Received: from epiphanyhosting.com (epiphanyhosting.com [69.20.16.212])
	by trn.iki.fi (Postfix) with ESMTP
	for <tronic+cv5n@trn.iki.fi>; Fri, 14 Nov 2008 17:00:57 +0200 (EET)
Received: (qmail 31530 invoked from network); 14 Nov 2008 09:00:57 -0600
Received: from unknown (HELO ?192.168.2.244?) (69.57.49.1)
  by epiphanyhosting.com with SMTP; 14 Nov 2008 09:00:56 -0600
Subject: Re: [alsa-devel] Roland/Edirol M-16DX
From: Tim Camp <timc@wnsp.com>
Reply-To: timc@wnsp.com
To: James Trevelyan <james@jamestrev.com>
Cc: Lasse =?ISO-8859-1?Q?K=E4rkk=E4inen?= <tronic+cv5n@trn.iki.fi>,  alsa-devel@alsa-project.org, clemens@ladisch.de, james@jamestrevelyan.com
In-Reply-To: <1226624101.4836.95.camel@localhost>
References: <487F10EE.6030405@trn.iki.fi> <48883AAC.6060101@ladisch.de>
	 <4917B029.7010809@trn.iki.fi>  <491C6E10.7090308@trn.iki.fi>
	 <1226624101.4836.95.camel@localhost>
Content-Type: text/plain; charset=utf-8
Organization: Dot Com Plus L.L.C.
Date: Fri, 14 Nov 2008 08:59:19 -0600
Message-Id: <1226674759.16066.3.camel@operations.dotcom>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.1.1 
X-LimZero: valid lzID=cv5n
Content-Transfer-Encoding: quoted-printable

James,

Reading your email I was struck by something.
I also have a digital I/O connected to the mixer from the pc.
I wonder if this is allowing the clocks to sync?

Just a thought.

Tim

On Fri, 2008-11-14 at 00:55 +0000, James Trevelyan wrote:
> On Thu, 2008-11-13 at 20:12 +0200, Lasse K=C3=A4rkk=C3=A4inen wrote:
> > Has anyone been able to solve the distortion problem yet?
> >=20
> > It seems like a broken ringbuffer implementation. The distortion itse=
lf=20
> > seems to be just the signal itself in different phase. I tested this=20
> > with a 441 Hz (100 samples) sine wave played thru the device and=20
> > recorded back. The recording is here:
> > http://zi.fi/debug/M16DX-bug.flac
>=20
> I haven't solved it yet, though I exchanged emails with Tim Camp who
> reported that he had this working when the device was set to 44.1khz (I
> haven't had a chance to try this)
>=20
> I had previously done something similar to Lasse in re-recording a test
> signal and noticed the same interesting patterns.  However, I also did
> some usb-logging, and when I reassembled the data stream being sent to
> the device it was as it should be, i.e. uncorrupted, suggesting that th=
e
> distortion is being caused in the device, and the driver isn't sending =
a
> corrupted data stream (though obviously something in the way it is sent
> is upsetting the device)
>=20
> I also did some usb-logging under Windows (where it works) and
> disappointingly couldn't see any obvious difference in the way the data
> was sent.  I played around with things like the size of the urbs in the
> driver to try to make the raw usb data look the same, but it had no
> effect.
>=20
> However, what I did notice is that in all circumstances the windows
> driver was capturing at the same time as playback, even when I was not
> asking it to record.  This suggests to me that the comment in the drive=
r
> source about synchronising playback to capture has some relevance ...
>=20
> James
>=20


--------------070902010208090204010009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070902010208090204010009--
