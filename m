From: "Simon Wolk" <mistervertigo@web.de>
Subject: Sound not working after new kernel installed
Date: Wed, 14 Oct 2015 14:22:59 +0200
Message-ID: <trinity-85f74570-9abc-486a-82c3-4f14c20d1ad0-1444825379497@3capp-webde-bs37>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id BEE8D26519F
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2015 14:22:59 +0200 (CEST)
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

   Hello everybody,


   I don't know if my question is right here, but either way I am asking:


   I am using an old Benq notebook (Joybook S73) mit Xubuntu 15.04. When I
   installed a new kernel (then 3.19.0-16, but now I am using 3.19.0.28)
   the sound on the speakers stoped working and there were no more audible
   sounds. With headphones plugged in and a the highest possible volume I
   could hear very silent the music played on the PC.

   Up to Kernel 3.2.0-70 the sound worked fine.

   System update and upgrade unfortunately did not help. Do you have any
   idea what may be the problem?


   I did the following to show the chip used:

   simon@simon-Joybook-S73:~$ lspci -nnk | grep -i audio -A2

   00:1b.0 Audio device [0403]: Intel Corporation NM10/ICH7 Family High
   Definition Audio Controller [8086:27d8] (rev 02)

   Subsystem: Benq Corporation Device [17ff:0600]

   Kernel driver in use: snd_hda_intel


   simon@simon-Joybook-S73:~$ cat /proc/asound/cards

   0 [Intel ]: HDA-Intel - HDA Intel

   HDA Intel at 0x6c400000 irq 29


   Thank you for your help!

   Simon
