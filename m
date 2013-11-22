From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: firewire-lib: an issue to generate packet with 'no
 data' in blocking mode
Date: Fri, 22 Nov 2013 22:53:55 +0900
Message-ID: <528F61F3.5050706@sakamocchi.jp>
References: <528EF2DE.9060700@sakamocchi.jp> <528F4462.3000909@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060408040907020004010605"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FCF5261AC1
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 14:54:03 +0100 (CET)
In-Reply-To: <528F4462.3000909@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060408040907020004010605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Clemens,

 > I guess I just didn't notice that empty packets don't need to change
 > their FDF field.  This is a bug.

I also paied no attension to empty packets. Then BeBoB chipset teach me.

 > Empty packets should be fine for all devices.  (NO-DATA packets would
 > waste DMA bandwidth.)

I completely agree with you. Would you review an attached patch?


Thanks

Takashi Sakamoto

(Nov 22 2013 20:47), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> I have a question about generate packet with 'no data' in blocking mode.
>> I think there is out of specification in current firewire-lib.
>>
>> In my understanding of IEC 61883-6, there are two ways:
>>
>> 1. generate 'empty packet' defined in IEC 61883-1
>>     - size of packet is 2 quadlets
>>     - FDF = sfc
>>     - packet includes just CIP headers
>>
>> 2. generate 'special non-empty packet' defined in IEC 61883-6
>>     - size of packet is following to blocking mode
>>     - FDF = 0xff ('NO-DATA' code)
>>     - packet includes dummy data
>>
>> But current implementation is a strange combination of them.
>>   - size of packet is 2 (way 1)
>>   - FDF = 0xff (way 2)
>
> It's an empty NO-DATA packet.  ;-)
>
> I guess I just didn't notice that empty packets don't need to change
> their FDF field.  This is a bug.
>
>> If this is a qurk for some devices, I'll prepare patches to switch
>> generating mode because BeBoB cannot sound with current firewire-lib. If
>> this is a bug, then I want to discuss which is better for firewire-lib.
>
> Empty packets should be fine for all devices.  (NO-DATA packets would
> waste DMA bandwidth.)
>
>
> Regards,
> Clemens

--------------060408040907020004010605
Content-Type: text/x-patch;
 name="0001-firewire-lib-fix-wrong-value-for-FDF-field-in-out-pa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-firewire-lib-fix-wrong-value-for-FDF-field-in-out-pa.pa";
 filename*1="tch"

>From 52312ed0989669a4f15c33e3a3c64da79519480f Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Thu, 21 Nov 2013 14:21:06 +0900
Subject: [PATCH 1/1] firewire-lib: fix wrong value for FDF field as an empty packet

This commit fix out of specification about the value of FDF field in out packet
with 'no data'. This affects blocking mode.

According to IEC 61883-6, there is two way to generate AMDTP packets include no
data in blocking mode.

Way 1. an empty packet defined in IEC 61883-1
 - Size of packet is 2 quadlets.
 - The value of FDF is sfc.
 - The packet includes only CIP headers

Way 2. a special non-empty packet defined in IEC 61883-6
 - Size of packet is following to blocking mode
 - The value of FDF is 0xff. This value is 'NO-DATA'. This means 'The receiver'
   must ignore all the data in a CIP with this FDF code'.
 - The packet includes dummy data.

But current implementation is a combination of them.
 - Size of packet is 2 (way 1)
 - FDF = 0xff (way 2)
This causes BeBoB chipset cannot sound.

This patch applies Way 1.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 amdtp.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/amdtp.c b/amdtp.c
index d322689..a998983 100644
--- a/amdtp.c
+++ b/amdtp.c
@@ -434,17 +434,14 @@ static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
 		return;
 	index = s->packet_index;
 
+	/* this module generate empty packet for 'no data' */
 	syt = calculate_syt(s, cycle);
-	if (!(s->flags & CIP_BLOCKING)) {
+	if (!(s->flags & CIP_BLOCKING))
 		data_blocks = calculate_data_blocks(s);
-	} else {
-		if (syt != 0xffff) {
-			data_blocks = s->syt_interval;
-		} else {
-			data_blocks = 0;
-			syt = 0xffffff;
-		}
-	}
+	else if (syt != 0xffff)
+		data_blocks = s->syt_interval;
+	else
+		data_blocks = 0;
 
 	buffer = s->buffer.packets[index].buffer;
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
-- 
1.8.3.2


--------------060408040907020004010605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060408040907020004010605--
