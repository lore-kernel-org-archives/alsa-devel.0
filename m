From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 6/7] ASoC: TWL4030: Add volume controls for
	outputs
Date: Mon, 8 Dec 2008 09:13:56 +0200
Message-ID: <200812080913.56256.peter.ujfalusi@nokia.com>
References: <20081201200703.GA14376@rakim.wolfsonmicro.main>
	<1228162061-14769-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<ef0d8a250812042044n3968719r6eb996897ce90ade@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 7871D103800
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 08:14:05 +0100 (CET)
In-Reply-To: <ef0d8a250812042044n3968719r6eb996897ce90ade@mail.gmail.com>
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
To: ext naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello,

interesting...

On Friday 05 December 2008 06:44:35 ext naveen krishna ch wrote:
> On Tue, Dec 2, 2008 at 1:37 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>
>
> With this implementation the
> #amixer cset numid=3D16 3
> numid=3D16,iface=3DMIXER,name=3D'PreDriv Playback Volume'
>   ; type=3DINTEGER,access=3Drw---R--,values=3D2,min=3D0,max=3D209,step=3D0
>
>   : values=3D3,3
>   :
>   | dBscale-min=3D-12.00dB,step=3D6.00dB,mute=3D1
>
> Thanks ,,
>
> (: Naveen Krishna Ch :)

I have other patches on top of that, so the numid is different, but it give=
s:
# amixer cset numid=3D7 3
numid=3D7,iface=3DMIXER,name=3D'PreDriv Playback Volume'
  ; type=3DINTEGER,access=3Drw---R--,values=3D2,min=3D0,max=3D3,step=3D0
  : values=3D3,3
  | dBscale-min=3D-12.00dB,step=3D6.00dB,mute=3D1


-- =

P=E9ter
