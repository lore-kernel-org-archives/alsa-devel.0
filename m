From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Reg: Implementation of GSM digital audio path
Date: Thu, 25 Jun 2009 14:32:48 +0300
Message-ID: <200906251432.49009.peter.ujfalusi@nokia.com>
References: <1cbe56070906250247j30e63925k3acbff5a5a3e3df8@mail.gmail.com>
	<200906251335.08412.peter.ujfalusi@nokia.com>
	<1cbe56070906250411l25762a2dkce4cad25a7a293ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C4ED103873
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 13:32:58 +0200 (CEST)
In-Reply-To: <1cbe56070906250411l25762a2dkce4cad25a7a293ab@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext shariff <shariffsinbox@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 25 June 2009 14:11:04 ext shariff wrote:
> Hi Peter,
>
>       Thanks for quick response. I understood some what from your mail.
>
>       I will explain, how my hardware is connected.
>
>
>                         USB GSM chip -> McBSP3
>
>                                                     McBSP2 -> TWL4030
>
>       Here, playback functionality will not be there in the GSM path. I
> need to take audio data from GSM. and redirect this to TWL4030 codec.

I see. Sorry I have confused things a bit,
In this case you need to do what Mark has suggested:
dummy dai for the codec, connect it to McBSP3 as it were a normal codec.
Than you will have two PCM on the sound card:
0.0: TWL digital audio
0.1: Your codec

arecord -Dplughw:0.1 | aplay -Dplughw:0.0
or
arecord -Dhw:0.1 | aplay -Dhw:0.0


>
>       The thing is, How and where to implement this GSM path without
> playback? as I am new to this ASoC framework.
>
>       What I understood from ur mail is.  Audio is being redirected from
> the application space i.e arecord will record and store in buffer and this
> buffer is
>
>       being played using aplay to other hardware (twl4030).
>
>       Can we handle the same thing in kernel space ( i.e in driver itself=
).

You anyway have to copy from one buffer to another to be in the safe side (=
in =

theory you could use the same buffer for recording and playback, but it sho=
uld =

be avoided).
So you have to copy the samples from the capture buffer to the playback =

buffer. It really does not matter if it is done inside of the kernel or in =

user space.
This kind of 'routing' clearly belongs to the user space.

>
> Regards,
> Shariff



-- =

P=E9ter
