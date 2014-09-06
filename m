From: "Pierre C" <lists@peufeu.com>
Subject: USB Implicit Feedback
Date: Sat, 06 Sep 2014 08:53:23 +0200
Message-ID: <op.xlq6q9vfeorkce@apollo13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo68.mail-out.ovh.net (9.mo68.mail-out.ovh.net [46.105.78.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0383B264F40
 for <alsa-devel@alsa-project.org>; Sat,  6 Sep 2014 08:53:26 +0200 (CEST)
Received: from mail138.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo68.mail-out.ovh.net (Postfix) with SMTP id 981DBFF9528
 for <alsa-devel@alsa-project.org>; Sat,  6 Sep 2014 08:53:25 +0200 (CEST)
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

Hello !

I'm implementing a USB Audio Class 2 device using a Cortex-M4 with high  
speed USB. So far it works well, the device is recognized by ALSA,  
playback, capture, sample rate change, and all controls like volume and  
mute work. I'm using explicit feedback.

I'd like to use implicit feedback instead, and had some problems...

With implicit feedback, when playback starts, ALSA should start capture  
automatically (even if there are no applications requesting capture at the  
moment) to use the number of capture samples as feedback. But it doesn't.

So, I'd like to know :

- Is it actually supported ?
- If it is, what descriptors should I use to make it work ?

Thanks for any info, have a nice day !

Pierre
