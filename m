From: Andrew Kelley <superjoe30@gmail.com>
Subject: snd_pcm_hw_params_set_buffer_size_near yields EINVAL
	for the value 1681
Date: Tue, 13 Oct 2015 06:15:04 +0000
Message-ID: <CACXN+=QJL__aiKxsgNsygE08JYdRYyV-DwBisES+41td8Ak+Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id EDECC265497
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 08:15:15 +0200 (CEST)
Received: by pabve7 with SMTP id ve7so11303793pab.2
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 23:15:14 -0700 (PDT)
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

When I call snd_pcm_hw_params_set_buffer_size_near with the value 1681, I
get an EINVAL error.

These other values all work fine:

1
1679
1680
1682
1683
1684
99999

What in the world is going on here?
