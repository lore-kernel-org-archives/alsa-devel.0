From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC - Add support for upto 16 channels on
	OMAP MCBSP
Date: Thu, 5 Nov 2009 10:14:21 +0200
Message-ID: <200911051014.21260.peter.ujfalusi@nokia.com>
References: <1257357235.2887.499.camel@odin>
	<20091104185534.GA22055@xora.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C2791038B4
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 09:14:33 +0100 (CET)
In-Reply-To: <20091104185534.GA22055@xora.vm.bytemark.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Graeme Gregory <gg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 04 November 2009 20:55:34 ext Graeme Gregory wrote:
> =

> This chunk changes the semantics of other devices which I have never
>  tested.
> =

> I also dont know how much damage it does if it does to slave mode. In fact
> I think it might break it in cases which are actually allowable as it uses
> the omap as its clock constraint and not the clock source.

For the first look this is going to break the slave mode, when McBSP is sla=
ve =

the data->in_freq is going to be 0 (not configured).
In McBSP slave mode the sample rate generator (SRG) is not is use.

> =

> Graeme

-- =

P=E9ter
