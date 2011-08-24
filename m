From: Ulo Mets <umets@osa.pri.ee>
Subject: Re: Conexant 5051 lenovo-x200 fixes
Date: Wed, 24 Aug 2011 14:26:51 +0300
Message-ID: <4E54DFFB.7010600@osa.pri.ee>
References: <4E4C60AD.2090806@osa.pri.ee> <s5hzkj7t4ju.wl%tiwai@suse.de>
	<4E4DA7BA.5020704@osa.pri.ee> <s5h62lulzx2.wl%tiwai@suse.de>
	<4E4FCF4C.5070402@osa.pri.ee> <s5h4o19slk2.wl%tiwai@suse.de>
	<4E538FC5.5020600@osa.pri.ee> <s5hhb58p92f.wl%tiwai@suse.de>
	<4E546F46.2040803@osa.pri.ee> <s5h39grqrsz.wl%tiwai@suse.de>
	<s5hd3fvp4m0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from polaris.osa.pri.ee (polaris.osa.pri.ee [194.204.58.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F961249DF
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 13:27:28 +0200 (CEST)
In-Reply-To: <s5hd3fvp4m0.wl%tiwai@suse.de>
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

On 08/24/2011 11:59 AM, Takashi Iwai wrote:
> At Wed, 24 Aug 2011 07:53:00 +0200,
> Takashi Iwai wrote:
>>> In Rec screen of Alsamixer all three mic volume and boost controls are present.
>>> Autosensing of Dock Mic works, and so do its controls. Internal mic works too, but
>>> autosensing of Ext mic does not.
>> Does ext-mic pin (0x18) jack-sense work with hda-emu at all?
>> When this pin is selected, the recording is done via another ADC
>> (0x15) instead of the one for int-mic and dock-mic (0x14).
>> Try to reopen the recording stream when you plug the ext-mic.
>> It might be a bug in the dynamic ADC-switching of the running stream.
> The patch below should fix the ADC-switching behavior.
Thank you so much! Recording side works also great now.
The only remaining issue seems to be that the Auto-Mute Mode control
has no effeect on speaker muting. It is always muted.
The speaker mute button on the keyboard also mutes the speaker, and the volume buttons unmute it.
The Beep volume also works, but Beep mute only affects the treble content of the beep.

And then the most important part: in proc file, both Dock connectors are described as black,
and the Dock Mic location states "at sep Left", while it should be "sep Rear" I believe.

If you need to test anything else on X200t, or T420, I'll be happy to help.

Thanks once more!
With best regards,

Ulo
