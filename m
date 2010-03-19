From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add support for Left
	Justified format
Date: Fri, 19 Mar 2010 12:17:01 +0200
Message-ID: <201003191217.01548.peter.ujfalusi@nokia.com>
References: <1268989879-18303-1-git-send-email-peter.ujfalusi@nokia.com>
	<201003191200.03750.peter.ujfalusi@nokia.com>
	<20100319121308.a43db48d.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C57824393
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 11:17:14 +0100 (CET)
In-Reply-To: <20100319121308.a43db48d.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 19 March 2010 12:13:08 ext Jarkko Nikula wrote:
> On Fri, 19 Mar 2010 12:00:03 +0200
> =

> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > Now with:
> > /* Left justified */
> > fmt =3D	SND_SOC_DAIFMT_LEFT_J |
> > =

> > 		SND_SOC_DAIFMT_NB_IF |
> > 		=

> >  		SND_SOC_DAIFMT_CBM_CFM;
> > =

> > The data line has data when the FS is high (when FS is low, that data
> > line has 0). So this is correct Left Justified.
> > =

> > At least it seams that McBSP is actually shifting out the data at the
> > correct place, when it is slave..
> > =

> > Oh, and I can not explain why this is working, but I do trust on my
> > scope, and it shows me that it is correct :o
> =

> For me it looks it's working because of NB_IF so try again with
> NB_NF :-)

Oh yes :D
You know, I was looking at the diff between the I2S and LEFT_J polarities, =
but =

did not noticed NF vs IF...
Yes, you are right, I need to invert the FS in a similar fashion as we do w=
ith =

the DSP modes.

Thanks for spotting it, I'll send the fixed patch with inverting the FS in =
case =

of LEFT_J

-- =

P=E9ter
