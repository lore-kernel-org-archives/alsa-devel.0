From: "Sebastian H." <vand2@gmx.de>
Subject: Re: asihpi: Control naming
Date: Thu, 30 Sep 2010 23:28:46 +0200
Message-ID: <4CA5010E.4050705@gmx.de>
References: <4CA4078E.6010601@audioscience.com>
	<s5h62xng4wm.wl%tiwai@suse.de>	<4CA4F1D8.50800@audioscience.com>
	<s5haamz9che.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 0350410397C
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 23:26:56 +0200 (CEST)
In-Reply-To: <s5haamz9che.wl%tiwai@suse.de>
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
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, Eliot Blennerhassett <linux@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>> "PCM 3 Capture Meter" is regarded as a playback control since it has
>>> an invalid (unknown) suffix.  If it's "PCM 3 Meter Capture Volume",
>>
>> But it is not a volume, it is a level meter?!
>> We also have controls for tuners, microphones, equalizers, sampleclocks
>> etc.  Surely these can't be all "Volume" or "Switch"
>> I'm not sure why the suffix has any bearing on the direction?
> 
> Actually, this control is handled as a "neutral" control without
> the directional attribute.  alsamixer or else may show it in the
> playback but also may show in capture, too.
> 

This is interesting. In alsamixer-qt4 I've just stumbled over
enum elements for which both
snd_mixer_selem_is_enum_playback and
snd_mixer_selem_is_enum_capture
return 0/false (2.6.32 kernel emu10k1 chip).

May I drop the question in if this state can be considered valid
and besides *playback* and *capture* elements there's a third group of
*neutral* elements?

(On the other hand switches and volumes are always directed.)

Right now I handle it by dumping a warning message to stdout
and puting it into the playback direction element list.

Sebastian
