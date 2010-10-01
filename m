From: "Sebastian H." <vand2@gmx.de>
Subject: Re: asihpi: Control naming
Date: Fri, 01 Oct 2010 13:31:39 +0200
Message-ID: <4CA5C69B.4000703@gmx.de>
References: <4CA4078E.6010601@audioscience.com>	<s5h62xng4wm.wl%tiwai@suse.de>	<4CA4F1D8.50800@audioscience.com>	<s5haamz9che.wl%tiwai@suse.de>
	<4CA5010E.4050705@gmx.de> <4CA58856.8070505@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id DA80224417
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 13:29:49 +0200 (CEST)
In-Reply-To: <4CA58856.8070505@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 01.10.2010 09:05, schrieb Clemens Ladisch:
> Sebastian H. wrote:
>> In alsamixer-qt4 I've just stumbled over enum elements for which both
>> snd_mixer_selem_is_enum_playback and
>> snd_mixer_selem_is_enum_capture
>> return 0/false (2.6.32 kernel emu10k1 chip).
>>
>> May I drop the question in if this state can be considered valid
> 
> Yes.
> 
>> and besides *playback* and *capture* elements there's a third group of
>> *neutral* elements?
> 
> Those are elements where the simple mixer code doesn't know the
> direction (because the driver author didn't put "Playback" or "Capture"
> into the name).

Ok, but I wonder how to interpret this state in which both functions
return zero.

1) There's a bug or uncertainty somewhere in the libs/driver and
in a perfekt world this would not happen. It always should be either.

2) This is intentional and the respective element belongs to the
group of *general* elements which exists in parallel
to the *playback* and the *capture* element groups.

As mentioned alsamixer-qt4 considers 1) and handles it somehow
gracefully. I just wonder if that is the correct thing to do in case.
