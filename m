From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Not important oops
Date: Thu, 22 Jan 2004 00:29:44 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400F1978.4030901@superbug.demon.co.uk>
References: <200401211255.i0LCtroL006857@www1.pobox.sk>	<s5h65f56t7b.wl@alsa2.suse.de>	<Pine.LNX.4.58.0401211945400.2010@pnote.perex-int.cz> <s5h3ca96scx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3ca96scx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, p z oooo <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 21 Jan 2004 19:49:39 +0100 (CET),
> Jaroslav wrote:
> 
>>On Wed, 21 Jan 2004, Takashi Iwai wrote:
>>
>>
>>>At Wed, 21 Jan 2004 13:55:53 +0100,
>>>p z oooo wrote:
>>>
>>>>Hi,
>>>>
>>>>When I remove control through hwdep layer on emu10k1 
>>>>driver when in use by oss emulation I got oops. 
>>>>This is because oss emulation holds pointer to this control.
>>>>Is there any api to disable an then enable oss emulation or 
>>>>only proc interface ???
>>>
>>>hmm weird, the access to ctl elements in mixer_oss.c is restricted
>>>with card->controls_rwsem.  since snd_emu10k1_del_controls issues
>>>down_write() for it, it must be safe...
>>
>>I think that he meant that slot->kcontrol members are not removed. 
> 
> 
> ah yes, i overlooked that.
> 
> 
>>We need probably rebuild the OSS mixer -> ALSA control connections when
>>a control - which is used with the OSS mixer code - was removed.
> 
> 
> or, store only the snd_ctl_elem_id instead of kcontrol, and retrieve
> the control at each time.  since the access to the mixer element is
> less frequent than pcm, the overhead by this won't be too much, i
> think.
> 
> but rebuilding would be better, when the mixer elements are completely
> changed and become incompatible with the old setting.
> 
> we can use notify handler for this (e.g. SND_MIXER_OSS_NOTIFY_RECONFIGURE).
> (but the caller should be blocked until the notification is processed,
>  otherwise there would be a race condition.)
> 
> 
> Takashi
> 
While you are looking at the oss emulation mixer, there is another bug 
there.

User application does VOL++.
OSS has a range from 0-100
ALSA uses hardware range of 0-31.
THus: -
OSS VOL=0
OSS VOL++
ALSA VOL stays at 0
OSS READ VOL, = 0;

It seems like to emulate OSS correctly, one needs to hold volume values 
in the OSS mixer emulation code, instead of just passing them through to 
the ALSA mixer.

Cheers
James



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
