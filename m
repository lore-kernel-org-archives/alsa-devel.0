From: "Stephen Warren" <SWarren@nvidia.com>
Subject: [PATCH] azx/realtek: Cleanup of the W810 system support.
Date: Wed, 5 Jan 2005 12:39:07 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B003CE102B@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

Clean-ups of the W810 support in azx/patch_realtek.c

* Correctly size a couple of static data arrays.

* Fix alc880_ch_mode_get so it only accesses index 0 of
spec->channel_mode,
  in case there's only one entry.

* Add separate mute switch for headphone/speaker output pin of the W810

* Set all amps to be zero-volume, and pins to be muted, in the
initialization
  verb sequence, like a standard ALSA driver.

* Enable SPDIF object creation (set dig_out_nid)

* Fix a lot of W810-specific comments to be more accurate.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---

Notes:

I hadn't realized that I'd included W810 support in my previous patch -
I'd meant to send that in later! This patch cleans up some of the
work-in-progress.

SPDIF output doesn't work on this system. The IEC958 muting control does
show up in alsamixer. This may be our application problem - I think
what's happening is that we can't open plug:iec958:... and just fall
back to analog mode.

DAC NID 0x02 is routed to both pin NID 0x14 (rear jack named "front")
and to pin NID 0x1b (connected to internal speakers, and headphone
jack). I've created a mixer element named "Headphone Playback Switch" to
allow the control of the mute for pin NID 0x1b. Is this the right way to
do this? Thanks for feedback.

Sorry about creating that bug in hda_codec.c!

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
