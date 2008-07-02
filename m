From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Re: Alsa 32-64 bit issue
Date: Wed, 02 Jul 2008 16:07:15 -0300
Message-ID: <486BD1E3.8020806@tet.com.br>
References: <486B6B02.4020202@rosenauer.org>
	<s5h1w2ccwj4.wl%tiwai@suse.de>	<486B7726.1040608@rosenauer.org>
	<486BCBF9.2090906@rosenauer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail.tteng.com.br [201.86.232.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F17B2464D
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 21:07:22 +0200 (CEST)
In-Reply-To: <486BCBF9.2090906@rosenauer.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfgang Rosenauer <wolfgang@rosenauer.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

If I am not wrong, a buffer underrun occurs when a playback application =

can't feed the audio buffer fast enough. You could adjust =

/etc/asound.conf according to your sound card, or verify if your =

application isn't taking too long to write to the audio buffer.

Wolfgang Rosenauer escreveu:
> Wolfgang Rosenauer wrote:
>   =

>> Takashi Iwai wrote:
>>     =

>>>> I have an application which does simple PCM output to Alsa. It works s=
o =

>>>> far (if pulseaudio is not used but that's another issue).
>>>> But if I try to run the app (which is compiled for 32bit) on a 64bit =

>>>> Linux system it fails at snd_pcm_start() with the following error:
>>>>
>>>> "Daten=C3=BCbergabe unterbrochen (broken pipe)"
>>>>         =

>>> It means that no data is present on the buffer.
>>>       =

>
> ok, I fixed that by not using snd_pcm_start() at all. Thanks for the hint.
> I still have issues which I find pretty strange though:
>
> The very same application binary always buffer underruns on my x86-64 =

> system while it works (almost) perfectly (at least w/o buffer underruns) =

> on my smaller i586 system.
>
> Anyone can imagine what could cause that?
>
> Thanks,
>   Wolfgang
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> __________ NOD32 3236 (20080702) Information __________
>
> This message was checked by NOD32 antivirus system.
> http://www.eset.com
>
>
>
>   =
