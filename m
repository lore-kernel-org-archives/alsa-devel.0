From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Takashi: please help (compiling alsa-driver)
Date: Thu, 14 Feb 2013 11:20:11 +0800
Message-ID: <CAN8cciYWEogmECrRZ_UEeAg97Qt=uVm9Ww1PaUo39GoEDehZ7g@mail.gmail.com>
References: <511ABB0D.90808@gmail.com>
 <CAN8cciZZb-JRP=ssavKH+L4aeSAmZ7_8aQCO+GMWF-uTyYRqFQ@mail.gmail.com>
 <s5hliasvh5t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f169.google.com (mail-ia0-f169.google.com
 [209.85.210.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 09B0E2650EA
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 04:20:12 +0100 (CET)
Received: by mail-ia0-f169.google.com with SMTP id j5so1915769iaf.28
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2013 19:20:11 -0800 (PST)
In-Reply-To: <s5hliasvh5t.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
>> Do the latest version of alsa-lib require any specific parameter to install
>> on Ubuntu 12.04 for testing the channel map ?
>>
>> alsa-lib/test/chmap -D hw:0 query
>>
>> ALSA lib conf.c:3314:(snd_config_hooks_call) Cannot open shared library
>> libasound_module_conf_pulse.so
>> ALSA lib pcm.c:2223:(snd_pcm_open_noupdate) Unknown PCM hw:0
>> Cannot open PCM stream hw:0 for PLAYBACK
>
> Seem you didn't install the conf_pulse module properly, no?
>

alsa-lib/test/chmap can be built but fail to compile aplay


make[1]: Entering directory `/home/raymond/alsa-utils/aplay'
gcc  -O2 -Wall -pipe -g   -o aplay aplay.o  -lrt -lasound -lm -ldl -lpthread
aplay.o: In function `setup_chmap':
/home/raymond/alsa-utils/aplay/aplay.c:1148: undefined reference to
`snd_pcm_set_chmap'
/home/raymond/alsa-utils/aplay/aplay.c:1152: undefined reference to
`snd_pcm_get_chmap'
/home/raymond/alsa-utils/aplay/aplay.c:1188: undefined reference to
`snd_pcm_chmap_print'
aplay.o: In function `main':
/home/raymond/alsa-utils/aplay/aplay.c:707: undefined reference to
`snd_pcm_chmap_parse_string'
collect2: ld returned 1 exit status
make[1]: *** [aplay] Error 1
make[1]: Leaving directory `/home/raymond/alsa-utils/aplay'
make: *** [all-recursive] Error 1
