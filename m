From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Subject: No sound on Asrock Z68 Extreme4
Date: Thu, 23 May 2019 21:11:14 +0200
Message-ID: <f4c9b563-af22-c351-47ee-9a748a9f4cc9@juszkiewicz.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from malenstwo.juszkiewicz.com.pl (malenstwo.juszkiewicz.com.pl
 [37.187.99.30]) by alsa1.perex.cz (Postfix) with ESMTP id 65F20F8079B
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 21:11:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by malenstwo.juszkiewicz.com.pl (Postfix) with ESMTP id 608C8C057E
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 21:11:17 +0200 (CEST)
Received: from malenstwo.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (mail.juszkiewicz.com.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QihVe6T223sT for <alsa-devel@alsa-project.org>;
 Thu, 23 May 2019 21:11:15 +0200 (CEST)
Received: from puchatek.local (89-67-26-161.dynamic.chello.pl [89.67.26.161])
 by malenstwo.juszkiewicz.com.pl (Postfix) with ESMTPSA id CA739C034E
 for <alsa-devel@alsa-project.org>;
 Thu, 23 May 2019 21:11:14 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I recently moved my home machine to Asrock Z68 Extreme4 mainboard.
Booted into Fedora 30 and found out that my speakers are not making any
sound.

alsa-info.sh output:
http://alsa-project.org/db/?f=9c079d91b5f2278d3c3bd98518a6a717c86d31df

Pulseaudio says that are no speakers connected and 'hdajacksensetest'
says the same:

21:08 (0s) hrw@puchatek:~$ sudo hdajacksensetest
Pin 0x14 (Green Line Out, Rear side): present = No
Pin 0x15 (Black Line Out, Rear side): present = No
Pin 0x16 (Orange Line Out, Rear side): present = No
Pin 0x18 (Pink Mic, Rear side): present = No
Pin 0x1a (Blue Line In, Rear side): present = No

I noticed 'hdajackretask' tool but no idea how to use it properly.

Any ideas?
