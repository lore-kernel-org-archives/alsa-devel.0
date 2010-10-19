From: Eliot Blennerhassett <ewblen+alsadevel@gmail.com>
Subject: emachines em350 quirk
Date: Tue, 19 Oct 2010 18:44:06 +1300
Message-ID: <AANLkTin-VeC0KqH9ndHM-EPyTi1vZTZcPtFMfhAtQvRm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AD3FB103803
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 07:44:08 +0200 (CEST)
Received: by wwb34 with SMTP id 34so1150619wwb.20
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2010 22:44:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Greetings,

I have this emachines em350 notebook, which is equipped with ALC272X
codec (a personal project this time...)
By default the internal mic does not work.
(See also https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/639846)

Using hda_analyzer, The internal mic appears to be a digital mic on NID 12
This change enables it:

Diff for codec 0/0 (0x10ec0272):
---
+++
@@ -312,12 +312,12 @@
      0x0c 0x0d* 0x0e
 Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals: [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x00 0x00]
   Connection: 10
      0x18 0x19 0x1a 0x1b 0x1d 0x14 0x15 0x16 0x0b 0x12
 Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
-  Amp-In vals: [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
+  Amp-In vals: [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 10
      0x18 0x19 0x1a 0x1b 0x1d 0x14 0x15 0x16 0x0b 0x13

According to the ALC272 datasheet, there is no feedthrough path from
DMIC to analog out.
Also no

Some of the other controls for this netbook are also superfluous.
It only has (as far as I can make out)
Internal speaker on NID 0x14 (LOUT1 PORT-D)
Internal mic: DMIC on NID 0x12 (DMIC-1/2)
External headphone on NID 0x21 (HP-OUT PORT-I)
External mic on NID 0x18 (MIC1 PORT-B)



So, I'm looking for either an existing model=X to use with this
machine, or how to create a new one?

regards

Eliot
