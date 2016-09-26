From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: DAPM: codec to codec link documentation[RFC]
Date: Mon, 26 Sep 2016 09:46:08 +0100
Message-ID: <20160926084608.GW21682@localhost.localdomain>
References: <CABCoZhDD3QhFXCKM59Di9zUTJ1=TT42D-HN=bD05yOUORHVSsg@mail.gmail.com>
 <20160915083321.GO21682@localhost.localdomain>
 <CABCoZhC6OhDo90+WzVzSs8xcr8VmWjkAPdsdNG4fsWQJf0v9GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 05E3F261AE7
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 10:46:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CABCoZhC6OhDo90+WzVzSs8xcr8VmWjkAPdsdNG4fsWQJf0v9GA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles <Charles.Keepax@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 25, 2016 at 10:53:25PM -0700, anish kumar wrote:
> On Thu, Sep 15, 2016 at 1:33 AM, Charles Keepax
> <ckeepax@opensource.wolfsonmicro.com> wrote:
> > On Wed, Sep 14, 2016 at 12:08:56PM -0700, anish kumar wrote:
> >> {
> >>     .name = "your_name",
> >>     .stream_name = "your_stream_name",
> >>     .cpu_dai_name = "snd-soc-dummy-dai",
> >>     .codec_name = "codec-2,
> >>     .codec_dai_name = "codec-2-dai_name",
> >>     .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> >>                     | SND_SOC_DAIFMT_CBM_CFM,
> >>     .ignore_suspend = 1,
> >>     .params = &dummy_params,
> >> },
> >> {
> >>     .name = "your_name",
> >>     .stream_name = "your_stream_name",
> >>     .cpu_dai_name = "snd-soc-dummy-dai",
> >>     .codec_name = "codec-3,
> >>     .codec_dai_name = "codec-3-dai_name",
> >>     .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> >>                     | SND_SOC_DAIFMT_CBM_CFM,
> >>     .ignore_suspend = 1,
> >>     .params = &dummy_params,
> >> },
> >>
> >
> > Probably worth having a look at DT options as well, not sure how
> > well would be supported for c2c links at the mo but probably
> > worth mentioning something about it.
> 
> I didn't get you. Do you mean using DT option to specify if
> a particular node is c2c?

I just mean that most machine drivers these days specify at least
part of the DAI link configuration through device tree. I don't
know off the top of my head what support is currently provided for
codec to codec links in DT, my suspicion is none. So it might be
worth at least noting that.

Thanks,
Charles
