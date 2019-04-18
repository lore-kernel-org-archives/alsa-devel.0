From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Date: Thu, 18 Apr 2019 01:03:10 -0700
Message-ID: <20190418080309.GA9788@Asurada>
References: <AM6PR04MB647093DB49BB13E09B0F181DE3260@AM6PR04MB6470.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM6PR04MB647093DB49BB13E09B0F181DE3260@AM6PR04MB6470.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 18, 2019 at 02:37:03AM +0000, S.j. Wang wrote:
> > Here:
> > > +     /* Does not support cases: Tsout > 8.125 * Tsin */
> > > +     if (inrate * 8 > 65 * outrate)

Though it might not matter any more (see my last comments),
it should be "inrate > 8.125 * outrate" in the comments.

> > > +             return -EINVAL;
> > And here:
> > > +     ret = fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
> > > +     if (ret) {
> > > +             pair_err("No supported pre-processing options\n");
> > > +             return ret;
> > > +     }
> > 
> > Instead of a general message, I was thinking of a more specific one by
> > telling users that the ratio between the two rates isn't supported --
> > something similar to what I suggested previously:
> > 
> >         pair_err("Does not support %d (input) > 8.125 * %d (output)\n",
> >                  outrate, inrate);
> > 

> In fsl_asrc_sel_proc,  we can't call the pair_err for there is no
> struct fsl_asrc_pair *pair in the argument. Do you think we need to
> add this argument?

I's thinking of adding it to the top of fsl_asrc_config_pair()
as a part of inrate-outrate-validation, however, I found that
actually we already have a similar check in the early routine:
	if ((outrate > 8000 && outrate < 30000) &&
	    (outrate/inrate > 24 || inrate/outrate > 8)) {
		pair_err("exceed supported ratio range [1/24, 8] for \
			 inrate/outrate: %d/%d\n", inrate, outrate);
		return -EINVAL;
	}

And this is according to IMX6DQRM:
    Limited support for the case when output sampling rates is
    between 8kHz and 30kHz. The limitation is the supported ratio
    (Fsin/Fsout) range as between 1/24 to 8

This should cover your 8.125 condition already, even if having
an outrate range between [8KHz, 30KHz] check, since an outrate
above 30KHz will not have an inrate bigger than 8.125 times of
it, given the maximum input rate is 192KHz.

So I think that we can just drop that 8.125 condition from your
change and there's no need to error out any more.

However, we do need a patch to fix a potential rounding issue:
-	    (outrate/inrate > 24 || inrate/outrate > 8)) {
+	    (outrate > 24 * inrate || inrate > 8 * outrate)) {

Should fix the missing whitespace also. And it will be needed
to send to stable kernel too. Will you help submit a change?

Thanks
