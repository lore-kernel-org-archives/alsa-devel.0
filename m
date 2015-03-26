From: Jan Hinnerk Stosch <janhinnerk.stosch@gmail.com>
Subject: Low volume since linux 3.19
Date: Thu, 26 Mar 2015 13:53:30 +0100
Message-ID: <CAO_aot5hLoXp1XkJ3SOSSBAYUbZWB63+VD2pGvVL=2gq6dJZUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AAAA26571D
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 13:53:31 +0100 (CET)
Received: by pdbop1 with SMTP id op1so61923994pdb.2
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 05:53:30 -0700 (PDT)
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

I hope this is the right place to report my issue!?
Since linux 3.19 I have very low volume on my Fujitsu E753 headphone
even on highest volume level.
As I don't have much experience with audio configuration and it worked
before I did a kernel bisect and found out, that commit
"03ad6a8c93b6df2d65c305b5b5f9474068b45bfb" is "responsible" for this.
Is there something that I have to change in my configuration? Or do
you need some further information?
Here is some output from dmesg:
[    5.853009] sound hdaudioC0D0: ALC269VB: SKU not ready 0x909701f0
[    5.853857] sound hdaudioC0D0: autoconfig: line_outs=1
(0x21/0x0/0x0/0x0/0x0) type:line
[    5.853860] sound hdaudioC0D0:    speaker_outs=1 (0x14/0x0/0x0/0x0/0x0)
[    5.853862] sound hdaudioC0D0:    hp_outs=1 (0x1a/0x0/0x0/0x0/0x0)
[    5.853864] sound hdaudioC0D0:    mono: mono_out=0x0
[    5.853866] sound hdaudioC0D0:    inputs:
[    5.853869] sound hdaudioC0D0:      Mic=0x18
[    5.853871] sound hdaudioC0D0:      Dock Mic=0x1b
[    5.853873] sound hdaudioC0D0:      Internal Mic=0x12

Thanks in advance,

jhs
