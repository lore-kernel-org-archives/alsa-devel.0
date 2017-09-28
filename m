From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: dapm: Avoid creating kcontrol for
	params
Date: Thu, 28 Sep 2017 09:41:24 +0100
Message-ID: <20170928084124.mcp4m2jfgtg3jm6n@localhost.localdomain>
References: <1506485471-59951-1-git-send-email-yesanishhere@gmail.com>
 <20170927101148.o24d5bncuddh6ykh@localhost.localdomain>
 <CABCoZhDUmT9yYh1GVpoxUhjg9U+DjnXD2_xBEYQKb-=25G93Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id C8F0926734C
 for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2017 10:41:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CABCoZhDUmT9yYh1GVpoxUhjg9U+DjnXD2_xBEYQKb-=25G93Xw@mail.gmail.com>
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

On Wed, Sep 27, 2017 at 02:08:25PM -0700, anish kumar wrote:
> On Wed, Sep 27, 2017 at 3:11 AM, Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Tue, Sep 26, 2017 at 09:11:11PM -0700, yesanishhere@gmail.com wrote:
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
> 
> No, as this is getting freed in the common function.
> >

Apologies so it.

Thanks,
Charles
