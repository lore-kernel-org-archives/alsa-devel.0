From: "R. Lemos" <rslemos@gmail.com>
Subject: On mixer controls naming
Date: Thu, 9 Jan 2014 13:27:18 -0200
Message-ID: <CAM6_cxyGVC+Tzt=6AM=LXn2Eqt48AK4JMSJkfbR07pPgPwBtcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f43.google.com (mail-qe0-f43.google.com
 [209.85.128.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C85A92652CD
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 16:27:21 +0100 (CET)
Received: by mail-qe0-f43.google.com with SMTP id jy17so3145029qeb.2
 for <alsa-devel@alsa-project.org>; Thu, 09 Jan 2014 07:27:18 -0800 (PST)
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

I'm trying to write a new driver for a virtual sound card. It isn't
actually a sound card, but only a software solution to control volume
and bass of an external device (using SPI and GPIO). So it only has a
mixer (no pcm or capture subdevices).

I could successfully configure two controls "Master Playback Switch"
and "Master Playback Volume". Alsamixer shows them correctly under
"Playback" view (and very nicely it joined them together to form a
single composite control "Master")

The other control I've named "Tone Control - Bass", as indicated in
writing-an-alsa-driver.pdf. But alsamixer shows it under both
"Playback" and "Capture" views.

How can I restrict this latter control to just playback?

-- 
[]'s
Rodrigo
