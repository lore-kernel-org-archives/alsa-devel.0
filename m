From: =?UTF-8?Q?Charles_Fl=C3=A8che?= <charles.fleche@free.fr>
Subject: snd_seq_query_port_subscribers not updating subs index
Date: Sun, 8 Apr 2018 18:37:58 +0200
Message-ID: <CAMnW3Lt-R_ECPvazFbJjm-cS0w-gey0t5Tvts+Cz5n5LVPO+RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 42356267235
 for <alsa-devel@alsa-project.org>; Sun,  8 Apr 2018 18:38:00 +0200 (CEST)
Received: from mail-io0-f172.google.com (unknown [209.85.223.172])
 (Authenticated sender: charles.fleche)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 5F8EB5FFB9
 for <alsa-devel@alsa-project.org>; Sun,  8 Apr 2018 18:37:59 +0200 (CEST)
Received: by mail-io0-f172.google.com with SMTP id y128so6917571iod.4
 for <alsa-devel@alsa-project.org>; Sun, 08 Apr 2018 09:37:59 -0700 (PDT)
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

Hi all,

I'm iterating through subscribers with snd_seq_query_port_subscribers to
disconnect them. It works most of the time, but when a2j (an alsa -> jack
MIDI bridge) runs, snd_seq_query_port_subscribers does not update the subs
index, and the next call returns 0, leading to an infinite loop. I have to
manually increase the index when the disconnection fails (meaning that I
hit an a2j connection).

while (snd_seq_query_port_subscribers(seq, subs) >= 0) {
  addr = *snd_seq_query_subscribe_get_addr(subs);
  if (snd_seq_disconnect_to(seq, port, addr.client, addr.port) < 0) {
    snd_seq_query_subscribe_set_index(subs,
snd_seq_query_subscribe_get_index(subs) + 1);
  }
}

1. Is the non-updated subs index an expected behavior ?

2. Is my fix a correct one or could it leads to other issues ?

Many thanks,
