From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: [Fwd:  Multiple cards.]
Date: Wed, 12 Jun 2002 22:56:03 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D0752F3.7070907@boosthardware.com>
References: <3D071F9B.1090302@boosthardware.com>	<s5hk7p42158.wl@alsa2.suse.de>	<3D073B64.2010200@boosthardware.com> <s5hit4o1vmv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id PAA25621
	for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2002 15:51:15 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>----
>># aplay  -f dat -D ttable /1REC/beastie_boys-track_8.wav
>>Playing WAVE '/1REC/beastie_boys-track_8.wav' : Signed 16 bit Little 
>>Endian, Rate 44100 Hz, Stereo
>>aplay: set_params:737: Broken configuration for this PCM: no 
>>configurations available
> 
>  
> the error came from snd_pcm_hw_params_any().
> 
> i'm wondering why the second card has only one channel.
> is it really correct?
> 
> 

It has one pcm device yes. hw1:0

I think I found the reason though I have changed my .asoundrc slightly.
----
pcm.multi {
         type multi;

         slaves.a.pcm "hw:0,0";
         slaves.a.channels 1;
         slaves.b.pcm "hw:0,1";
         slaves.b.channels 1;
	
         slaves.c.pcm "hw:1,0";
         slaves.c.channels 1;
	
         bindings.0.slave a;
         bindings.0.channel 0;
         bindings.1.slave b;
         bindings.1.channel 0;

         bindings.2.slave c;
         bindings.2.channel 0;
}

# jack will be unhappy if there is no mixer to talk to, so we set
# this to card 0.
ctl.multi {
         type hw;
         card 0;
}


----
# arecord -f cd -D multi -c 3 | aplay -D multi
ALSA lib pcm_hw.c:797:(snd_pcm_hw_open) open /dev/snd/pcmC0D1c failed: 
No such file or directory
arecord: main:447: audio open error: No such file or directory
aplay: playback:1739: read error

----

Is there anyway to fake a capture channel so that I can get the cmipci 
to work with this?

I imagine that it is something to do with

         bindings.1.slave b;
         bindings.1.channel 0;


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
