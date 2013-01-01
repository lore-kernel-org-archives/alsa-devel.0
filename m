From: Eben Upton <eben@raspberrypi.org>
Subject: Looking for ALSA developer
Date: Tue, 1 Jan 2013 15:38:35 +0000
Message-ID: <CAJKV0dt1Bevf0Xb8qmBWt1=DSjzaYg2ZOpQzgxYk+22aJ57cpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com
 [93.93.130.6]) by alsa0.perex.cz (Postfix) with ESMTP id 1030C262602
 for <alsa-devel@alsa-project.org>; Tue,  1 Jan 2013 16:38:38 +0100 (CET)
Received: from [209.85.216.51] (helo=mail-qa0-f51.google.com)
 by balrog.mythic-beasts.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
 (Exim 4.72) (envelope-from <eben@raspberrypi.org>)
 id 1Tq3vJ-0004NT-4l
 for alsa-devel@alsa-project.org; Tue, 01 Jan 2013 15:38:37 +0000
Received: by mail-qa0-f51.google.com with SMTP id i20so8362003qad.3
 for <alsa-devel@alsa-project.org>; Tue, 01 Jan 2013 07:38:36 -0800 (PST)
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

We're looking for someone to do some contract development on the ALSA
driver for the Raspberry Pi. Would anyone here be interested in taking
this on? A little background:

Our driver is architecturally fairly similar to a USB sound card
driver, sitting on top of a stream-like connection to a remote entity
implemented in software on an internal DSP. Due to our limited
understanding of ALSA internals, there are a number of bugs which lead
to underrun conditions in common audio applications, and we'd like to
pay someone on and hourly basis to go through the failing cases, root
cause them, and propose patches.

Eben Upton
Executive Director, Raspberry Pi Foundation
