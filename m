From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400,PATCH RFC,v3 0/9] M-Audio Fast Track C400
Date: Tue, 27 Nov 2012 17:00:49 +0100
Message-ID: <1354032058-668-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 41F932652BB
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 17:01:06 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so4944982bkc.38
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 08:01:06 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
Cc: Grant Diffey <gdiffey@gmail.com>, George Willian Condomitti <georgecondomitti@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Hi,

The following patches adds support for the M-Audio Fast Track C400.
This is version 3 of the patch series.

v2:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-November/056750.html

This series applies against the latest mainline tree, 3.7-rc7
(HEAD 2844a48706e54ddda4a04269dba4250b42f449de )

* First of all, everything works: mixer controls, effects control,
playback and capture (with the correct sampling frequency set).
Note that the device doesn't really have a master control or left/right
pan. It's just "emulated" in the software.

* To deal with the mixer channel IDs, limited by cmask bit length,
I introduced an offset value. This allows to get rid of the shorehorning
of the IDs into cmask and device-referencing in the low-level functions.
Is this a good approach?

* Audio in/out seems to work good in this series, mainly because the
playback is an implicit feedback endpoint, and it is now configured
with the capture endpoint as its sync-buddy. Also needed to correct
the calculation, because of the different channel numbers between
the two endpoints on the C400 (6 playback - implicit feedback, 4 capture).

* The clock sources are still named "Unit 129" (0x81, internal) and
"Unit 130" (0x82, SPDIF). I'll fix this later. I also plan to fix the
channel names (i.e., instead of "AIn3", use "SPDIF In L").

* I've touched one FTU mixer creation function. I'd appreciate if someone
can test this with the FTU to make sure I didn't break something.
(I haven't gotten any feedback on that one yet)

Cheers,
Eldad

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

Eldad Zack (9):
  usb-audio: replace hardcoded value with const
  usb-audio: use sender stride for implicit feedback
  usb-audio: add control index offset
  usb-audio: skip UAC2 EFFECT_UNIT
  usb-audio: parameterize FTU effect unit control
  usb-audio: M-Audio Fast Track C400 quirks table
  usb-audio: Fast Track C400 mixer ranges
  usb-audio: Fast Track C400 mixer controls
  usb-audio: FT C400 sync playback EP to capture EP

 sound/usb/endpoint.c     |    9 ++-
 sound/usb/mixer.c        |   53 +++++++++++-
 sound/usb/mixer.h        |    1 +
 sound/usb/mixer_quirks.c |  216 ++++++++++++++++++++++++++++++++++++++++++++--
 sound/usb/pcm.c          |   15 +++-
 sound/usb/quirks-table.h |   71 +++++++++++++++
 6 files changed, 351 insertions(+), 14 deletions(-)

-- 
1.7.8.6
