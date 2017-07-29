From: Fulup Ar Foll <fulup.arfoll@iot.bzh>
Subject: snd_ctl_add_enumerated_elem_set and TLV
Date: Sat, 29 Jul 2017 16:12:27 +0200
Message-ID: <9eb2ccd3-9574-26fc-cb5b-6defcc59578f@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 283CF266A63
 for <alsa-devel@alsa-project.org>; Sat, 29 Jul 2017 16:12:30 +0200 (CEST)
Received: by mail-wm0-f54.google.com with SMTP id t201so16238184wmt.0
 for <alsa-devel@alsa-project.org>; Sat, 29 Jul 2017 07:12:30 -0700 (PDT)
Received: from [10.20.101.100] (sne56-1-88-180-128-218.fbx.proxad.net.
 [88.180.128.218])
 by smtp.googlemail.com with ESMTPSA id e17sm19523454wma.19.2017.07.29.07.12.28
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Jul 2017 07:12:28 -0700 (PDT)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm using snd_ctl_add_enumerated_elem_set to create user controls, I do 
not understand why it set "TLV readable" option at true by default. I 
have a simple enumeration without TLV. I use snd_ctl_elem_write but do 
not call snd_ctl_elem_tlv_write. I do no understand how to prevent 
snd_ctl_elem_info_is_tlv_readable to return true for this control, 
obviously even if TLV is set as readable, it is empty and reading fail.


Example

fulup@fulup-desktop:~/Workspace/AlsaPulse> amixer -D hw:USB cget numid=237
numid=237,iface=MIXER,name='Hal-VolRamp-Mode'
   ; type=ENUMERATED,access=rw---RW-,values=1,items=4
   ; Item #0 'None'
   ; Item #1 'Normal'
   ; Item #2 'Smooth'
   ; Item #3 'Emergency'
   : values=1
amixer: Control hw:USB element TLV read error: No such device or address

Question: is there something special to set when a control does not have 
a TLV ?

Fulup

PS: if I write a fake TLV everything goes fine, but this is not what I 
expect for ENUM.
