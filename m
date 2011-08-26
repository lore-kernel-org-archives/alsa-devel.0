From: Daniel Mack <zonque@gmail.com>
Subject: Re: M-Audio FTU remaining mixer controls and external
 clocking support.
Date: Fri, 26 Aug 2011 15:43:17 +0200
Message-ID: <CACTFLAPPdVh7VMvRMR95o0YDHWCxz=ZeK=neiOrzv=0YV_or7Q@mail.gmail.com>
References: <CAE-xCyMB3vRYkCRwy2gskn=+V5vm9ghnnL4qG_G4MFwnhUtYXA@mail.gmail.com>
	<CACTFLAMJ3N6R7ya+B+i4H_fLbeFir8+nuD40JViWfg5oDAr3aw@mail.gmail.com>
	<CAFz=ag4HJKXsb4r+5pAMQN5xX8D=2T5M+jJgofYrT66TpQ0SHg@mail.gmail.com>
	<CACckToXb1cXHLZ_dAzV9_1ga4Se80m2V_uT=FXfABgixv2Jaxw@mail.gmail.com>
	<CACTFLAOgSi+S=JPqd0-t+=aJRLJVeL1D_uDYxQRyX0y0YDvp5A@mail.gmail.com>
	<CACckToXT94xVhuYk1uXZvgytenwfA-FS5AKumvVJV72DwJkRfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 112FC24628
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 15:43:18 +0200 (CEST)
Received: by pzk1 with SMTP id 1so4575711pzk.2
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2011 06:43:17 -0700 (PDT)
In-Reply-To: <CACckToXT94xVhuYk1uXZvgytenwfA-FS5AKumvVJV72DwJkRfQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Aug 26, 2011 3:35 PM, "Grant Diffey" <gdiffey@gmail.com> wrote:
>
> So on my freshly built 3.1-rc1  this applied cleanly but I'm getting
errors every time I try to open the device. on the FTU.
>
> attempting to start jack gives this in dmesg:
>
> [ 2091.951806] stop_endpoints()
> [ 2197.403224] Re-using EP 81 @ffff880003560000
> [ 2197.403243] attr 4
> [ 2197.403929] stop_endpoints()
> [ 2197.403931]  -- data ffff880003560000
> [ 2197.403933]  -- sync           (null)
> [ 2197.403935] Unable to change format on ep #81: already in use
>
> and hitting play on audacity results in the attached dmesg errors.
>
> is this expected currently?

Can you try to just open either the playback or the capture stream
seperately, and not both at the same time?

Daniel
