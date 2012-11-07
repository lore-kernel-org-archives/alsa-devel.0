From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Wed, 7 Nov 2012 08:50:14 +0800
Message-ID: <CAN8cciZBoKws7TopuVs8rh_=ompMhJGzbJ59AUp2otoBODYJ6g@mail.gmail.com>
References: <k6rkr2$usv$1@ger.gmane.org>
 <CAN8cciZEwLxxiMp69k8yyAzSnqRNQ6m2=7q373x91D_pMy=h-w@mail.gmail.com>
 <k6tlk1$2vr$1@ger.gmane.org>
 <CAN8cciZQw8m-m-Bk6KF2UuqpU2a5=Y7vAi7daWmqF9vbA2w=4g@mail.gmail.com>
 <k70n1l$65a$1@ger.gmane.org>
 <CAN8cciZWX2tdAUcNeBHpa7eFHYeMnsTN_ngRcj7gRuj46RXnpg@mail.gmail.com>
 <k75cle$1i1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 028A4262632
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 01:50:15 +0100 (CET)
Received: by mail-qa0-f51.google.com with SMTP id t11so860298qaa.17
 for <alsa-devel@alsa-project.org>; Tue, 06 Nov 2012 16:50:15 -0800 (PST)
In-Reply-To: <k75cle$1i1$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Massimo Del Fedele <max@veneto.com>, tiwai@suse.de, lydiawang@viatech.com.cn
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> https://launchpadlibrarian.net/121871263/alsainfo.txt
>
>>
>>
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=94c142a160d63edac0e1fca7848960dcf75dd2a9;hp=012e7eb1e501d0120e0383b81477f63091f5e365
>>
>> do notebook with vt1802 really need independent headphone ?
>
>
> IMHO, but that's just my opinion, an independent HP is quite useless for
notebooks.

/* Mono Out */
         present = snd_hda_jack_detect(codec, 0x26);

         parm = present ? AC_PWRST_D3 : AC_PWRST_D0;
         if (spec->codec_type == VT1802) {
                 /* PW15 (33h), MW8(1ch), MUX8(3ch) */
                 update_power_state(codec, 0x33, parm);
                 update_power_state(codec, 0x1c, parm);
                 update_power_state(codec, 0x3c, parm);

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=11890956e948e6ed1b3e4acc11b6879db6ace01b;hp=bc92df7fe55e49c616a003b0b77e7badf2736429

if you look carefully, you should notice that 0x26 is not any detectable
pin complex in vt1802

Node 0x26 [Vendor Defined Widget] wcaps 0xf00000: Mono
