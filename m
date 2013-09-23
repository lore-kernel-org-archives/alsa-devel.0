From: Nicolin Chen <b42378@freescale.com>
Subject: Re: fsl_ssi: Cannot do simultaneous capture and
	playback
Date: Mon, 23 Sep 2013 11:19:55 +0800
Message-ID: <20130923031954.GB18268@MrMyself>
References: <CAOMZO5CPmYtzbR0Ahn5STKwPO_NnC=n314gJtj3WciUonXuqaQ@mail.gmail.com>
 <20130923021341.GA18203@MrMyself>
 <CAOMZO5AKAnJxRpHB5AyaXfL2GoU=Ek5-qsb77Jw2ZuW1EyaJMw@mail.gmail.com>
 <20130923024028.GA18268@MrMyself>
 <CAOMZO5DJhWVoosjGSatQh583JpBFHF9qvYfNL7TyiK876XrVpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AE2B265113
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 05:21:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5DJhWVoosjGSatQh583JpBFHF9qvYfNL7TyiK876XrVpw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 23, 2013 at 12:14:44AM -0300, Fabio Estevam wrote:
> Hi Nicolin,
> 
> On Sun, Sep 22, 2013 at 11:40 PM, Nicolin Chen <b42378@freescale.com> wrote:
> > On Sun, Sep 22, 2013 at 11:56:17PM -0300, Fabio Estevam wrote:
> 
> > I want to, but I don't have a wandboard. Could you please give me the new
> > printed log? I think after the modification there should be little different
> > for the case.
> 
> Sorry, I made something wrong and now it is working.
> 
> Will submit the patch.

Great.

> 
> Running several times in a row, sometimes I get:
> 
> $ arecord -d 10 -f cd | aplay -f cd
> fsl-ssi-dai 2028000.ssi: ASoC: Not enforcing symmetric_rates due to race
> sgtl5000 1-000a: ASoC: Not enforcing symmetric_rates due to race
> Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> 
> ,but the playback always work now.
> 
> Thanks,

Welcome.

> 
> Fabio Estevam
> 
