From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: Workaround for headset DC
	offset caused pop noise
Date: Wed, 12 Oct 2011 13:45:33 +0300
Message-ID: <5817000.NdMGYPik3n@barack>
References: <1318330813-31184-1-git-send-email-peter.ujfalusi@ti.com>
	<2135466.UdidpbexSR@barack>
	<20111012094625.GA3647@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 3835F244CF
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 12:45:32 +0200 (CEST)
Received: by mail-gx0-f171.google.com with SMTP id k4so1054502ggn.30
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2011 03:45:31 -0700 (PDT)
In-Reply-To: <20111012094625.GA3647@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 12 October 2011 10:46:25 Mark Brown wrote:
> On Wed, Oct 12, 2011 at 11:55:15AM +0300, P=E9ter Ujfalusi wrote:
> > I can not move the HS DAC power on/off to be handled by a supply
> > widget... Refcounting in a supply widget will not work for the power
> > down, since the supply widget will be turned off after the DAC widget.
> > At time when the DAC receives the PMD event the attached supply is
> > still on.
> > I can update the commit message to explicitly say that we need to turn
> > on both HS DAC at the same time, and we need to turn tem off at the
> > same time.
> I still don't understand what the problem is.  If nothing else you can
> do random register writes from an event on a supply widget...

I still have the code for the out of order McPDM shutdown which is using a =

supply widget attached to the codec's DAC/ADC.
The ordering of the two supply is not written in stone when both are attach=
ed =

to the same DAC.
Yes, I'm evaluating the possibility of the reordering the shutdown sequence=
 in =

the core as you have suggested a while back. =


For this patch: I will merge the two DAC to one, and handle both of them in=
 a =

single DAC widget. I have tested this and works fine.

--
P=E9ter
