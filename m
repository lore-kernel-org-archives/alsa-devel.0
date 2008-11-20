From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: Re: twl4030 asoc kcontrols and widgets
Date: Thu, 20 Nov 2008 19:47:34 +0530
Message-ID: <ef0d8a250811200617s49f2abao5676e085a2b71d17@mail.gmail.com>
References: <ef0d8a250811200138y36fc840dn9978dd862214dec4@mail.gmail.com>
	<200811201602.44035.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.242])
	by alsa0.perex.cz (Postfix) with ESMTP id DF7E02432F
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 15:17:35 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so458875rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 06:17:34 -0800 (PST)
In-Reply-To: <200811201602.44035.peter.ujfalusi@nokia.com>
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
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 7:32 PM, Peter Ujfalusi <peter.ujfalusi@nokia.com>w=
rote:

> Hello,
>
> I have been also working on the twl4030 codec driver for some time now.
> Altrough my patchset is not yet ready, but I'd like to be heard early
> enough:
> My plan is to add _all_ (ok, almost all) the features we can get with
> TWLx030...
> So instead of having 'only' one possible route from DACl2/DACR2, I have
> implemented in a reverse order:
> For all outputs (HSOL/R, PreDriveL/R, HFL/R IHFL/R, EAR) one can select
> from where the audio is routed.
> For example:
> PreDriveL can output audio from Voice, DACL1, DACL2, DACR2
> PreDriveR can output audio from Voice, DACR1, DACR2, DACL2
> HSOL can output audio from Voice, DACL1, DACL2
> HSOR can output audio from Voice, DACR1, DACR2
> and the list goes on...
> With this mode one can enable whatever combination of routing he/she
> needs from TWL.
>
> Since these channels are really 'independent' inside of TWL, making the
> routing/mixing flexible (you might say extremely flexible) could make
> sense.
>
> CCing: Steve Sakoman who actually wrote the driver - could cc Mark Brown
> as well, but it seams that he is reading alsa-devel quite frequently ;)
>
> What do you think?

Great job.
In my case being a custom board the other paths (DACL1 and Voice) and Pre
car kit are not configured.

Routing that way would get full CODEC into use and using DAPM events then
would really give their best.


>
> --
> P=E9ter
>
> On Thursday 20 November 2008 11:38:33 ext naveen krishna ch wrote:
> > Hi Alsa devel,
> >
> > I have been working on TWL4030 codec driver for ALSA SOC.
> > I have taken sound/soc/codec/twl4030.c as reference from main line
> >
> > This Patch adds some kcontrols, widgets and interconnection map for some
> of
> > the TWL4030 ASOC codec
> > I was building it for a custom board as it was for OVERO
> >
> >
> > Suggestions on the DAPM part of the driver would be helpful
> >
> > Thanks in advance.
> >
> > The patch is as follows.
> > I need suggestions on the DAPM part of the driver.
> >
> > Thanks and Regards,
> >
> > (: Naveen Krishna Ch :)
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>



-- =

Thanks,
keep smiling...
keep winning...

(: Naveen Krishna Ch :)
