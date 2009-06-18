From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Progress in adding ams-delta support to ASoC?
Date: Thu, 18 Jun 2009 12:02:10 +0300
Message-ID: <200906181202.11414.peter.ujfalusi__27462.8316554756$1245315818$gmane$org@nokia.com>
References: <4A1BEBE3.8010306@tis.icnet.pl> <4A37AFA9.4080403@tis.icnet.pl>
	<4A38F9D6.5000803@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A38F9D6.5000803@tis.icnet.pl>
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
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 17 June 2009 17:12:38 ext Janusz Krzysztofik wrote:
> Janusz Krzysztofik wrote:
> > After all, it is more and more likely that the problem is not dma, but
> > mcbsp just not shifting any data for some mysterious reason.
>
> I finally did what I should have already done before: learned about
> dynamic debugging, turned it on and probably got the answer from
> omap_msbsp_dump_reg(): all mcbsp1 register read operations returned
> 0xffff. So it looks like I simply get no acccess to mcbsp1 at all. Now I
> wonder if I can close this thread with a conclusion that mcbsp1 on
> opam15xx is simply not yet supported by the mainline kernel that I have
> based my work on.

Hmmm, this is quite unexpected.
Can you access to mcbsp2 or 3 registers, or only the mcbsp1 registers are n=
ot =

accessible?
One thing that I have noticed is that the McBSP1 (and 3) is under the DSP =

Public Peripherals, while McBSP2 is under MPU Public Peripherals (in =

OMAP1510).
I have to check it further what this actually means...

>
> Thanks,
> Janusz

-- =

P=E9ter
