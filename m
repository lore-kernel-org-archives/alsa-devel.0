From: Evan <sirevan@gmail.com>
Subject: Fwd: regression: from 3.8 to 3.9: headphones output no
 sound on Intel HDA, codec VIA VT1802
Date: Fri, 31 May 2013 13:07:29 +0200
Message-ID: <51A88471.3010302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com
 [209.85.217.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 23DE12619E3
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 13:07:31 +0200 (CEST)
Received: by mail-lb0-f174.google.com with SMTP id u10so1530452lbi.5
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 04:07:30 -0700 (PDT)
Received: from [37.191.193.210] (host-37-191-193-210.lynet.no.
 [37.191.193.210])
 by mx.google.com with ESMTPSA id n7sm18591231lbd.12.2013.05.31.04.07.29
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 31 May 2013 04:07:30 -0700 (PDT)
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

I am having this same issue (with the same hardware). I found a
temporary work around for the problem by disabling "Auto-Mute Mode" with
alsamixer and then muting my "Speaker" output. If I don't mute the
"Speaker" I get audio through both my headphones and my speakers, but
when I mute the speakers I get the audio just through the headphones.

The output of alsa-info for 3.9.4 is here[1].

[1]
http://www.alsa-project.org/db/?f=6120303f74b8e46930e15a544ba11b859de25c04

-E
