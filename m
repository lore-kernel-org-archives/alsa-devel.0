From: Allan Klinbail <aklinbail@gmail.com>
Subject: A&H Zed R16 not completely working (DICE Jr)
Date: Wed, 20 Apr 2016 14:31:43 +0000
Message-ID: <CA+aoAJc6JQvy_yk-5HJZpqv5GW6DygdmLB5=HGyW9q3yn12mKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F129266558
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 16:31:54 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id e201so52995353wme.0
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 07:31:54 -0700 (PDT)
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

Hi,

I thought I would try the DICE chipset driver from ALSA, as it appears that
this will eventually take over from ffado..

It appears that it doesn't work very well for my Allen & Heath Zed -R16
which works very well under FFADO

Using kernel 4.4.0 from Ubuntu

The ALSA driver limited the device to only 16 inputs and outputs, however
it has a total capability of 26
This is comprises of 16 inputs and outputs on the desk channels, a stereo
main pair of outputs and inputs for the master bus
8 additional ins and outs to support the ADAT ports on the back (availoable
in 44.1 and 48 khz modes, but not 88.2 or 96 Khz

Similiarly I was not able to set the device to run at a latency lower than
256 frames in jack, however in FFADO I could go as low as 64 frames.

Please let me know if I can help with any further testing to get this to
the same level as the FFADO driver.

Regards

Allan
