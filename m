From: <jeff_patterson@agilent.com>
Subject: S/PDIF (IE958) and midi MTC sync?
Date: Tue, 22 Feb 2005 18:05:05 -0700
Message-ID: <BF945D7B72651847BF30F210A833A2BD1A28E4@wcosmb06.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sorry if this is not a good topic for this list but I've gotten so many =
bum steers in the past month that I really need some input from someone =
who knows what in the hell they're talking about.

I've been trying unsuccessfully to get my HDR (VS-880) to sync reliably =
to various ALSA apps via midi MTC. The object is to download music =
tracks from the HDR two at a time via the spdif interface using my =
roland UA-5 (usb) and have them line up in time. The midi connection is =
made via either the game port of an ES1371 or a UA-1 (usb). Neither =
work. The application slaves up to MTC just fine but the tracks end up =
mis-aligned in time.

Question 1 for the gurus: Can this ever work? The application =
documentation would certainly lead you to believe it is possible but =
given that the midi time code is on a completely different channel than =
the digital audio samples (with presumably different latency), what =
could ever tie a particular sample to a particular MTC time stamp?

Question 2: Could I use the iec958 alsa plugin and just write the raw =
samples to a file? The plug-in documentation implies it only works for =
32 bit data but I thought IEC958 could use 16,24 and 32 bit data. In my =
case the format is S24_3LE.

Trying a variant of the above idea with arecord, I get a bunch of zero =
samples at the beginning (until I hit play on the HDR and real data =
starts streaming). I would have thought the port would block until it =
got a data derived clock. Is there someway to achieve the desired =
behavior with existing tools? Could I write a plug-in that would block =
on null samples or is that another black hole?

Any help or insight on this problem would be greatly, greatly  =
appreciated.

Jeff

 =20


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
