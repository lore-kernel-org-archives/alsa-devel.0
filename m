From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3] ASoC: dapm: Avoid creating kcontrol for
	params
Date: Mon, 9 Oct 2017 09:34:56 +0100
Message-ID: <20171009083456.mrpdegqav5znur6p@localhost.localdomain>
References: <1506660759-61727-1-git-send-email-yesanishhere@gmail.com>
 <20170929090938.7hiem3daebiaodqh@localhost.localdomain>
 <CABCoZhB+aT_m5nd9ejWdRphHQL=557+j9h1E5iBTxWExLet2yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 25006266BFD
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 10:34:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CABCoZhB+aT_m5nd9ejWdRphHQL=557+j9h1E5iBTxWExLet2yg@mail.gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 08, 2017 at 11:29:45PM -0700, anish kumar wrote:
> On Fri, Sep 29, 2017 at 2:09 AM, Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Thu, Sep 28, 2017 at 09:52:39PM -0700, yesanishhere@gmail.com wrote:
> >> From: anish kumar <yesanishhere@gmail.com>
> >>
> >> Currently in codec to codec dai link if there are multiple
> >> params defined then dapm can use created kcontrol to
> >> decide which param to apply at runtime.
> >>
> >> However, in case there is only single param configuration
> >> then there is no point in creating the kcontrol and also there
> >> is no point in allocating memory for kcontrol.
> >>
> >> In the snd_soc_dapm_new_pcm function, there is memory
> >> allocation happening for kcontrol which is later used
> >> or not used based on num_param. It is better to not
> >> allocate memory when there is only a single configuration.
> >> This change is to remedy that anomaly.
> >>
> >> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> >> ---
> >
> > Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> Charles, do you know if there is anything pending for this series
> to be picked up for merge in mark's tree?
> >

Its been picked up that's what that email from Mark is letting
you know. However, you do need to do an incremental patch on top
of this one for the issues the Intel build bot spotted with the
patch.

Thanks,
Charles
