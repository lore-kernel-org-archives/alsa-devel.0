From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] Fix codec_dai->ops NULL pointer bug for
	AC97 codec dai in soc-core
Date: Fri, 16 Oct 2009 17:14:31 +0800
Message-ID: <3c17e3570910160214q18e99bd0y932b800a0c4f9fca@mail.gmail.com>
References: <1255658960-20693-1-git-send-email-21cnbao@gmail.com>
	<20091016090840.GI884@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f194.google.com (mail-px0-f194.google.com
	[209.85.216.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A85E10382F
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Oct 2009 11:14:53 +0200 (CEST)
Received: by pxi32 with SMTP id 32so1412853pxi.16
	for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2009 02:14:51 -0700 (PDT)
In-Reply-To: <20091016090840.GI884@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 16, 2009 at 5:08 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Oct 16, 2009 at 10:09:20AM +0800, Barry Song wrote:
>> AC97 codec DAIs don't register themselves eg.stac9766, wm9712, wm9713, wm9705.c, ad1980,
>> then it loses to the chance to be given a null_dai_ops in snd_soc_register_dai if they
>> have no ops. When functions like soc_pcm_open, soc_pcm_hw_params etc. access the ops field
>> in these DAIs, panic will happen.
>
> This is the wrong fix - null DAI ops are supposed to be supported for
> all devices since not all DAIs will be configurable.
But the problem is ac97 DAIs will have no path to get the null ops.
Then many functions will panic. It's very easy to repeat the problem
in your site, only by deleting ops field in any AC97 codec DAI.
>
