From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Date: Sun, 21 Apr 2019 20:23:11 -0700
Message-ID: <20190422032310.GA8300@Asurada>
References: <VE1PR04MB6479817B69545A662FFB43B4E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479817B69545A662FFB43B4E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 22, 2019 at 03:15:34AM +0000, S.j. Wang wrote:
> Hi
> 
> > 
> > 
> > On Mon, Apr 22, 2019 at 02:32:35AM +0000, S.j. Wang wrote:
> > > When we want to support more sample rate, for example 12kHz/24kHz
> > we
> > > need update the process_option table, if we want to support more
> > > sample rate next time, the table need to be updated again. which is
> > > not flexible.
> > >
> > > We got a function fsl_asrc_sel_proc to replace the table, which can
> > > give the pre-processing and post-processing options according to the
> > > sample rate.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > 
> > A couple of more small comments.
> > 
> > And please add this when you resend:
> > Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > 
> > > + * Unsupport cases: Tsout > 8.125 * Tsin, Tsout > 16.125 * Tsin
> > 
> > Since we have a ratio validation somewhere else, it's okay to drop this line -
> > - it may confuse people since the function no longer checks these
> > unsupported cases.
> 
> I add this for may be in the future we forget the limitation. Just for a reminder.

Okay. Let's use something more practical like:

+* Make sure to exclude following unsupported cases before calling the function:
+* 1) outrate > 8.125 * inrate
+* 2) outrate > 16.125 * inrate
