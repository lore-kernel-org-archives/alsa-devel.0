From: Raj Upadhyaya <raj.upadhyaya@gmail.com>
Subject: repeated hda_codec_cleanup_stream
Date: Wed, 23 Jan 2013 07:55:34 -0600
Message-ID: <1358949334.11046.13.camel@localhost.localdomain>
Reply-To: raj@upadhyaya.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id CB6612652AD
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2013 14:55:37 +0100 (CET)
Received: by mail-ie0-f180.google.com with SMTP id c10so13425077ieb.39
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2013 05:55:36 -0800 (PST)
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

(Bugzilla bug title..)

[Fwd: [Bug 894259] Sound is garbled on playback of OGG, MP3s, WAV files
and videos with sound.]


I am trying to debug why I have some sound problems with my set up.  I
have recently recompiled the kernel to 3.8.0-rc4.  Here is a suggestion
that I got recently from the debugging session.  The message -> ALSA
hda_codec.c:1499 hda_codec_cleanup_stream: is coming up in dmesg quite
often.  Is this OK, given my kernel compile options?


- Raj
-------- Forwarded Message --------
From: bugzilla@redhat.com
To: raj@upadhyaya.com
Subject: [Bug 894259] Sound is garbled on playback of OGG, MP3s, WAV
files and videos with sound.
Date: Wed, 23 Jan 2013 06:04:20 +0000

Product: Fedora
https://bugzilla.redhat.com/show_bug.cgi?id=894259

--- Comment #17 from Raymond <superquad.vortex2@gmail.com> ---
i think you better report the repeated 
hda_codec_cleanup_stream to alsa development mailing list


.374225] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x25
[   32.374575] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x2
[   32.374581] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x3
[   32.374585] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x4
[   32.374588] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x5
[   32.374592] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x25
[   32.374916] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x2
[   32.374921] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x3
[   32.374925] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x4
[   32.374929] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x5
[   32.374932] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x25
[   32.375602] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x2
[   32.375607] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x3
[   32.375611] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x4
[   32.375615] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x5
[   32.375619] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x25
[   32.376435] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x2
[   32.376440] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x3
[   32.376444] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x4
[   32.376448] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x5
[   32.376452] ALSA hda_codec.c:1499 hda_codec_cleanup_stream: NID=0x25

-- 
You are receiving this mail because:
You reported the bug.
