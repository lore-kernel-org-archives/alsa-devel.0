From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: [Fwd:  Multiple cards.]
Date: Thu, 13 Jun 2002 00:02:51 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D07629B.5050904@boosthardware.com>
References: <3D071F9B.1090302@boosthardware.com>	<s5hk7p42158.wl@alsa2.suse.de>	<3D073B64.2010200@boosthardware.com>	<s5hit4o1vmv.wl@alsa2.suse.de>	<3D0752F3.7070907@boosthardware.com> <s5helfc1twc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id QAA26574
	for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2002 16:58:19 +0200
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
> At Wed, 12 Jun 2002 22:56:03 +0900,
> Patrick Shirkey wrote:
> 
>>Takashi Iwai wrote:
>>
>>>>----
>>>># aplay  -f dat -D ttable /1REC/beastie_boys-track_8.wav
>>>>Playing WAVE '/1REC/beastie_boys-track_8.wav' : Signed 16 bit Little 
>>>>Endian, Rate 44100 Hz, Stereo
>>>>aplay: set_params:737: Broken configuration for this PCM: no 
>>>>configurations available
>>>
>>> 
>>>the error came from snd_pcm_hw_params_any().
>>>
>>>i'm wondering why the second card has only one channel.
>>>is it really correct?
>>>
>>>
>>
>>It has one pcm device yes. hw1:0
> 
>  
> but this pcm device has stereo channels, doesn't it?
> 
> 
> sorry, i still have not clear idea what you are exactly trying to do.
> 
> you have two consumer cards.  assuming sblive and cmipci.
> and you'd like to combine these two cards as if 4 channel captures
> (and playbacks).  or do you have any other wish?
> 
> if yes, the exactly same as Joern's configuration should work...
> 

Sort of.  The cmipci has two stereo devices and the intel8x0 has one.

If I want the cards ganged then I want to be able to use all the 
playback channels. Unfortunately the cmipci doesn't have a corresponding 
  capture device for pcmC0D1p which I think is what's causing the problems.

I'm not sure that the .asoundrc file can deal with that or not. Is there 
anything I can do to fake pcmC0D1c or alsa-lib into using pcmC0D0c 
instead or can I just not use that device as part of a multishare dummy 
card?

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
