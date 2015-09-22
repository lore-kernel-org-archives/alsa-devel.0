From: Mike Bjorge <mbjorge@google.com>
Subject: unable to create IPC shm instance; SND_PCM_DIRECT_MAGIC
Date: Mon, 21 Sep 2015 18:14:31 -0700
Message-ID: <CADHGi47yhgRJdF0FPv8epGPobe_u4Xkaan7mQi1Zv_Y4FBBH6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id EAB5D2604C5
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 03:15:01 +0200 (CEST)
Received: by wicfx3 with SMTP id fx3so170391031wic.1
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 18:15:01 -0700 (PDT)
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

I was wondering if anyone could explain the point of SND_PCM_DIRECT_MAGIC
and dmix->shmptr->magic?

Specifically, what it's doing in pcm_direct.c from this commit?
http://git.alsa-project.org/?p=alsa-lib.git;a=blobdiff;f=src/pcm/pcm_direct.c;h=4e2f36cd275bfda1bc3453e569cf7fb44c317ef3;hp=46664a13d0a3368527b103ff13a08f3bcfe1ddbb;hb=eafb7ae5d8fa5ee52757ee0ee9137442d2c39326;hpb=194ff97ea68d66dac8e38671cbf73d52b42f3363

I am trying to use pcm_dmix.c, but this is occasionally failing

first_instance = ret = snd_pcm_direct_shm_create_or_connect(dmix);
if (ret < 0) {
SNDERR("unable to create IPC shm instance");
goto _err;
}

because dmix->shmptr->magic is not correctly set to SND_PCM_DIRECT_MAGIC.

Thanks for any information!

-Mike
