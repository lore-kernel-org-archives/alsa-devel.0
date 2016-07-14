From: Chemsi Mehdi <chmsmehdi@gmail.com>
Subject: Alsa Soc details
Date: Thu, 14 Jul 2016 15:07:20 +0200
Message-ID: <CAHkWnPb+3P6P6qFOVcy=hh6z-v8Ry4FLZnP8qYrZkik10Et3aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B2799266880
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 15:07:22 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id c52so2781474qte.1
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 06:07:22 -0700 (PDT)
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

Dear expert,



I have some ALSA questions please:



   -

   Why codec driver of ASOC are always I2C based ?, is codec driver role is
   only control of audio hardware(set/reset registers only)?
   -

   There should be three drivers : machine driver, platform driver and
   codec driver , all of them have .probe and . remove , what is relation
   between all the probes? removes ?
   -

   As far I know McBSP is source of audio coming from host and I2C/ McBSP
   have no direct relation so why we connect platform driver (McBSP) with
   codec driver(I2C) Via DAI ?
   -

   When calling snd_pcm_open from userspace which kernel API is called ?
   snd_pcm_lib_ioctl or  snd_stm_spdif_player_open ? if
   snd_stm_spdif_player_open so when called snd_pcm_lib_ioctl ?
   -

   How ALSA KERNELAPI is connected to ALSA SOC CORE, via which
   calls/mechanism ?





Thanks q lot for your great help



LINI
