From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] ARM: kirkwood: extend the kirkwood
	i2s	driver for DT usage
Date: Tue, 23 Jul 2013 14:50:00 +0100
Message-ID: <20130723135000.GW24642@n2100.arm.linux.org.uk>
References: <20130723104615.3696f1a9@armhf>
 <20130723123444.GW9858@sirena.org.uk> <51EE7E1A.3040301@gmail.com>
 <20130723132016.GC9858@sirena.org.uk> <51EE8591.7060005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 3E5E826508B
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 15:50:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51EE8591.7060005@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Liam Girdwood <lgirdwood@gmail.com>, devicetree-discuss@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2013 at 03:30:57PM +0200, Sebastian Hesselbarth wrote:
> On 07/23/13 15:20, Mark Brown wrote:
>>> again, we mentioned to merge kirkwood-i2s.c and kirkwood-dma.c into
>>> a single file, didn't we?
>>
>> That's been discussed several times but nobody's actually done it.
>
> Correct, that is why I repeated that request to Jean-Francois.

On that, I have some initial patches which start doing that, but I've
not had time to really complete the effort - the problem is working
with one tree (mainline) while testing on Rabeeh's kernel tree to get
a fully working Cubox platform is quite a hinderance.

Not only that, but the lack of assistance from ASoC people on the
multiple substream stuff really doesn't help one iota when it comes to
making forward progress with SPDIF support.  I've explained to them the
problem (SPDIF and I2S if used together must be enabled simultaneously
or only one is permitted at any one time); they've suggested using the
multiple PCM substream support, and then it's a case that "oh it's
undocumented" "oh there's no examples yet".

And then there's the problem of understanding the ASoC DAPM stuff
"oh it's just a graph walk, you don't need to know the internals"
is what I get from ASoC people.  Well, yes I do need to know the
internals, so I can find out whether it's going to startup a second
substream while a first one is active, and end up with SPDIF enabled
non-concurrently with I2S.
