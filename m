From: Abramo Bagnara <abramo.bagnara@tin.it>
Subject: Re: DMIX and capture stream
Date: Wed, 07 Jan 2004 17:58:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FFC3AA2.6070209@tin.it>
References: <Pine.LNX.4.58.0401051113381.8705@tomservo.workpc.tds.net>	<200401051741.i05HfCXl007120@dhin.linuxaudiosystems.com>	<s5h1xqe2rjp.wl@alsa2.suse.de>	<Pine.LNX.4.58.0401061105040.8705@tomservo.workpc.tds.net>	<20040106223828.39d2c233.mista.tapas@gmx.net>	<s5hvfno10r5.wl@alsa2.suse.de>	<3FFBFF51.1030002@tin.it>	<s5hptdv27pz.wl@alsa2.suse.de>	<3FFC1A12.7020901@tin.it>	<s5hd69v245x.wl@alsa2.suse.de>	<3FFC229C.2020200@tin.it>	<s5hbrpf22u3.wl@alsa2.suse.de>	<3FFC2A29.4080401@tin.it> <s5h4qv720ww.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qv720ww.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Florian Schmidt <mista.tapas@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>>
>>>	pcm.foo {
>>>		type plug
>>>		slave {
>>>			pcm bar
>>>		}
>>>	}
>>>	pcmp.bar bar_playback
>>>	pcmc.bar bar_capture
>>>
>>>i think it's a big restriction.
>>
>>As a matter of personal preference I very much prefer this latter form 
> 
> 
> i do, too.
> 
> but it means that the inline definition isn't equivalent any longer
> with the external definition, since you cannot express the
> playback/capture-only pcm in the inline slave pcm.  that's what i'm
> concerned.

This is true only inside duplex PCM definition and I like to consider 
that a feature, i.e. duplex definition should be the same for both 
directions.

>>Technically they're quite the same.
> 
> 
> also my asym plugin, too :)  it doesn't introduce any overhead except
> for parsing.

It's true but I'd prefer to not have too many PCM types.

Take also in account that the association between playback stream and 
capture stream is definitely arbitrary and a well written duplex ALSA 
native application should ask for two PCM names.

I fear that this extension will encourage bad programming practice.

Thinking further, I've changed my mind: what about to have an OSS 
emulation specific configuration?

Just like:

aoss_pcm_w.dsp0 dmix
aoss_pcm_r.dsp0 dsnoop

I think it's a far better solution and will leave native library intact.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@tin.it

Opera Unica                          Phone: +39.0546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
