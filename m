From: Fabio Estevam <festevam@gmail.com>
Subject: Re: fsl_ssi: Cannot do simultaneous capture and
	playback
Date: Mon, 23 Sep 2013 00:14:44 -0300
Message-ID: <CAOMZO5DJhWVoosjGSatQh583JpBFHF9qvYfNL7TyiK876XrVpw@mail.gmail.com>
References: <CAOMZO5CPmYtzbR0Ahn5STKwPO_NnC=n314gJtj3WciUonXuqaQ@mail.gmail.com>
 <20130923021341.GA18203@MrMyself>
 <CAOMZO5AKAnJxRpHB5AyaXfL2GoU=Ek5-qsb77Jw2ZuW1EyaJMw@mail.gmail.com>
 <20130923024028.GA18268@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f178.google.com (mail-ve0-f178.google.com
 [209.85.128.178])
 by alsa0.perex.cz (Postfix) with ESMTP id D5A73265113
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 05:14:45 +0200 (CEST)
Received: by mail-ve0-f178.google.com with SMTP id jw12so1854478veb.23
 for <alsa-devel@alsa-project.org>; Sun, 22 Sep 2013 20:14:45 -0700 (PDT)
In-Reply-To: <20130923024028.GA18268@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On Sun, Sep 22, 2013 at 11:40 PM, Nicolin Chen <b42378@freescale.com> wrote:
> On Sun, Sep 22, 2013 at 11:56:17PM -0300, Fabio Estevam wrote:

> I want to, but I don't have a wandboard. Could you please give me the new
> printed log? I think after the modification there should be little different
> for the case.

Sorry, I made something wrong and now it is working.

Will submit the patch.

Running several times in a row, sometimes I get:

$ arecord -d 10 -f cd | aplay -f cd
fsl-ssi-dai 2028000.ssi: ASoC: Not enforcing symmetric_rates due to race
sgtl5000 1-000a: ASoC: Not enforcing symmetric_rates due to race
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

,but the playback always work now.

Thanks,

Fabio Estevam
