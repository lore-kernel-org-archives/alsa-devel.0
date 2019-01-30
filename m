From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: pcm512x: Implement the
	set_bclk_ratio interface
Date: Wed, 30 Jan 2019 17:01:52 +0200
Message-ID: <3e55222b-a672-0fcb-28c2-52566ae48a16@gmail.com>
References: <9b758d09-9b9b-77a1-6651-43755c67e6fd@gmail.com>
 <c20a4737-ab29-11e7-7780-4782463eb2cf@axentia.se>
 <bed2d410-1b67-c2e1-dd9b-3877917fef43@gmail.com>
 <20190128121053.GB11699@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E2E2267439
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 16:01:56 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id p6so21868168wmc.1
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 07:01:56 -0800 (PST)
In-Reply-To: <20190128121053.GB11699@sirena.org.uk>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Matthias Reichl <hias@horus.com>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

Many thanks for reviewing (and applying) this Mark and equally
many thanks to everyone who took the time to provide feedback!

On 1/28/19 2:10 PM, Mark Brown wrote:
> On Sat, Jan 26, 2019 at 09:00:09PM +0200, Dimitris Papavasiliou wrote:
>> On 1/26/19 8:48 PM, Peter Rosin wrote:
> 
>>> ratio == 0 should also generate -EINVAL.
> 
>> Sorry, I forgot to mention in the notes, that I allowed setting a
>> zero ratio on purpose, in order to allow "unsetting" the bclk
>> ratio (since it only takes effect if it is positive).  I'm not
>> sure if it will ever be necessary to do that in practice, but I
>> thought I'd allow it, since it has a valid effect.
> 
> This is fairly idiomatic for ASoC FWIW.
> 
