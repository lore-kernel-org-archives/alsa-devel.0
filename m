From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: Re: au88x0_synth
Date: Thu, 31 Mar 2005 18:52:25 -0400
Message-ID: <1112309545.3237.19.camel@localhost>
References: <423CCDAC.80401@netvigator.com> <s5h4qf44vna.wl@alsa2.suse.de>
	 <424A5D7D.2070400@netvigator.com>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <424A5D7D.2070400@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, 2005-03-30 at 16:04 +0800, Raymond wrote:
> http://www.alsa-project.org/~frank/alsa-sequencer/node12.html
> 
> The midi port only need to support 16 voices, the 16 sample rate
> convertors are just enough to produce 16 voices using the mono sound
> samples in the soundfonts au30gm.arl

Yes, but the ADB engine is intended for normal wave playback. The WT
engine is more suited  for Wavetable stuff. It also has some envelope
filters and such for effects. With only 16  voices, you will run out of
them pretty fast (overlapping notes).

> In snd_vortex_playback_hw_adb, .rates = SNDRV_PCM_RATE_CONTINUOUS
> 
> 1) Can the sample rate convertor be used to perform pitch shift ?

Yes.

> 2) Can panning be done by changing the mixin-mixout gain for left/right
> channels of each voice ?

Yes, but again, we should better use the WT processing block which is
there for that purpose.

> The current alsa driver do not even use the timer VORTEX_SMP_TIME or
> timer interrupt VORTEX_SMP_TIMER
> 
> 3) Is there any way to find out the resolution of the timer ?

Yes. Measuring it :)

Best Regards,
-- 
Manuel Jander
Dipl.-Ing. Fachrichtung Elektronik



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
