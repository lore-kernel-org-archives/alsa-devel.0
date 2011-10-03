From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
Date: Mon, 3 Oct 2011 16:20:02 +0100
Message-ID: <20111003152002.GP3731@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<20111003134527.GF11710@n2100.arm.linux.org.uk>
	<20111003143553.GG23811@sirena.org.uk> <1343003.MpQlxoEPa6@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1343003.MpQlxoEPa6@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Dmitry Artamonow <mad_soft@inbox.ru>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 04:47:07PM +0200, Arnd Bergmann wrote:

> sound/soc/codecs/wm1250-ev1.c:32:14: error: array type has incomplete element type

OK, that's the gpio_request_ stuff not being implemented thing that I
have seen some reports of.  Looks like that's not been stubbed out, but
for Prima2 the best fix is just to turn on gpiolib since there's no
excuse for a new platform to not use it.
