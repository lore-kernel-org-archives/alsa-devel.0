From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: RFC:  Appropriate device detection for Wine  (more
 advice needed)
Date: Mon, 13 Jun 2005 22:22:40 -0500
Message-ID: <42AE4D80.70608@codeweavers.com>
References: <Pine.HPX.4.33n.0506130919470.20036-100000@studcom.urz.uni-halle.de>	<42AD7ADC.8090102@codeweavers.com>	<s5hpsuqe8p1.wl@alsa2.suse.de>	<42AD9176.10004@codeweavers.com>	<s5hhdg2e3ou.wl@alsa2.suse.de>	<42AD9FAF.6050501@codeweavers.com> <s5hekb6e1fp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekb6e1fp.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>So it sounds like the right approach is to try default:X,
>>and if that fails, to fallback to plug:hw:X.
>>
>>Does that sound rational?
> 
> 
> Yes.  That'll be good for both old and new versions.

Okay...next odd question.  Why does default:0
work, but default:0,0 not work?

Alsa lib 1.0.8-3 (debian), which seems like a recent
enough version to do base line testing on.

I appreciate any insight.

Thanks,

Jeremy

------
  ~/xfer/pcm -D default:0,0
Playback device is default:0,0
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
ALSA lib conf.c:3792:(parse_args) Unknown parameter 1
ALSA lib conf.c:3914:(snd_config_expand) Parse arguments error: No such file or directory
ALSA lib pcm.c:2068:(snd_pcm_open_noupdate) Unknown PCM default:0,0
Playback open error: No such file or directory


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
