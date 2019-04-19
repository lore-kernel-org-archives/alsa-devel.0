From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the
 process_option table with function
Date: Fri, 19 Apr 2019 10:21:58 +0000
Message-ID: <VE1PR04MB64791A6A54CBBA9897E67B50E3270@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130072.outbound.protection.outlook.com [40.107.13.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62326F896E2
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 12:21:59 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi

> 
> 
> On Thu, Apr 18, 2019 at 09:37:06AM +0000, S.j. Wang wrote:
> > > > > And this is according to IMX6DQRM:
> > > > >     Limited support for the case when output sampling rates is
> > > > >     between 8kHz and 30kHz. The limitation is the supported ratio
> > > > >     (Fsin/Fsout) range as between 1/24 to 8
> > > > >
> > > > > This should cover your 8.125 condition already, even if having
> > > > > an outrate range between [8KHz, 30KHz] check, since an outrate
> > > > > above 30KHz will not have an inrate bigger than 8.125 times of
> > > > > it, given the maximum input rate is 192KHz.
> > > > >
> > > > > So I think that we can just drop that 8.125 condition from your
> > > > > change and there's no need to error out any more.
> > > > >
> > > > No, if outrate=8kHz,  inrate > 88.2kHz, these cases are not supported.
> > > > This is not covered by
> > > >
> > > >         if ((outrate > 8000 && outrate < 30000) &&
> > > >             (outrate/inrate > 24 || inrate/outrate > 8)) {
> > >
> > > Good catch. The range should be [8KHz, 30KHz] vs. (8KHz, 32KHz) in
> > > the code. Then I think the fix should be at both lines:
> > >
> > > -         if ((outrate > 8000 && outrate < 30000) &&
> > > -             (outrate/inrate > 24 || inrate/outrate > 8)) {
> > > +         if ((outrate >= 8000 && outrate =< 30000) &&
> > > +             (outrate > 24 * inrate || inrate > 8 * outrate)) {
> > >
> > > Overall, I think we should fix this instead of adding an extra one,
> > > since it is very likely saying the same thing.
> >
> > Actually if outrate < 8kHz, there will be issue too.
> 
> Here is the thing, the RM doesn't explicitly state that ASRC can support a
> lower output sample rate than 8KHz. And I actually had a concern when
> reviewing your PATCH-2, as the table of supported output sample rate no
> longer matches RM.
> 
> If you've verified a lower output sample rate working solid with the
> process_option function, that means our driver can go beyond the
> limitation mentioned in the RM, then I believe [8KHz, 32KHz] should be
> updated too -- that says we can do:
> -       if ((outrate > 8000 && outrate < 30000) &&
> -           (outrate/inrate > 24 || inrate/outrate > 8)) {
> +       if ((outrate >= 5512 && outrate =< 30000) &&
> +           (outrate > 24 * inrate || inrate > 8 * outrate)) {
> 
> Actually "ourate > 24 * inrate" is kind of pointless for range [5KHz, 32KHz]
> but we can keep it since it matches RM.

Ok, will send v4.

Best regards
Wang shengjiu
