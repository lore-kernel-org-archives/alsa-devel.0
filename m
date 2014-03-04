From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [FFADO-devel] [PATCH 18/39] firewire-lib: Add a
 fallback at RCODE_CANCELLED
Date: Tue, 4 Mar 2014 10:28:15 +0100
Message-ID: <20140304102815.4c7428c0@stein>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-19-git-send-email-o-takashi@sakamocchi.jp>
 <20140228212535.7606e0d8@stein> <5311517B.5060905@sakamocchi.jp>
 <20140301111013.483fd7df@stein> <5311D0FC.7020302@sakamocchi.jp>
 <20140301152050.5de701a3@stein>
 <20140304013535.GP15773@marvin.atrad.com.au>
 <20140304093323.31b314d1@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id C8C5C26573F
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 10:28:18 +0100 (CET)
In-Reply-To: <20140304093323.31b314d1@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

I wrote:
>>>>> Since FFADO applies 200 ms or more as FCP
>>>>> transaction timeout, shouldn't firewire-lib's fcp.c increase
>>>>> FCP_TIMEOUT_MS from 125 to 200 or more as well?

FFADO took over the 200 ms timeout from libavc1394, where it was
introduced by this changeset:
http://sourceforge.net/p/libavc1394/code/24/

Commit [r24]
    increase timeout
Authored by: ddennedy 2002-10-01

--- a/trunk/libavc1394/libavc1394/avc1394_internal.h
+++ b/trunk/libavc1394/libavc1394/avc1394_internal.h
@@ -8,7 +8,7 @@
 #define MAX_RESPONSE_SIZE 512
 #define AVC1394_RETRY 2
 #define AVC1394_SLEEP 10000
-#define AVC1394_POLL_TIMEOUT 100
+#define AVC1394_POLL_TIMEOUT 200
 /* #define DEBUG */
 
 void htonl_block(quadlet_t *buf, int len);

So this was certainly not done particularly for audio devices.
And interestingly, the immediate parent commit r23 on 2002-09-28 corrected
the timeout from 50 ms to 100 ms.
-- 
Stefan Richter
-=====-====- --== --=--
http://arcgraph.de/sr/
