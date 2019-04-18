From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Date: Thu, 18 Apr 2019 02:05:35 -0700
Message-ID: <20190418090534.GB4028@Asurada>
References: <VE1PR04MB647965FEAF3506E1775397AEE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VE1PR04MB647965FEAF3506E1775397AEE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 18, 2019 at 08:50:48AM +0000, S.j. Wang wrote:
> > And this is according to IMX6DQRM:
> >     Limited support for the case when output sampling rates is
> >     between 8kHz and 30kHz. The limitation is the supported ratio
> >     (Fsin/Fsout) range as between 1/24 to 8
> > 
> > This should cover your 8.125 condition already, even if having an outrate
> > range between [8KHz, 30KHz] check, since an outrate above 30KHz will not
> > have an inrate bigger than 8.125 times of it, given the maximum input rate
> > is 192KHz.
> > 
> > So I think that we can just drop that 8.125 condition from your change and
> > there's no need to error out any more.
> > 
> No, if outrate=8kHz,  inrate > 88.2kHz, these cases are not supported. 
> This is not covered by
> 
>         if ((outrate > 8000 && outrate < 30000) &&
>             (outrate/inrate > 24 || inrate/outrate > 8)) {

Good catch. The range should be [8KHz, 30KHz] vs. (8KHz, 32KHz)
in the code. Then I think the fix should be at both lines:

-         if ((outrate > 8000 && outrate < 30000) &&
-             (outrate/inrate > 24 || inrate/outrate > 8)) {
+         if ((outrate >= 8000 && outrate =< 30000) &&
+             (outrate > 24 * inrate || inrate > 8 * outrate)) {

Overall, I think we should fix this instead of adding an extra
one, since it is very likely saying the same thing.
