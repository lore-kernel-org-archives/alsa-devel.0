From: Babu Balu <babu.ba@hcl.com>
Subject: alsa platform driver testing without codec driver
Date: Sat, 24 May 2014 06:12:52 +0000
Message-ID: <9BE36916FEC1904EA5C37D4348D37DEC69D016@chn-hclt-mbs06.HCLT.CORP.HCL.IN>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from GWS07.hcl.com (gws07.hcl.com [192.8.186.130])
 by alsa0.perex.cz (Postfix) with ESMTP id E3B3F26514A
 for <alsa-devel@alsa-project.org>; Sat, 24 May 2014 08:13:25 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

   Hi,
   Need an input from you guys please.
   Is there a possibility to play out an audio using aplay or any alsa
   tools without the presence of the codec driver
   In our target platform, we have the SoC's I2S platform driver working,
   and a dummy codec driver is registered
   The actual codec chip sits on a external board and connected to the
   main SoC via I2S and I2C lines. And that codec chip is configured via a
   middleware package(not alsa)
   So we do not have a codec driver at the kernel space, we have just
   provided a plain I2C interface driver for the middleware package. so
   that it can send I2C commands directly to the audio codec chip. Based
   on the requirement have to give the control interface of the codec chip
   to the middleware package
   In this case is there a possibility to play out an audio file using
   alsa tools(eg. aplay)
   Just a raw PCM format should be enough.
   Thanks,
   Babu

   ::DISCLAIMER::
   -----------------------------------------------------------------------
   -----------------------------------------------------------------------
   ------

   The contents of this e-mail and any attachment(s) are confidential and
   intended for the named recipient(s) only.
   E-mail transmission is not guaranteed to be secure or error-free as
   information could be intercepted, corrupted,
   lost, destroyed, arrive late or incomplete, or may contain viruses in
   transmission. The e mail and its contents
   (with or without referred errors) shall therefore not attach any
   liability on the originator or HCL or its affiliates.
   Views or opinions, if any, presented in this email are solely those of
   the author and may not necessarily reflect the
   views or opinions of HCL or its affiliates. Any form of reproduction,
   dissemination, copying, disclosure, modification,
   distribution and / or publication of this message without the prior
   written consent of authorized representative of
   HCL is strictly prohibited. If you have received this email in error
   please delete it and notify the sender immediately.
   Before opening any email and/or attachments, please check them for
   viruses and other defects.

   -----------------------------------------------------------------------
   -----------------------------------------------------------------------
   ------
