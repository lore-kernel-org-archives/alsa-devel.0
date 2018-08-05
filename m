From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Spectre x360 fixing the top speakers (again)
Date: Sun, 5 Aug 2018 11:28:57 -0500
Message-ID: <b34c110f-b5a0-6c02-4ad6-efb1990492bd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B3FB26770D
 for <alsa-devel@alsa-project.org>; Sun,  5 Aug 2018 18:29:01 +0200 (CEST)
Received: by mail-oi0-f51.google.com with SMTP id w126-v6so18105324oie.7
 for <alsa-devel@alsa-project.org>; Sun, 05 Aug 2018 09:29:00 -0700 (PDT)
Content-Language: en-US
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
Cc: tom@decompile.me.uk, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

It's only been since 4.18-rc2 that the speaker issue on the x360 [1] was 
resolved. I didn't even know I had four speakers until seeing that bug 
report. My HP Spectre x360 (13-ae0xx) has the same issue as the original 
x360 with Bang speakers.

The subsystem PCI ID is different [103c:83b9]. Of the two fixes 
developed in [1], only the mute led fix works when the PCI id is added 
to patch-realtek. If I try to add the full ALC295_FIXUP_HP_X360 fix, 
there's no audio coming out at all.

One thing I tried was to boot W10 virtual machine and redirect the audio 
PCI device to the VM:
0:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
It all worked in the VM, but as soon as I shut it down and tried to play 
audio from linux, the top speakers still didn't work. The difference 
being that PAVUcontrol could see a "4.0 output" configuration. The same 
issue: audio sent to the bottom speakers was heard, but audio sent to 
the top speakers was not.

Since I'm likely going to have to change _everything_ anyway, here's 
what I'm trying to achieve:


1) Make the top speakers great again. Whether they produce the same 
sound as the bottom speakers, or have their own audio channel, I don't 
care that much.

2) Be able to use the speakers when something is plugged in the 
headphone jack. Right now it's stupid. I try to plug in a microphone 
(with the proper TRRS jack), and the speakers die. I haven't seen this 
before. I was playing with HDA-Analyzer and was able to get speaker 
sounds with a dummy plugged in the jack, so I know it's possible. I 
don't remember how I did it, and it only worked once.

3) (optional) see if there's a way to use the jack as a line in or 
stereo mic in.

I'm not sure where to start.

Alex

[1] https://bugzilla.kernel.org/show_bug.cgi?id=189331
