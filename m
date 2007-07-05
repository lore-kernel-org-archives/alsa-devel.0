From: GT Bradley <baykelper@gmail.com>
Subject: Re: PS3 - Surround sound on SPDIF set-up
Date: Wed, 04 Jul 2007 18:23:09 -0700
Message-ID: <468C47FD.7070003@gmail.com>
References: <4689B1BF.2050709@gmail.com>	<s5hps39a4hv.wl%tiwai@suse.de>	<468A9A7A.7020802@gmail.com>
	<s5hfy44a8rn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 194112450F
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2007 03:19:20 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so1527843nzf
	for <alsa-devel@alsa-project.org>; Wed, 04 Jul 2007 18:19:19 -0700 (PDT)
In-Reply-To: <s5hfy44a8rn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

right,
  For my Fedora install, these files are at /etc/alsa/cards,   (although 
the iec958.conf) is in /etc/alsa/pcm).

The iec958.conf seems resonable, although I don't fully understand the 
syntax of the file, nor understand how the asoundrc file wires to 
/etc/alsa/...  to the actual linux driver.   It seems to pass through to 
the default device (which is what I want)

using the system-config-soundcard utility, I do get surround sound, and 
is displays the card as PS3 whcih matches the output of aplay -l    I've 
tryed createing a /etc/alsa/cards/PS3.conf file as follows:

I've added the following to my /etc/asound.conf:

pcm.myspdif {
    type iec958
    slave {
        pcm {
            type hw
            card 0
            device 0
            # whatever you like
        }
        format IEC958_SUBFRAME_BE
    }
    # the below should be corrected with 44.1kHz rates
    status [ 0x04 0x92 0x10 0x02 ]
}

I've created a PS3.conf file as follows:




[root@ps3 Surround-SDL-testfiles]# ac3dec -Dmyspdif -C dolby-canyon.ogg
Using PCM device 'myspdif'
Broken configuration for this PCM: no configurations availableOutput 
open failed

trying to create a SPDIF device has yeilded
[root@ps3 Surround-SDL-testfiles]# ac3dec -Dmyspdif -C dolby-canyon.ogg
Using PCM device 'myspdif'
snd_pcm_open: No such file or directory
Output open failed

(by an y of the following:)
pcm_slave.SPDIF {
       pcm iec958
}

pcm_slave.SPDIF {
       type hw
      card 0
       device 0
}

pcm_type.SPDIF {
        redirect  {
                name iec958
        }
}


the sytem-config-soundcard util is still able to play the test tones via 
AT3 over spdif.
the default device is as shown below...


GT




Takashi Iwai wrote:

>At Tue, 03 Jul 2007 11:50:34 -0700,
>GT Bradley wrote:
>  
>
>>yes,
>>  I am aware that AC3 is required,  I'm trying to get the AC3 
>>pass-through configured. From your response, I understand now that 
>>speaker-test is performing as expected, however I have tired other 
>>things also:
>> I have some AC3 encoded test files,  and I have also tried installing 
>>ffmpeg, and liba52.  and the ac3dec utility which I understand should 
>>pass through the AC3/DTS encoded files, but I recieve:
>>
>>[root@ps3 Surround-SDL-testfiles]# ac3dec -C dolby-canyon.ogg
>>Using PCM device 'plug:iec958:{AES0 0x2 AES1 0x82 AES2 0x0 AES3 0x2}'
>>ALSA lib conf.c:3939:(snd_config_expand) Unknown parameters {AES0 0x2 
>>AES1 0x82 AES2 0x0 AES3 0x2}
>>ALSA lib pcm.c:2145:(snd_pcm_open_noupdate) Unknown PCM iec958:{AES0 0x2 
>>AES1 0x82 AES2 0x0 AES3 0x2}
>>snd_pcm_open: Invalid argument
>>Output open failed
>>
>>However if I am planning to write ac3 to the linux driver, are you 
>>saying that I would be better to write directly to the driver rather 
>>than through the ALSA layer?
>>    
>>
>
>You need set up the configuration for alsa-lib.
>Otherwise the iec958 PCM isn't defined.
>Usually the card-specific configuration is stored in
>/usr/share/alsa/cards/*.conf.
>
>
>Takashi
>
>  
>
