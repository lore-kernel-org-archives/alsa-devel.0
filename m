From: David Henningsson <david.henningsson@canonical.com>
Subject: Internal Mics and Speakers not visible in PulseAudio
Date: Wed, 30 May 2012 14:46:48 +0200
Message-ID: <4FC616B8.3090608@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030500040501050708060900"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 66B8724778
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 14:46:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030500040501050708060900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Posted to both alsa-devel and pulseaudio-discuss lists, as this is a 
cross issue.

PulseAudio tries to figure out what equipment is present on the machine 
using the mixer. If it finds e g "Headphone Playback Volume", "Headphone 
Playback Switch", or "Headphone Jack", it assumes that a headphone is 
present and creates a headphone port. If it finds no ports, it creates a 
fallback "Analog Output" port.

Now assume that we have a laptop with speakers and a headphone jack, but 
with only a "Master Playback Volume", and a "Headphone Jack" for the 
jack detection.
PulseAudio will take the "Headphone Jack", and create a headphone port. 
Now, if this port is currently unconnected/unavailable, it will not show 
up at all [1]. As a result, the internal speakers - for which no port 
was created - will be essentially unusable.

Now, I thought this was a problem with a pair of machines only, that we 
could easily quirk on the PulseAudio side. But after looking through 
Ubuntu bugs and posting a blog post [2] about the issue, I have now 
collected 21 different machines affected, mostly on the input side. 
Several Realtek chips are affected on the dmic side, and some older 
STAC92xx chips have problems in both directions.
So it becomes evident to me, that this is something that needs to be 
fixed pretty fast.

So, to move forward, we need to expose these speakers and internal mics 
to userspace. A very simple (untested) patch is attached. This would 
make "Internal Mic Jack" and "Speaker Jack" show up. Note that the 
actual status can be overridden/ignored on the PulseAudio side - the 
importance here is the sign that there are internal mics and speakers, 
so that the PulseAudio ports get created.

I could develop it a little to make sure we don't actually do any jack 
detection for these pins but always return them as being true/present.
That is, if you approve the idea? I admit that the "Internal Mic Jack" 
is somewhat misleading/hacky as the internal mic is not connected to any 
physical jack, but it seems like the simplest way of resolving the 
problem currently.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] At least in Ubuntu's new Sound Settings UI.

[2] 
http://voices.canonical.com/david.henningsson/2012/05/22/three-audio-bugs-in-12-04/

--------------030500040501050708060900
Content-Type: text/x-patch;
 name="expose-intmic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="expose-intmic.patch"

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 2dd1c11..61becde 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -312,7 +312,7 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 		return 0;
 	def_conf = snd_hda_codec_get_pincfg(codec, nid);
 	conn = get_defcfg_connect(def_conf);
-	if (conn != AC_JACK_PORT_COMPLEX)
+	if (conn == AC_JACK_PORT_NONE)
 		return 0;
 
 	snd_hda_get_pin_label(codec, nid, cfg, name, sizeof(name), &idx);

--------------030500040501050708060900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030500040501050708060900--
