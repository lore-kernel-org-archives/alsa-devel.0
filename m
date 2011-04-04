From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for April 4 (sound/soc)
Date: Mon, 4 Apr 2011 08:37:47 -0700
Message-ID: <20110404083747.34ed1398.randy.dunlap@oracle.com>
References: <20110404143546.e2bb3379.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110404143546.e2bb3379.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Apr 2011 14:35:46 +1000 Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20110401:


When CONFIG_SPI=n, CONFIG_I2C=n:

sound/soc/soc-cache.c:418: error: implicit declaration of function 'i2c_master_send'
sound/soc/soc-cache.c:421: error: implicit declaration of function 'do_spi_write'

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
