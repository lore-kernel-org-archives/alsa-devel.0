From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: Re: [PATCH v2 0/3] ASoC: fix unbalanced
	of_node_get()/of_node_put()
Date: Sun, 30 Jul 2017 22:34:12 +0200
Message-ID: <CAAj6DX1F3eg61_EfqAa3-OKpPhEwN-dTkcEjgzxGeTsoZX_k1A@mail.gmail.com>
References: <20170725214952.6491-1-borneo.antonio@gmail.com>
 <20170727232612.23543-1-antonio.borneo@st.com>
 <20170728100735.enwrl7whjkmnicd7@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 14FF8266CE1
 for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2017 22:34:13 +0200 (CEST)
Received: by mail-lf0-f68.google.com with SMTP id x16so13067359lfb.4
 for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2017 13:34:13 -0700 (PDT)
In-Reply-To: <20170728100735.enwrl7whjkmnicd7@sirena.org.uk>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei Xu <xuwei5@hisilicon.com>, Takashi Iwai <tiwai@suse.com>, John Stultz <john.stultz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 28, 2017 at 12:07 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 28, 2017 at 01:26:09AM +0200, Antonio Borneo wrote:
>> From: Antonio Borneo <borneo.antonio@gmail.com>
>>
>> On Hikey target board, enabling CONFIG_OF_DYNAMIC triggers several
>> errors at kernel boot, like
>> OF: ERROR: Bad of_node_put() on /soc/i2s@f7118000/ports/port@0
>> OF: ERROR: Bad of_node_put() on /soc/i2s@f7118000/ports/port@0/endpoint
>> each followed by stack dump.
>
> Please take a look at the patches that Tony Lindgren has posted in the
> past day for this issue which go into the of_graph API to make it less
> error prone.

Great, it fixes the issue!
Please drop this patchset, the issue is completely covered by Tony's work.

Best Regards
Antonio
