From: lieven moors <lievenmoors@gmail.com>
Subject: Re: [Patch v2] aconnect -x: Do not update index after
 removal of connection.
Date: Mon, 15 Mar 2010 23:30:31 +0100
Message-ID: <4B9EB507.1060406@gmail.com>
References: <4B9E306F.8070705@gmail.com>	<1268663545.9635.10.camel@mattotaupa>
	<4B9E7123.4000207@gmail.com> <1268686034.16974.39.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020302040200040109060709"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 06DEE10382A
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 23:30:34 +0100 (CET)
Received: by bwz20 with SMTP id 20so9232465bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 15:30:34 -0700 (PDT)
In-Reply-To: <1268686034.16974.39.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020302040200040109060709
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 03/15/2010 09:47 PM, Paul Menzel wrote:
> Am Montag, den 15.03.2010, 18:40 +0100 schrieb lieven moors:
>   =20
>> On 03/15/2010 03:32 PM, Paul Menzel wrote:
>>     =20
> [=E2=80=A6]
>
>   =20
>> Thanks for the explanation, here is a second try...
>> I'm not sure what caused the extra line breaks, but this should be pla=
in
>> text now.
>> Hope this works...
>>     =20
> Unfortunately I did not. Could you just attach the patch, please?
>
>
> Thanks,
>
> Paul
>   =20
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>   =20
Ok, done.

--------------020302040200040109060709
Content-Type: text/x-patch;
 name="0001-aconnect-x-Do-not-update-index-after-removal-of-conn.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-aconnect-x-Do-not-update-index-after-removal-of-conn.pa";
 filename*1="tch"

>From 996cf123d20dc5d7db2f98f29cebcfb7d3b013e0 Mon Sep 17 00:00:00 2001
From: lieven moors <lievenmoors@gmail.com>
Date: Mon, 15 Mar 2010 18:13:11 +0100
Subject: [Patch v2] aconnect -x: Do not update index after removal of connection.
 Signed-off-by: lieven moors <lievenmoors@gmail.com>

---
 seq/aconnect/aconnect.c |   43 ++++++++++++-------------------------------
 1 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/seq/aconnect/aconnect.c b/seq/aconnect/aconnect.c
index 1a50666..6092748 100644
--- a/seq/aconnect/aconnect.c
+++ b/seq/aconnect/aconnect.c
@@ -192,52 +192,33 @@ static void remove_connection(snd_seq_t *seq, snd_seq_client_info_t *cinfo,
 			      snd_seq_port_info_t *pinfo, int count)
 {
 	snd_seq_query_subscribe_t *query;
-
 	snd_seq_query_subscribe_alloca(&query);
 	snd_seq_query_subscribe_set_root(query, snd_seq_port_info_get_addr(pinfo));
-
 	snd_seq_query_subscribe_set_type(query, SND_SEQ_QUERY_SUBS_READ);
 	snd_seq_query_subscribe_set_index(query, 0);
-	for (; snd_seq_query_port_subscribers(seq, query) >= 0;
-	     snd_seq_query_subscribe_set_index(query, snd_seq_query_subscribe_get_index(query) + 1)) {
+
+	while (snd_seq_query_port_subscribers(seq, query) >= 0) 
+	{
 		snd_seq_port_info_t *port;
 		snd_seq_port_subscribe_t *subs;
 		const snd_seq_addr_t *sender = snd_seq_query_subscribe_get_root(query);
 		const snd_seq_addr_t *dest = snd_seq_query_subscribe_get_addr(query);
 		snd_seq_port_info_alloca(&port);
-		if (snd_seq_get_any_port_info(seq, dest->client, dest->port, port) < 0)
-			continue;
-		if (!(snd_seq_port_info_get_capability(port) & SND_SEQ_PORT_CAP_SUBS_WRITE))
-			continue;
-		if (snd_seq_port_info_get_capability(port) & SND_SEQ_PORT_CAP_NO_EXPORT)
-			continue;
-		snd_seq_port_subscribe_alloca(&subs);
-		snd_seq_port_subscribe_set_queue(subs, snd_seq_query_subscribe_get_queue(query));
-		snd_seq_port_subscribe_set_sender(subs, sender);
-		snd_seq_port_subscribe_set_dest(subs, dest);
-		snd_seq_unsubscribe_port(seq, subs);
-	}
 
-	snd_seq_query_subscribe_set_type(query, SND_SEQ_QUERY_SUBS_WRITE);
-	snd_seq_query_subscribe_set_index(query, 0);
-	for (; snd_seq_query_port_subscribers(seq, query) >= 0;
-	     snd_seq_query_subscribe_set_index(query, snd_seq_query_subscribe_get_index(query) + 1)) {
-		snd_seq_port_info_t *port;
-		snd_seq_port_subscribe_t *subs;
-		const snd_seq_addr_t *dest = snd_seq_query_subscribe_get_root(query);
-		const snd_seq_addr_t *sender = snd_seq_query_subscribe_get_addr(query);
-		snd_seq_port_info_alloca(&port);
-		if (snd_seq_get_any_port_info(seq, sender->client, sender->port, port) < 0)
-			continue;
-		if (!(snd_seq_port_info_get_capability(port) & SND_SEQ_PORT_CAP_SUBS_READ))
-			continue;
-		if (snd_seq_port_info_get_capability(port) & SND_SEQ_PORT_CAP_NO_EXPORT)
+		if ((snd_seq_get_any_port_info(seq, dest->client, dest->port, port) < 0) ||
+			!(snd_seq_port_info_get_capability(port) & SND_SEQ_PORT_CAP_SUBS_WRITE) ||
+			(snd_seq_port_info_get_capability(port) & SND_SEQ_PORT_CAP_NO_EXPORT))
+		{
+			snd_seq_query_subscribe_set_index(query, snd_seq_query_subscribe_get_index(query) + 1);
 			continue;
+		}
 		snd_seq_port_subscribe_alloca(&subs);
 		snd_seq_port_subscribe_set_queue(subs, snd_seq_query_subscribe_get_queue(query));
 		snd_seq_port_subscribe_set_sender(subs, sender);
 		snd_seq_port_subscribe_set_dest(subs, dest);
-		snd_seq_unsubscribe_port(seq, subs);
+		if(snd_seq_unsubscribe_port(seq, subs) < 0){
+			snd_seq_query_subscribe_set_index(query, snd_seq_query_subscribe_get_index(query) + 1);
+		}
 	}
 }
 
-- 
1.6.3.3


--------------020302040200040109060709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020302040200040109060709--
