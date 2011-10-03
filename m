From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: samsung: wm8994 depends on mfd_wm8994
Date: Mon, 3 Oct 2011 15:40:24 +0100
Message-ID: <20111003144023.GO3731@opensource.wolfsonmicro.com>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<11174515.ANsqIhx0NX@wuerfel>
	<20111003140824.GM3731@opensource.wolfsonmicro.com>
	<1373438.oHCphrxVRr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1373438.oHCphrxVRr@wuerfel>
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
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, 'Jassi Brar' <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, 'Liam Girdwood' <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 04:35:46PM +0200, Arnd Bergmann wrote:

> I'm still confused, I thought you had NAKed the patch that selects the
> core because it ignores the dependencies. Here comes another variant,
> this time for your branch, and selecting the MFD driver directly while
> respecting its dependencies.

The problem with that one was that you had the select on the Kconfig for
the CODEC driver rather than on the machine drivers so you ended up with
the select being done from a symbol that is itself selected.

Applied this version, thanks.
