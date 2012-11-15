From: Peter Grasch <me@bedahr.org>
Subject: snd_device_name_hint: Inconsistent output
Date: Thu, 15 Nov 2012 01:27:00 +0100
Message-ID: <1352939220.424.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ms94393.hosts.iptox.net (ms94393.hosts.iptox.net
 [95.128.200.174])
 by alsa0.perex.cz (Postfix) with ESMTP id BBEFE264F06
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 01:27:33 +0100 (CET)
Received: from [192.168.1.173] (chello213047047049.3.graz.surfer.at
 [213.47.47.49])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ms94393.hosts.iptox.net (Postfix) with ESMTPSA id 822F8253406C
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 01:35:59 +0100 (CET)
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

Hi!

Today, I noticed that some devices (specifically, the "pulse" device,
but there might be others as well) do not show up in a call to
snd_device_name_hint when it is called for the first time within an
application.

I've managed to reproduce the problem on three different systems:
Get the source of a current version of aplay, compile it, run aplay -L
and store the output.
Then add another call to snd_device_name_hint in pcm_list to make it
look like this (leaking memory, but it doesn't matter for this
demonstration):
 315 static void pcm_list(void)
 316 {
 317         void **hints, **n;
 318         char *name, *descr, *descr1, *io;
 319         const char *filter;
 320 
 321         snd_device_name_hint(-1, "pcm", &hints);
 322         if (snd_device_name_hint(-1, "pcm", &hints) < 0)
 323                 return;
Compile and run this version of aplay and again store the output of
"aplay -L".
For me, the two outputs differ.

Please net me know how I can help to resolve this issue. Thanks.

Best regards,
Peter
