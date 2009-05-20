From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030: DAPM restructuring and
 Headset pop-attenuation fix
Date: Wed, 20 May 2009 13:51:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03057419D3@dbde02.ent.ti.com>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090519103316.7b1ed16b.jhnikula@gmail.com>
	<20090519185806.GA3157@opensource.wolfsonmicro.com>
	<200905200856.32814.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A1B81037F4
	for <alsa-devel@alsa-project.org>;
	Wed, 20 May 2009 10:21:14 +0200 (CEST)
In-Reply-To: <200905200856.32814.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]
> Sent: Wednesday, May 20, 2009 11:27 AM
> To: ext Mark Brown
> Cc: Jarkko Nikula; Aggarwal, Anuj; sakoman@gmail.com; alsa-devel@alsa-
> project.org; getarunks@gmail.com
> Subject: Re: [alsa-devel] [PATCH 0/2] ASoC: TWL4030: DAPM restructuring
> and Headset pop-attenuation fix
> =

> On Tuesday 19 May 2009 21:58:06 ext Mark Brown wrote:
> > On Tue, May 19, 2009 at 10:33:16AM +0300, Jarkko Nikula wrote:
> > > I don't have any objections to these two patches and as the music sti=
ll
> > > plays fine so probably these can be pushed in safely.
> >
> > It seems like the feedback has been pretty much OK so it should be OK
> > apply the patches - Peter?
> =

> I also think, that it should be OK to apply this series.
[Aggarwal, Anuj] Since different platforms are using different ramp values,=
 how should it be handled via the same codec source code? How should this b=
e done, without modifying the code base? Or should it be done every time us=
er wants to play an audio file?
> =

> Thanks,
> P=E9ter
