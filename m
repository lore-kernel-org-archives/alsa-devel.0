From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC PATCH 0/5] OMAP/ASoC: McBSP: FIFO handling
	related fixes
Date: Mon, 31 May 2010 11:14:10 +0300
Message-ID: <201005311114.10955.peter.ujfalusi@nokia.com>
References: <1275293006-31594-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 810F72434D
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 10:14:46 +0200 (CEST)
In-Reply-To: <1275293006-31594-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, "tony@atomide.com" <tony@atomide.com>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

And I managed to mistype linux-omap...
Resending.
Sorry for the noise.

-- =

P=E9ter


On Monday 31 May 2010 11:03:21 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> Hello,
> =

> This series aims to correct how the McBSP FIFO is viewed, and handled.
> =

> Introduction of the problem:
> OMAP McBSP FIFO is word structured:
> McBSP2 has 1024 + 256 =3D 1280 word long buffer,
> McBSP1,3,4,5 has 128 word long buffer
> =

> This means, that the size of the FIFO
> depends on the McBSP word size configuration.
> For example on McBSP3:
> 16bit samples: size is 128 * 2 =3D 256 bytes
> 32bit samples: size is 128 * 4 =3D 512 bytes
> It is simpler to place constraint for buffer and period based on channels.
> McBSP3 as example again (16 or 32 bit samples):
> 1 channel (mono): size is 128 frames (128 words)
> 2 channels (stereo): size is 128 / 2 =3D 64 frames (2 * 64 words)
> 4 channels: size is 128 / 4 =3D 32 frames (4 * 32 words)
> =

> Since now the McBSP codec supports not only 16bit samples (32biut has been
> recently added), the FIFO size handling is no longer correct, since it has
> been hard wired for 16bit word length.
> =

> The series changes how the users of McBSP are configuring the FIFO:
> It used to be 0 based (0 meant 1 word threshold). After this series users
> can configure the threshold in 1 base mode (1 means 1 word threshold). The
> platform code now provides the _full_ size of the FIFO in words, instead
> of the already limited value used in the past.
> =

> In ASoC omap-mcbsp code hw_rule based constraint refinement is going to be
> used instead of the hardwired static constraint, which was correct only in
> case of 16bit word length.
> =

> The hw_rule is refining the minimum buffer size based on the channel numb=
er
> going to be used by the coming stream.
> In case of threshold mode additional hw_rule refines the maximum allowed
> period size.
> =

> The series are generated agains Takashi's sound-2.6: topic/asoc branch.
> =

> CCing also Eduardo, and Eero since they have worked on the original
> FIFO/threshold implementation.
> =

> All commetns and testers are welcome!
> Peter
> =

> ---
> Peter Ujfalusi (5):
>   OMAP: McBSP: Function to query the FIFO size
>   OMAP3: McBSP: Change the way how the FIFO is handled
>   OMAP3: McBSP: Use the port's buffer_size when calculating tx delay
>   ASoC: omap-mcbsp: Save, and use wlen for threshold configuration
>   ASoC: omap-mcbsp: Place correct constraints for streams
> =

>  arch/arm/mach-omap2/mcbsp.c             |   10 ++--
>  arch/arm/plat-omap/include/plat/mcbsp.h |    2 +
>  arch/arm/plat-omap/mcbsp.c              |   31 ++++++---
>  sound/soc/omap/omap-mcbsp.c             |  112
> +++++++++++++++++++++++------- 4 files changed, 114 insertions(+), 41
> deletions(-)
> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
