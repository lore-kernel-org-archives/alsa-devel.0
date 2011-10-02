From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
Date: Sun, 2 Oct 2011 21:41:07 +0100
Message-ID: <20111002204106.GB5811@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1317587284-2776-3-git-send-email-arnd@arndb.de>
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
Cc: alsa-devel@alsa-project.org, Dmitry Artamonow <mad_soft@inbox.ru>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 02, 2011 at 10:28:00PM +0200, Arnd Bergmann wrote:
> This driver only builds correctly on platforms that use
> GPIOLIB. Disable it otherwise.

No, gpiolib is one implementation of the GPIO API but if platforms want
to go and define their own that's currently OK (personally I think at
this point we should just be converting all the stragglers over to
gpiolib).  As things stand we shouldn't have dependencies on a
particular implementation of the API.
