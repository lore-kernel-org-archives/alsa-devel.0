From: Adam Richter <adam_richter2004@yahoo.com>
Subject: Possible fix for snd-hda-intel model=no-jd failing
	since ~linux-3.9-rc1
Date: Thu, 11 Sep 2014 00:47:19 -0700
Message-ID: <1410421639.47518.YahooMailNeo@web160601.mail.bf1.yahoo.com>
Reply-To: Adam Richter <adam_richter2004@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="1737431079-1326721894-1410421639=:47518"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm8-vm0.bullet.mail.bf1.yahoo.com
 (nm8-vm0.bullet.mail.bf1.yahoo.com [98.139.213.95])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A46B265125
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 09:54:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--1737431079-1326721894-1410421639=:47518
Content-Type: text/plain; charset=us-ascii

Hi.

This is a bug and suggested temporary fix that I originally posted to the linux-sound mailing list about a month and a half ago.  I am grateful to Takashi Awai for informing me after my follow-up inquiry about it today that I should submit it to the alsa-devel mailing list instead.  Please feel free to redirect me further if appropriate.  I did not notice any contact information for sound/pci/hda in
linux-3.16-rc4/MAINATINERS.

Anyhow, here is the bug report and a one line proposed temporary fix.


The "model=no-jd" argument has not initialized the analog audio output jack correctly for me since linux-3.9-rc1 (if I recall correctly) through linux-3.17-rc4, although I have not tried every release candidate in between.

The symptom is that, on a computer with an analog audio output jack
that has incorrect jack sense (a hardware bug), audio output is completely muted until I physically replug the cable, even though I specified "model=no-jd" as an argument to the snd-hda-intel kernel module, which is supposed to cause the kernel to ignore the jack sense reported by hardware and just drive the audio output even if the hardware jack sense indicates nothing is plugged in.  This problem did not occur until approximate Linux 3.9-rc1.

I have found a few single line workarounds that work, of which my
favorite is the following (also attached to this email, in case any
mailer subjects this message to reformatting), because it does not add
code to anything that gets called frequently.

--- linux-3.17.0-rc4-64bit/sound/pci/hda/hda_jack.c.orig    2014-09-07 16:09:43.000000000 -0700
+++ linux-3.17.0-rc4-64bit/sound/pci/hda/hda_jack.c    2014-09-10 18:41:53.422900040 -0700
@@ -106,6 +106,7 @@ snd_hda_jack_tbl_new(struct hda_codec *c
     jack->nid = nid;
     jack->jack_dirty = 1;
     jack->tag = codec->jacktbl.used;
+    jack->phantom_jack = codec->no_jack_detect;
     return jack;
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_tbl_new);


Signed-off-by: Adam J. Richter <adam_richter2004@yahoo.com>


I consider this a workaround rather than than a perfect fix, because I
think the underlying problem seems to be some kind of initialization
order issue that I don't fully understand.  Basically, by the time
jack->phantom_jack was being set, some caller had already called
jack_detect_update(), which loaded the incorrect jack sense result
from hardware and cleared jack->jack_dirty, so the jack sense would
not be set again.  At least that is what I think the underlying
problem probably is.

Also, if a change like this is to be integrated, I'd like to know if
it might be better for the line that I added to be:

          jack->phantom_jack = !is_jack_detectable(codec, nid);

...which is what add_jack_kctl does (not sure why add_jack_kctls does
not, by the way, at the risk of making a spectacle of my ignorance).
My doubt about this approach is that perhaps is_jack_detectable()
relies on some initialization that has not occurred at that point.

Anyhow, I'd like to get the process started of either pushing this
change upstream or quickly developing a more correct fix.  If a more
correct fix does not become apparent in the next few days, I would
recommend pushing the workaround upstream now until some future code
cleanup, so people will no longer be effected by the bug.

Any technical input or advice on how to proceed is welcome.  Thanks
for taking the time to consider this.


Adam Richter

--1737431079-1326721894-1410421639=:47518
Content-Type: text/x-patch; name="jack.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="jack.diff"

LS0tIGxpbnV4LTMuMTcuMC1yYzQtNjRiaXQvc291bmQvcGNpL2hkYS9oZGFf
amFjay5jLm9yaWcJMjAxNC0wOS0wNyAxNjowOTo0My4wMDAwMDAwMDAgLTA3
MDAKKysrIGxpbnV4LTMuMTcuMC1yYzQtNjRiaXQvc291bmQvcGNpL2hkYS9o
ZGFfamFjay5jCTIwMTQtMDktMTAgMTg6NDE6NTMuNDIyOTAwMDQwIC0wNzAw
CkBAIC0xMDYsNiArMTA2LDcgQEAgc25kX2hkYV9qYWNrX3RibF9uZXcoc3Ry
dWN0IGhkYV9jb2RlYyAqYwogCWphY2stPm5pZCA9IG5pZDsKIAlqYWNrLT5q
YWNrX2RpcnR5ID0gMTsKIAlqYWNrLT50YWcgPSBjb2RlYy0+amFja3RibC51
c2VkOworCWphY2stPnBoYW50b21famFjayA9IGNvZGVjLT5ub19qYWNrX2Rl
dGVjdDsKIAlyZXR1cm4gamFjazsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKHNu
ZF9oZGFfamFja190YmxfbmV3KTsK

--1737431079-1326721894-1410421639=:47518
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--1737431079-1326721894-1410421639=:47518--
