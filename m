From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-cache problem
Date: Fri, 15 Jan 2010 10:35:56 +0000
Message-ID: <20100115103556.GA28625@sirena.org.uk>
References: <da1989291001142312g24d66135n903f87983e733532@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 06C4924385
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 11:35:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <da1989291001142312g24d66135n903f87983e733532@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cliff Cai <cliffcai.sh@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 15, 2010 at 03:12:13PM +0800, Cliff Cai wrote:

> Nowadays, soc tries to  set up standard I/O functions with same
> addr_bits and data_bits for a codec.
> My problem is some codec might have registers with different data
> length.i.e.ADAU1761,
> Most of its registers are 8 bits long except PLL register,which is a 8
> bytes long one.In order to set/read PLL ,
>  a block of data(8 bytes) needs to be transfer to/from the PLL
> register  at a time.

> So, if soc-cache needs to consider this kind of case, or just keep it
> in local driver?

Just do it in the driver, the main point here is to factor out
boilerplate code so if you need to do non-standard things there's not
really much of a win.  Adding EXPORT_SYMBOL_GPL() to the I/O functions
(the _write() ones) to allow them to be called by your driver would be
OK and would allow you to reuse that code.
