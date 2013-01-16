From: Rene Herman <rene.herman@gmail.com>
Subject: No dmix/dsnoop on Intel ICH4/5 by default?
Date: Wed, 16 Jan 2013 20:26:56 +0100
Message-ID: <50F6FF00.7020706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.gn.mail.iss.as9143.net (smtpq1.gn.mail.iss.as9143.net
 [212.54.34.164])
 by alsa0.perex.cz (Postfix) with ESMTP id 05C73264F8B
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 20:26:59 +0100 (CET)
Received: from [212.54.34.133] (helo=smtp2.gn.mail.iss.as9143.net)
 by smtpq1.gn.mail.iss.as9143.net with esmtp (Exim 4.71)
 (envelope-from <rene.herman@gmail.com>) id 1TvYdV-0006pP-Qn
 for alsa-devel@alsa-project.org; Wed, 16 Jan 2013 20:26:57 +0100
Received: from 5249be58.cm-4-2c.dynamic.ziggo.nl ([82.73.190.88]
 helo=[192.168.178.20])
 by smtp2.gn.mail.iss.as9143.net with esmtp (Exim 4.71)
 (envelope-from <rene.herman@gmail.com>) id 1TvYdV-0001mf-IK
 for alsa-devel@alsa-project.org; Wed, 16 Jan 2013 20:26:57 +0100
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

Good day.

I'm out of touch of with alsa -- but should dmix/dsnoop still be enabled 
by default on hardware that doesn't do hardware mixing?

It seems it isn't on my Intel ICH4:

$ cat /proc/asound/cards
  0 [ICH5           ]: ICH4 - Intel ICH5
                       Intel ICH5 with AD1980 at irq 17
  1 [SAA7134        ]: SAA7134 - SAA7134
                       saa7134[0] at 0xe8200000 irq 22

I believe that it should be from /usr/share/alsa/cards/ICH4.conf, but I 
don't get mixing on this setup when using the "default" pcm...

(which I may not mind at that much, but I was looking at some other 
sound-related problem and this has me rather confused)

This is arch linux, with alsa-lib, -plugins and -utils 1.0.26 installed, 
using kernel 3.6.11-1-ARCH (ie, standard).

Regards,
Rene
