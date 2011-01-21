From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: Re: [QUERY] [AUDIO][OMAP3 EVM] arecord not working on
	OMAP3 EVM
Date: Fri, 21 Jan 2011 19:30:38 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F9B2821__24401.2962481522$1295940207$gmane$org@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC356087035F9B2239@dbde02.ent.ti.com>
	<4D393C42.1070503@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4D393C42.1070503@nokia.com>
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
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Thanks Peter, =

Your comment helped.

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]
> Sent: Friday, January 21, 2011 1:27 PM
> To: Koyamangalath, Abhilash
> Cc: linux-omap@vger.kernel.org; alsa-devel@vger.kernel.org
> Subject: Re: [QUERY] [AUDIO][OMAP3 EVM] arecord not working on OMAP3 EVM
> =

> On 01/20/11 17:26, ext Koyamangalath, Abhilash wrote:
> > Hi all
> > While testing audio capture (using arecord e,g.),I'm getting only noise
> in the (zeroed out) output buffers on the OMAP3 EVM.
> > I have enabled AUXL and AUXR mic inputs through alsamixer, which
> according to the schematics are connected to the "Audio In"
> > connector on the board, even though the TWL4030 reg list does not allow
> me any ways ( or so I think) to specify mic-bias for
> > these aux inputs.
> =

> Well, it is auxiliary input (line in). You do not need bias for it.
> I do not have access to OMAP3 EVM documentation, but Beagle also have
> AUXL/R as input.
> I guess you need to use correct cable, and correct source for the input
> (stereo jack I suppose).
No need of bias precludes using a MIC, so I tried by connecting a Line-in/o=
ut audio cable (a cable with a 3.5 mm audio jack on each end) fed from the =
PC and it worked, thanks. Originally, I had connected a head-phone mic dire=
ctly to the audio-in port, which it seems, rather expects a dc-biased and/o=
r a pre-amplified signal.

> =

> > With AUXL and AUXR muted - I get only silence, which seems to make
> sense.
> > Is there any basic startup setting I'm missing, maybe specific to OMAP3
> EVM?
> =

> Beagle?
> =

> > Has anyone seen anything like this before, and could provide pointers?
> =

> My bet goes for the wrong cable/accessory pair.
Bang On.
> =

> --
> P=E9ter
