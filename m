From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: davinci-mcasp: Use
	'snd_pcm_format_t' type
Date: Wed, 9 May 2018 11:14:54 -0300
Message-ID: <CAOMZO5AB-Bc3PmrRFEHGF90XFa9112Y1j+UEVTGf7_C5ScX76w@mail.gmail.com>
References: <1525621665-11022-1-git-send-email-festevam@gmail.com>
 <1525621665-11022-2-git-send-email-festevam@gmail.com>
 <20180509083412.GT13402@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 95BDD267716
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 19:06:25 +0200 (CEST)
Received: by mail-oi0-f42.google.com with SMTP id v2-v6so32151850oif.3
 for <alsa-devel@alsa-project.org>; Wed, 09 May 2018 10:06:25 -0700 (PDT)
In-Reply-To: <20180509083412.GT13402@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, May 9, 2018 at 5:34 AM, Mark Brown <broonie@kernel.org> wrote:
> On Sun, May 06, 2018 at 12:47:44PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> 'snd_pcm_format_t' type is better suited for iterating through the
>> SNDRV_PCM_FORMAT members.
>>
>> Also, use SNDRV_PCM_FORMAT_FIRST for the first element.
>
> Adding Peter.

Please ignore this series for now.

kbuild reported issues with it and I will investigate.

Thanks
