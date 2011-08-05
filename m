From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Fri, 5 Aug 2011 07:34:14 +0100
Message-ID: <20110805063414.GB20809@opensource.wolfsonmicro.com>
References: <CAHG8p1AsKZdVvTj-ydWhDCEKjJcx9Q82srEOVZS45Q5J486YBw@mail.gmail.com>
	<20110804103558.GA25976@opensource.wolfsonmicro.com>
	<CAHG8p1AeeqL+Cj-4V4NwQpD33H4ogV0rfekHjMqfvG7wQ49fCA@mail.gmail.com>
	<20110805054210.GB16956@opensource.wolfsonmicro.com>
	<CAHG8p1AkbrfX3dkLw=MNf24V3peMB33z-vLdVyzRxvGmSNTWSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 18138103984
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Aug 2011 08:34:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHG8p1AkbrfX3dkLw=MNf24V3peMB33z-vLdVyzRxvGmSNTWSg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 05, 2011 at 02:26:33PM +0800, Scott Jiang wrote:

> My register address is 0x806(8bit global addr + 8bit reg addr), for
> example,  reg_cache_size is 0x20.
> snd_soc_cache_write will not be called. And kernel oops in do_hw_read

> BUG_ON(!codec->hw_read);

> That is what I found when asoc was upgraded to 3.0, my codec is ad1938.

> The key issue is register is 8 bits, hardware needs 16 bits addr. If I
> change reg_cache_size to 2^16=64K, I think everything goes well.
> But it will waste a lot of memory for only 32 registers.

Oh, this is just fail.  Does the hardware have readback support?
