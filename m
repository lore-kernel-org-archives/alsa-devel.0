From: Fabio Estevam <festevam@gmail.com>
Subject: Re: ASoC: Failed to create DAPM debugfs
Date: Thu, 9 Apr 2015 21:05:44 -0300
Message-ID: <CAOMZO5Bn6ZPD3h5n=b-eEbNBZvtwLV_o_MWNQYkAjSTHL+KO9w@mail.gmail.com>
References: <CAOMZO5DP4fahmC9W6eBFdjxR1DqPMgyhgwxwSZP_TcqxLSy=7A@mail.gmail.com>
 <55258272.2010205@metafoo.de>
 <CAOMZO5AxT9dgE=QaH18FUYD5CbMvn67XpMo4dH6T0v9Qen-RRg@mail.gmail.com>
 <55262C9D.5080005@metafoo.de> <20150409082246.GB62585@Asurada-CZ80>
 <55263873.108@metafoo.de> <20150409084509.GC62585@Asurada-CZ80>
 <55263E7C.9070501@metafoo.de> <20150409193659.GA9875@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com
 [209.85.217.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C512260532
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 02:05:45 +0200 (CEST)
Received: by lbbqq2 with SMTP id qq2so2084436lbb.3
 for <alsa-devel@alsa-project.org>; Thu, 09 Apr 2015 17:05:44 -0700 (PDT)
In-Reply-To: <20150409193659.GA9875@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 9, 2015 at 4:37 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Thu, Apr 09, 2015 at 10:55:24AM +0200, Lars-Peter Clausen wrote:
>> >But the snd_soc_dapm_debugfs_init() call that's going to access the
>> >card->debugfs_root was put before the snd_init_card_debugfs() at the
>> >first place....
>> >
>> >I'm not sure if this could be a fix but the warning is actually gone:
>>
>> There is more stuff that expects the directory to exist in
>> snd_soc_instantiate_card() so we need to move
>> soc_init_card_debugfs() further up. See the patch I just sent.
>
> Yea, I saw that. Thank you for the fix.

Thanks for the fix, Lars!
