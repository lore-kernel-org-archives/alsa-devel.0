From: Ralf Beck <musical_snake@gmx.de>
Subject: [PATCH]: snd_seq_virmidi.c do not use running status
 for virmidi raw input
Date: Wed, 07 May 2014 19:44:36 +0200
Message-ID: <536A7104.7010009@gmx.de>
Reply-To: ralfbeck1@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by alsa0.perex.cz (Postfix) with ESMTP id 069F0261AE7
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 19:44:41 +0200 (CEST)
Received: from [192.168.2.173] ([178.13.30.16]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MGSgq-1Wddvb1vYO-00DJq1 for
 <alsa-devel@alsa-project.org>; Wed, 07 May 2014 19:44:39 +0200
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

Rationale: Not every rawmidi alsa client (e.q. Bitwig) support running 
status on input.
There is also no need for running status inside a computer.

This patch disables the removal of the status byte when decoding 
snd_midi_event structures to a rawmidi bytestream

--- sound/core/seq/seq_virmidi.c.orig    2014-05-07 19:30:44.175914670 +0200
+++ sound/core/seq/seq_virmidi.c    2014-05-07 19:33:38.931906859 +0200
@@ -212,6 +212,7 @@ static int snd_virmidi_input_open(struct
          kfree(vmidi);
          return -ENOMEM;
      }
+        vmidi->parser->nostat = 1;
      vmidi->seq_mode = rdev->seq_mode;
      vmidi->client = rdev->client;
      vmidi->port = rdev->port;
