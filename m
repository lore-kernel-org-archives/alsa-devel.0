From: lieven moors <lievenmoors@gmail.com>
Subject: Re: aconnect patch
Date: Mon, 15 Mar 2010 18:40:51 +0100
Message-ID: <4B9E7123.4000207@gmail.com>
References: <4B9E306F.8070705@gmail.com> <1268663545.9635.10.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id 81D1C103802
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 18:40:58 +0100 (CET)
Received: by ewy19 with SMTP id 19so1195900ewy.22
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 10:40:58 -0700 (PDT)
In-Reply-To: <1268663545.9635.10.camel@mattotaupa>
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

On 03/15/2010 03:32 PM, Paul Menzel wrote:
> Dear lieven,
>
>
> Am Montag, den 15.03.2010, 14:04 +0100 schrieb lieven moors:
>
> [=85]
>
>    =

>> Please let me know what you think about this patch, and if you think my =
reasoning is sane...
>>      =

> thank you for your work. Unfortunately your MUA mangled the output.
> Could you please resend without linebreaks.
>
> It looks like you used `git format-patch` already. Great! You can also
> use `git send-email` if you plan on submitting more patches [1].
>
> Anyway, could you also add a `Signed-off-by` line (`git commit -s` or
> `git format-patch -s`) and add a more descriptive summary as `aconnect
> -x: Do not update index after removal of connection.`. (This is just
> taken form your summary.)
>
> Please make sure when resending to not this by =BB[PATCH v2]=AB in front =
of
> your subject line, e. g. `git format-patch --subject-prefix=3D"Patch v2"`
> (see `git help format-patch`).
>
>
> Thanks again and sorry for the long response,
>
> Paul
>
>
> [1] http://git.wiki.kernel.org/index.php/GitTips#Using_gmail_to_send_your=
_patches
> [2] http://elinux.org/Git_usage#Sending_with_Gmail
>
>    =

>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>    =


Thanks for the explanation, here is a second try...
I'm not sure what caused the extra line breaks, but this should be plain =

text now.
Hope this works...


 From 996cf123d20dc5d7db2f98f29cebcfb7d3b013e0 Mon Sep 17 00:00:00 2001
From: lieven moors <lievenmoors@gmail.com>
Date: Mon, 15 Mar 2010 18:13:11 +0100
Subject: [Patch v2] aconnect -x: Do not update index after removal of =

connection.
Signed-off-by: lieven moors <lievenmoors@gmail.com>

---
seq/aconnect/aconnect.c | 43 ++++++++++++-------------------------------
1 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/seq/aconnect/aconnect.c b/seq/aconnect/aconnect.c
index 1a50666..6092748 100644
--- a/seq/aconnect/aconnect.c
+++ b/seq/aconnect/aconnect.c
@@ -192,52 +192,33 @@ static void remove_connection(snd_seq_t *seq, =

snd_seq_client_info_t *cinfo,
snd_seq_port_info_t *pinfo, int count)
{
snd_seq_query_subscribe_t *query;
-
snd_seq_query_subscribe_alloca(&query);
snd_seq_query_subscribe_set_root(query, snd_seq_port_info_get_addr(pinfo));
-
snd_seq_query_subscribe_set_type(query, SND_SEQ_QUERY_SUBS_READ);
snd_seq_query_subscribe_set_index(query, 0);
- for (; snd_seq_query_port_subscribers(seq, query) >=3D 0;
- snd_seq_query_subscribe_set_index(query, =

snd_seq_query_subscribe_get_index(query) + 1)) {
+
+ while (snd_seq_query_port_subscribers(seq, query) >=3D 0)
+ {
snd_seq_port_info_t *port;
snd_seq_port_subscribe_t *subs;
const snd_seq_addr_t *sender =3D snd_seq_query_subscribe_get_root(query);
const snd_seq_addr_t *dest =3D snd_seq_query_subscribe_get_addr(query);
snd_seq_port_info_alloca(&port);
- if (snd_seq_get_any_port_info(seq, dest->client, dest->port, port) < 0)
- continue;
- if (!(snd_seq_port_info_get_capability(port) & =

SND_SEQ_PORT_CAP_SUBS_WRITE))
- continue;
- if (snd_seq_port_info_get_capability(port) & SND_SEQ_PORT_CAP_NO_EXPORT)
- continue;
- snd_seq_port_subscribe_alloca(&subs);
- snd_seq_port_subscribe_set_queue(subs, =

snd_seq_query_subscribe_get_queue(query));
- snd_seq_port_subscribe_set_sender(subs, sender);
- snd_seq_port_subscribe_set_dest(subs, dest);
- snd_seq_unsubscribe_port(seq, subs);
- }

- snd_seq_query_subscribe_set_type(query, SND_SEQ_QUERY_SUBS_WRITE);
- snd_seq_query_subscribe_set_index(query, 0);
- for (; snd_seq_query_port_subscribers(seq, query) >=3D 0;
- snd_seq_query_subscribe_set_index(query, =

snd_seq_query_subscribe_get_index(query) + 1)) {
- snd_seq_port_info_t *port;
- snd_seq_port_subscribe_t *subs;
- const snd_seq_addr_t *dest =3D snd_seq_query_subscribe_get_root(query);
- const snd_seq_addr_t *sender =3D snd_seq_query_subscribe_get_addr(query);
- snd_seq_port_info_alloca(&port);
- if (snd_seq_get_any_port_info(seq, sender->client, sender->port, port) =

< 0)
- continue;
- if (!(snd_seq_port_info_get_capability(port) & =

SND_SEQ_PORT_CAP_SUBS_READ))
- continue;
- if (snd_seq_port_info_get_capability(port) & SND_SEQ_PORT_CAP_NO_EXPORT)
+ if ((snd_seq_get_any_port_info(seq, dest->client, dest->port, port) < =

0) ||
+ !(snd_seq_port_info_get_capability(port) & SND_SEQ_PORT_CAP_SUBS_WRITE) ||
+ (snd_seq_port_info_get_capability(port) & SND_SEQ_PORT_CAP_NO_EXPORT))
+ {
+ snd_seq_query_subscribe_set_index(query, =

snd_seq_query_subscribe_get_index(query) + 1);
continue;
+ }
snd_seq_port_subscribe_alloca(&subs);
snd_seq_port_subscribe_set_queue(subs, =

snd_seq_query_subscribe_get_queue(query));
snd_seq_port_subscribe_set_sender(subs, sender);
snd_seq_port_subscribe_set_dest(subs, dest);
- snd_seq_unsubscribe_port(seq, subs);
+ if(snd_seq_unsubscribe_port(seq, subs) < 0){
+ snd_seq_query_subscribe_set_index(query, =

snd_seq_query_subscribe_get_index(query) + 1);
+ }
}
}

-- =

1.6.3.3
