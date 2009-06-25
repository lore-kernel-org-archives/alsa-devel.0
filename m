From: shariff <shariffsinbox@gmail.com>
Subject: Re: Reg: Implementation of GSM digital audio path
Date: Thu, 25 Jun 2009 16:57:46 +0530
Message-ID: <1cbe56070906250427n3347de23nc0dd1733e2fd9b61@mail.gmail.com>
References: <1cbe56070906250247j30e63925k3acbff5a5a3e3df8@mail.gmail.com>
	<200906251335.08412.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f183.google.com (mail-pz0-f183.google.com
	[209.85.222.183])
	by alsa0.perex.cz (Postfix) with ESMTP id B079324B5F
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 13:27:47 +0200 (CEST)
Received: by pzk13 with SMTP id 13so1121591pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2009 04:27:46 -0700 (PDT)
In-Reply-To: <200906251335.08412.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Peter,

      Thanks for quick response. I understood some what from your mail.

      I will explain, how my hardware is connected.


                        USB GSM chip -> McBSP3

                                                    McBSP2 -> TWL4030

      Here, playback functionality will not be there in the GSM path. I need
to take audio data from GSM. and redirect this
      to TWL4030 codec.

      The thing is, How and where to implement this GSM path without
playback? as I am new to this ASoC framework.

      What I understood from ur mail is.  Audio is being redirected from the
application space i.e arecord will record and store in buffer and this
buffer is

      being played using aplay to other hardware (twl4030).

      Can we handle the same thing in kernel space ( i.e in driver itself).

Regards,
Shariff


On Thu, Jun 25, 2009 at 4:05 PM, Peter Ujfalusi <peter.ujfalusi@nokia.com>w=
rote:

> On Thursday 25 June 2009 12:47:54 ext shariff wrote:
> > Hi all,
> >
> >         Iam working on OMAP3 based custom board. On our board, GSM
> digital
> > audio path is connected to McBSP3 and
> > TWL4030 digital audio path is connected to McBSP2.
> >
> > I want to implement a module that transfers GSM audio data and store
> audio
> > data into some buffer and redirect it to TWL4030 audio codec through
> > McBSP2.
> >
> > I question is how can I implement this in ASoC?
> >
> > I studied ASoC framework, but I am unable to understand where to
> implement
> > my stuff.
>
> I think the following should do something like that:
>
> arecord -Dplughw:0.0 | aplay -Dplughw:0.1
> or
> arecord -Dhw:0.0 | aplay -Dhw:0.1
>
> I don't know what is the order of the PCMs with the twl4030 codec on your
> board, this is with the assumption:
> plughw:0.0 - Voice PCM (McBSP3)
> plughw:0.1 - Digital audio PCM (McBSP2)
>
> You might want to try the --rate parameter for arecord to use 16KHz
> recording
> from the Voice interface..
>
> >
> > Regards,
> > Shariff
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> --
> P=E9ter
>
