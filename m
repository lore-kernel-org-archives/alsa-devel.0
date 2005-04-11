From: "Guillaume GOURAT" <guillaume.nexvision@free.fr>
Subject: Alsa lib mmap error
Date: Mon, 11 Apr 2005 16:39:31 +0200
Message-ID: <200504111646453.SM02000@STATIONXP>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Ben Dooks <ben-linux-arm@fluff.org>, vadim@mbdsys.com
List-Id: alsa-devel@alsa-project.org

Hi,

I have an error when some application want to use alsalib to play or record
song (Error reported from alsa lib when it want create a memory mapping with
the kernel drivers).
The message : ALSA lib pcm_mmap.c:363:(snd_pcm_mmap) mmap failed: Invalid
argument

amixer, aplay and arecord work perfectly.

My platform is Samsung ARM s3c2410 CPU with linux 2.6.11.4 and a texas
instrument codec tlv320aic23b connected by I2S bus. We use alsa version
1.0.9rc2 (i have integrated s3c2410 I2S and tlv320aic23b support drivers
from M. Ben Dooks with a few modification).

Madplay work only when it use OSS emulation, and doesn't work when it's
compiled to use alsa (./configure --with-alsa ...)  :

    [root@(none) arm]$madplay -b 16 -R 48000 /mnt/wav/Afro10.mp3 MPEG Audio
Decoder 0.15.2 (beta) - Copyright (C) 2000-2004 Robert Leslie et al.
    ALSA lib pcm_mmap.c:363:(snd_pcm_mmap) mmap failed: Invalid argument
Unable to set hw params for playback: Invalid argument
    output: Invalid argument 


The same problem appear when we try to use another application.

for example linphone :

    [root@(none) /root]$linphonec
    Message:Found /dev/dsp.
    Message:Found ALSA device: tlv
    Message:Choosing alsa device tlv (Advanced Linux Sound Architecture) by
default.
>   ALSA lib pcm_mmap.c:363:(snd_pcm_mmap) mmap failed: Invalid argument
>   Warning:alsa_set_params: Error setting HW params:Invalid argument
    Warning:General level is quite low (0). Linphone rises it up for you.
    DEBUG: [get_output_if] connect: Network is unreachable
    Message:Adding new codec PCMU/8000
    Message:Adding new codec GSM/8000
    Message:Adding new codec PCMA/8000
    Message:Adding new codec speex/8000
    Message:Adding new codec speex/16000
    Message:Adding new codec 1015/8000
    Ready.
    linphonec> 
    Message:CALL_NEW
    Warning:Local loopback network only !
    Message:Refusing codec 97 (iLBC/8000)
    Message:Refusing codec 2 (G726-32/8000)
    "guillaume" <sip:Guillaume@192.168.1.1:5060> is calling you.
>   ALSA lib pcm_mmap.c:363:(snd_pcm_mmap) mmap failed: Invalid argument
>   Warning:alsa_set_params: Error setting HW params:Invalid argument
    Message:killing sound daemons. 


Do you have an idea how to solve this issue ?


Regards,

Guillaume GOURAT.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
