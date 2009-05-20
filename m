From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030: DAPM restructuring and
	Headset pop-attenuation fix
Date: Wed, 20 May 2009 12:08:25 +0300
Message-ID: <200905201208.25645.peter.ujfalusi@nokia.com>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905200856.32814.peter.ujfalusi@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03057419D3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 37B8B1038AB
	for <alsa-devel@alsa-project.org>;
	Wed, 20 May 2009 11:08:38 +0200 (CEST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03057419D3@dbde02.ent.ti.com>
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
Cc: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "sakoman@gmail.com" <sakoman@gmail.com>, "getarunks@gmail.com" <getarunks@gmail.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 20 May 2009 11:21:02 ext Aggarwal, Anuj wrote:

> [Aggarwal, Anuj] Since different platforms are using different ramp value=
s,
> how should it be handled via the same codec source code? How should this =
be
> done, without modifying the code base? Or should it be done every time us=
er
> wants to play an audio file?

I think we should leave the ramp delay configurable, since it is easier to =

'port' the codec to a new board.
We can add - as Mark already suggested - a platform data parameter for the =

twl4030 codec driver to set the correct ramp delay value for the given boar=
d. =

The actual user will still have means to change it, but if the correct ramp =

delay has been found for the board, the pop attenuation would work out of b=
ox =

on the boards. =


-- =

P=E9ter
