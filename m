From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: RFC: reworking ASOC for large registers
Date: Mon, 21 Jul 2008 11:35:41 -0400
Message-ID: <9e4733910807210835m4321f6bet823a466cabd4ed1c@mail.gmail.com>
References: <9e4733910807201847q6d914e58l567a96904679ada8@mail.gmail.com>
	<20080721094828.GC7083@sirena.org.uk>
	<9e4733910807210551m7b4ac64qa111557d104c2993@mail.gmail.com>
	<20080721125444.GH7083@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 72A4F243B8
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 17:35:42 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so210768yxh.2
	for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2008 08:35:41 -0700 (PDT)
In-Reply-To: <20080721125444.GH7083@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

These signatures need to change a lot:

/* codec register bit access */
int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
				unsigned short mask, unsigned short value);
int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
				unsigned short mask, unsigned short value);


Something like:
int snd_soc_update_bits(struct snd_soc_codec *codec, uint reg,
				uint mask, uint shift, u64 value);

shift is needed to shift the mask around for huge registers like 256
bits. For existing hardware it will always be zero. value has to go to
u64.

-- 
Jon Smirl
jonsmirl@gmail.com
