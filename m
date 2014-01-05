From: Studio65 <studio65@gmx.de>
Subject: MOTU Micro Lite (5x5 MIDI USB Interface)
Date: Sun, 05 Jan 2014 05:01:06 +0100
Message-ID: <1388894466.18684.12.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CAF9A26167E
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 05:00:02 +0100 (CET)
Received: from [192.168.1.3] ([78.50.225.255]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LbdE3-1VXmBt0ebL-00lFrw for
 <alsa-devel@alsa-project.org>; Sun, 05 Jan 2014 05:00:02 +0100
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

Hello Alsa Team,

may I try to explain my/our problem as short as possible.

We have been truing to hack a kernel patch to get a MOTU Micro Lite (5x5
MIDI USB Interface) to run within a Debian "wheezy" with RT Kernel.

We did get the five channels appear in #qjackctl or #patchage.
we tried to receive input from #vkeybd
and get output to #gmidimonitor

while on the Hardware we connected:
MOTU Midi In 1 <--> Motu Midi Out 1
MOTU Midi In 2 <--> Motu Midi Out 2
MOTU Midi In 3 <--> Motu Midi Out 3
MOTU Midi In 4 <--> Motu Midi Out 4
MOTU Midi In 5 <--> Motu Midi Out 5

Here is some Logs:
Output of #tail -f /var/log/messages http://pastebin.com/R6xppq7k
Output of #lsusb -vv http://pastebin.com/Du0N6hCa

Cheers,
Nathanael


Studio65
