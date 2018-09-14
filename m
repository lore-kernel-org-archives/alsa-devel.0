From: KillerRex <killerrex@gmail.com>
Subject: Wrong UCM profile for Dell TB16 / WD15
Date: Fri, 14 Sep 2018 19:28:20 +0200
Message-ID: <CAE3rXveor5uEB_-p6v+QZJkiLMQKJdkug_QnBoTLo0dWmuR9ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E20A267782
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2018 19:28:33 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id q8-v6so2761041wmq.4
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2018 10:28:33 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I have a Dell TB16 (same sound hardware as the WD15) and since the update
to kernel 4.18 pulseaudio does not recognise any more the audio ports in
the dock.

After some work tracking the problem I have found that pulseaudio reports a
failure when using the UCM profile from Dell-WD15-Dock:
...
(   0.027|   0.000) I: [pulseaudio] module-alsa-card.c: Found UCM profiles
(   0.027|   0.000) D: [pulseaudio] alsa-ucm.c: UCM mapping: Mapping HiFi:
hw:WD15Dock,0: source dev Mic
(   0.027|   0.000) D: [pulseaudio] alsa-ucm.c: UCM mapping: Mapping HiFi:
hw:WD15Dock,1: sink dev LineOut
(   0.027|   0.000) D: [pulseaudio] alsa-ucm.c: UCM mapping: Mapping HiFi:
hw:WD15Dock,0: sink dev Headphone
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Profile HiFi (Default),
input=(null), output=(null) priority=8000, supported=yes
n_input_mappings=1, n_output_mappings=2
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Input HiFi:
hw:WD15Dock,0: source
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Output HiFi:
hw:WD15Dock,1: sink
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Output HiFi:
hw:WD15Dock,0: sink
(   0.027|   0.000) I: [pulseaudio] alsa-ucm.c: Set ucm verb to HiFi
(   0.027|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:WD15Dock,1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.028|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid value for
card
(   0.028|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device
hw:WD15Dock,1: No such device
...

The problem is that the device is called "Dock" and not "WD15Dock" so
changing the file "alsa/ucm/Dell-WD15-Dock/HiFi.conf" with the right device
name corrects the problem:
--- alsa/ucm/Dell-WD15-Dock/HiFi.conf_ori 2018-09-14 17:54:35.022035850
+0200
+++ alsa/ucm/Dell-WD15-Dock/HiFi.conf 2018-09-14 17:54:55.722248500 +0200
@@ -3,7 +3,7 @@

  Value {
  PlaybackChannels "2"
- PlaybackPCM "hw:WD15Dock,0"
+ PlaybackPCM "hw:Dock,0"
  }
 }

@@ -12,7 +12,7 @@

  Value {
  PlaybackChannels "2"
- PlaybackPCM "hw:WD15Dock,1"
+ PlaybackPCM "hw:Dock,1"
  }
 }

@@ -21,6 +21,6 @@

  Value {
  CaptureChannels "2"
- CapturePCM "hw:WD15Dock,0"
+ CapturePCM "hw:Dock,0"
  }
 }

Is this the right change or the real problem is that the device name is
"Dock" instead "WD15Dock"?
Removing the "WD15" from the name is better, in that way it is also valid
for the TB16.

Thanks

Andres Ayala
