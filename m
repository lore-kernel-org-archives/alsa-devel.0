From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [patch 0/4] ASoC: dapm: Avoid creating kcontrol
	for params
Date: Thu, 7 Sep 2017 16:52:02 -0700
Message-ID: <CABCoZhBv9Gx8V90eTr4za-hRLtpyZkkfpzscteXejmo6wsZOQw@mail.gmail.com>
References: <20170826082902.35422-1-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f193.google.com (mail-ua0-f193.google.com
 [209.85.217.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 42CE0266943
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 01:52:03 +0200 (CEST)
Received: by mail-ua0-f193.google.com with SMTP id l24so334129uaa.5
 for <alsa-devel@alsa-project.org>; Thu, 07 Sep 2017 16:52:03 -0700 (PDT)
In-Reply-To: <20170826082902.35422-1-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: anish kumar <yesanishhere@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Ping.......

On Sat, Aug 26, 2017 at 1:29 AM, anish kumar <yesanishhere@gmail.com> wrote:
> Currently in codec to codec dai link if there are multiple
> params defined then dapm can use created kcontrol to
> decide which param to apply at runtime.
>
> However, in case there is only single param configuration
> then there is no point in creating the kcontrol and also there
> is no point in allocating memory for kcontrol.
>
> In the snd_soc_dapm_new_pcm function, there is memory
> allocation happening for kcontrol which is later used
> or not used based on num_param. It is better to not
> allocate memory when there is only a single configuration.
> This change is to remedy that anomaly.
>
> This code change doesn't do much except just refactor
> snd_soc_dapm_new_pcm function. Now the part of allocating
> memory for kcontrol is allocated to a new function and it
> is called only in the case it is needed.
>
> anish kumar (4):
>   ASoC: dapm: fix error path in snd_soc_dapm_new_pcm

Below 3 patches are still not reviewed.

>   ASoC: dapm: Refactor the code in snd_soc_dapm_new_pcm
>   ASoC: dapm: Avoid creating kcontrol for params
>   ASoC: dapm: Remove the redundant check


>
>  sound/soc/soc-dapm.c | 123 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 67 insertions(+), 56 deletions(-)
>
> --
> 2.10.1 (Apple Git-78)
>
