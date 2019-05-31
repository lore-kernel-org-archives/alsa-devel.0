From: Martin R <martin.rajwa@gmail.com>
Subject: Fwd: Problem with aplay params
Date: Fri, 31 May 2019 11:18:46 +0200
Message-ID: <CAEMX6L3USMp8d4OAot-8MdC_2nRidi6NHZXz90oLWF6G3XYbfg@mail.gmail.com>
References: <CAEMX6L2gUUTTtQ9OPfPZe0JkUk_ur+d9+Tk7yymcWZesmmsUjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05A52F8072E
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 11:18:59 +0200 (CEST)
Received: by mail-ot1-x32f.google.com with SMTP id n14so8515226otk.2
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 02:18:59 -0700 (PDT)
In-Reply-To: <CAEMX6L2gUUTTtQ9OPfPZe0JkUk_ur+d9+Tk7yymcWZesmmsUjA@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I have built aplay using github repository
https://github.com/alsa-project/alsa-utils/ as well as
https://github.com/thesofproject/alsa-lib. Now when I try to run it by
"./path_to_aplay/aplay -C -D hw:0,8 -r 16000 -f S16_LE -c 2 tmp.wav -vvv I
get immediate error message saying: arecord: pcm_read:2150 read error:
Input/output error.

Why is it failing? The system aplay/arecord works OK - only the one I built
fails with above error.

PS: system aplay version is 1.1.8 while the one built by me is 1.19

Regards,
Marcin
