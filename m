From: "Zhang wei" <zhangwei@vimicro.com>
Subject: got a segmentation fault when use multi-channel device
Date: Sat, 6 Apr 2013 12:04:31 +0800
Message-ID: <6B947C8AC4195040A8C6876A496C644A0824995C@BJ-MAIL-04.vimicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.vimicro.com (unknown [211.155.250.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A427261740
 for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2013 06:04:37 +0200 (CEST)
Content-class: urn:content-classes:message
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

hello everone.

i am now debuging the multi-channel device on my embeded board with
alsa-lib.The version alsa-driver and alsa-lib is 1.0.24.

 

----------------------------->

zz@board:$ ls /dev/snd/

by-path  controlC0  midiC0D0  pcmC0D0c  pcmC0D0p  pcmC0D1p  seq  timer

<---------------------------

i edit the asoundrc configure file.like this:

 

--------------------------------------------------->

 

pcm.!default{

  type hw

  card 0

}

 

ctl.!default{

  type hw

  card 0

}

 

#################################

## create a virtul device which has 4 channels for playback.

#################################

pcm.multi_playback{

  type multi;

  slaves.a.pcm "hw:0,0";

  slaves.a.channels 2;

  slaves.b.pcm "hw:0,1";

  slaves.b.channels 2;

  bindings.0.slave a;

  bindings.0.channel 0;

  bindings.1.slave a;

  bindings.1.channel 1;

  bindings.2.slave b;

  bindings.2.channel 0;

  bindings.3.slave b;

  bindings.3.channel 1;

}

 

ctl.multi_playback{

  type hw; 

  card 0;

}

 

pcm.ttable{

  type route;

  slave.pcm "multi_playback";

  slave.channels 4;

  ttable.0.0 1;

  ttable.1.1 1;

  ttable.2.2 1;

  ttable.3.3 1;

}

ctl.ttable {

  type hw;

  card 0;

}

<--------------------------------------------------

and then get the Segmentation fault:

 

-------------------------------------------------------------->

 

[root@board /tmp]#./pb_pcm_min 

open...ver:[0.71]

playback...capture...device=[multi_playback]

 

#####################snd_pcm_open...

zz[snd_dlsym_verify:122],vname=[_snd_config_hook_load_dlsym_config_hook_
001]

zz[snd_dlsym_verify:127]

zz[snd_dlsym:167]

zz[snd_dlsym:171],name=[snd_config_hook_load]

zz[snd_pcm_open_conf:2163]

zz[snd_dlsym_verify:122],vname=[__snd_pcm_multi_open_dlsym_pcm_001]

Segmentation fault

[root@board /tmp]#

<---------------------------------------------------------------

 

To my surpris, it will be fine when run on the PC under the Ubuntu
system.I used the same alsa-lib source code and the configure file
asoundrc.

 

in my codec-driver .i have not call the functions
:snd_soc_add_controls() / snd_soc_dapm_new_controls() /
snd_soc_dapm_add_routes(). is it the reason? But the programm have not
arrived here.

 

i have traced the source code when the Segmentation fault happened the
alsa-lib was calling the function dlysm() with the param
vname=__snd_pcm_multi_open_dlsym_pcm_001. But this will not happen on my
PC under Ubuntu. could you help me find out what's wrong with me?

 

thanks a lot.

zw
