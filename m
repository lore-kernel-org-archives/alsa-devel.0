From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.37
Date: Wed, 06 Oct 2010 15:29:48 +0100
Message-ID: <1286375388.9697.31.camel@dplaptop>
References: <20101005191359.GA23315@opensource.wolfsonmicro.com>
	<s5h4ocz6doz.wl%tiwai@suse.de> <20101006063401.GB17998@sirena.org.uk>
	<s5hzkur4x0g.wl%tiwai@suse.de> <20101006073104.GC17998@sirena.org.uk>
	<1286357140.9697.17.camel@dplaptop> <s5hpqvnla7s.wl%tiwai@suse.de>
	<1286372404.9697.22.camel@dplaptop> <s5hiq1fl9i8.wl%tiwai@suse.de>
	<1286374422.9697.28.camel@dplaptop>  <s5h8w2bl7ql.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B4E8103839
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 16:29:50 +0200 (CEST)
In-Reply-To: <s5h8w2bl7ql.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Barry Song <Barry.Song@analog.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-10-06 at 16:24 +0200, Takashi Iwai wrote:
> At Wed, 06 Oct 2010 15:13:42 +0100,
> Dimitris Papastamos wrote:
> > 
> > On Wed, 2010-10-06 at 15:46 +0200, Takashi Iwai wrote:
> > > At Wed, 06 Oct 2010 14:40:04 +0100,
> > > Dimitris Papastamos wrote:
> > > > 
> > > > On Wed, 2010-10-06 at 15:30 +0200, Takashi Iwai wrote:
> > > > > At Wed, 06 Oct 2010 10:25:40 +0100,
> > > > > Dimitris Papastamos wrote:
> > > > > > 
> > > > > > On Wed, 2010-10-06 at 08:31 +0100, Mark Brown wrote:
> > > > > > On Wed, Oct 06, 2010 at 09:10:23AM +0200, Takashi Iwai wrote:
> > > > > > > 
> > > > > > > > If the above difference is intentional, it should be commented
> > > > > > > > somewhere.
> > > > > > > 
> > > > > > > Meh, yes.  Dimitris, please fix or add a comment as appropriate.
> > > > > > > 
> > > > > > 
> > > > > > In snd_soc_7_9_spi_write we prepare the tx buffer to be register
> > > > > > followed by data packed into 16 bits.  In snd_soc_4_12_spi_write the tx
> > > > > > buffer is swapped.  I'd expect this to be consistent between the two
> > > > > > transfers.
> > > > > 
> > > > > Sorry, I don't understand your statement clearly.
> > > > > So, the byte-swap behavior in snd_soc_4_12_spi_write() is designed?
> > > > 
> > > > I meant to say that snd_soc_4_12_spi_write looks suspicious and that I'd
> > > > expect it to behave similarly to snd_soc_7_9_spi_write.  I don't see why
> > > > the byte swapping is needed.
> > > 
> > > OK, thanks for clarifying :)
> > > 
> > > Looking through git commits, this was introduced by a patch from Barry
> > > Song.  Barry, could you check whether the current code is correct?
> > > 
> > > I guess this is because the original code accessed unsigned short
> > > while the new code is converted to a byte array.  Maybe due to the
> > > endianess, but it looks wrong.
> > 
> > Looking at the commit now, I think his changes are consistent.  Consider
> > an example with reg = 0xf and value = 0xa, then his original unsigned
> > short buf is equal to 0xf00a.  If you follow the logic in
> > snd_soc_4_12_write you will find that data[0] and data[1] are 0xf0 and
> > 0x0a respectively.  However on a say LE machine, his original buf is
> > laid out in mem as 0af0 whereas the data buffer is laid out as f00a so
> > he has to reverse that by swapping it in snd_soc_4_12_spi_write.
> 
> Yeah, I don't say it's buggy.  But it's wrong from a programming POV.
> The proper endianess handling seems missing in the current code...

Yup, I will wait for Mark to see what he has to comment on this and then
I will make the required changes.

Thanks,
Dimitrios
