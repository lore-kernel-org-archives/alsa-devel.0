From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: firewire-motu: add support for
	AudioExpress
Date: Sun, 20 Aug 2017 21:25:02 +0900
Message-ID: <20170820122504.24486-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id EFC412673DF
 for <alsa-devel@alsa-project.org>; Sun, 20 Aug 2017 14:25:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is to add support for MOTU AudioExpress. Any PCM frames and
MIDI messages are transferred in rx/tx isochronous packets.
Correspondingly, this adds an arrangement for specification flag for
position of existence flag of MIDI messages.

I note that this unit has a quirk of acknowledge code against request
subaction on asynchronous communication. In detail, please refer to 2nd
patch of this set. To easy my development, I applied a patch to
'firewire-ohci' module on my develop ment tree. You can see the content in
the end of this message. It's really a band-aid for the aim and can not be
merged as what it is.

Unfortunately, current implementations of IEC 61883-1/6 packet streaming
engine is not good enough in a point to presentation timestamp, as I
reported[1]. Any plaback stream for the unit still causes periodical noise.

[1] [alsa-devel] Status of ALSA firewire stack at Linux v4.12 development period
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/120061.html

-------- 8< --------
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 8bf89267dc25..06a0906a9b56 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1499,6 +1499,10 @@ static int handle_at_packet(struct context *context,
                packet->ack = evt - 0x10;
                break;
 
+       case 0x10:
+               packet->ack = ACK_PENDING;
+               break;
+
        case OHCI1394_evt_no_status:
                if (context->flushing) {
                        packet->ack = RCODE_GENERATION;
-------- 8< --------


Takashi Sakamoto (2):
  ALSA: firewire-motu: add specification flag for position of flag for
    MIDI messages
  ALSA: firewire-motu: add support for MOTU Audio Express

 sound/firewire/motu/motu-pcm.c         |  2 +-
 sound/firewire/motu/motu-protocol-v2.c |  5 -----
 sound/firewire/motu/motu-protocol-v3.c |  5 -----
 sound/firewire/motu/motu-stream.c      | 38 ++++++++++++++++++++++++++++++++--
 sound/firewire/motu/motu.c             | 24 ++++++++++++++++++---
 sound/firewire/motu/motu.h             |  6 +++++-
 6 files changed, 63 insertions(+), 17 deletions(-)

-- 
2.11.0
