From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH 5/6] ASoC: samsung: fix Kconfig dependencies
Date: Mon, 03 Oct 2011 13:50:08 +0200
Message-ID: <1869072.QQLATNzYYx@wuerfel>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<3289863.m6ULFZUV3p@wuerfel> <004e01cc8198$848347f0$8d89d7d0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <004e01cc8198$848347f0$8d89d7d0$@com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, Sangbeom Kim <sbkim73@samsung.com>, 'Jassi Brar' <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 03 October 2011 15:48:54 Sangbeom Kim wrote:
> On Mon, Oct 03, 2011 at 6:15:03AM , Arnd Bergmann wrote:
> > It's a bug that I only observed on exynos4, and it could be that
> > this patch didn't actually solve it in the end. I'll drop it for
> > now and do a better report when the problem comes back.
> 
> Could you please explain problem which observed on exynos4?
> If possible, I want to check it too.

Sorry, I can't reproduce it any more. It could have been something
unrelated like a Kconfig or toolchain problem that got fixed in
the meantime. I really should have dropped that one hunk from
the patch. The other problem in this patch is still there, with
CONFIG_SND_SOC_SMDK_WM8994_PCM=y and CONFIG_MFD_WM8994=n:

sound/built-in.o: In function `wm8994_resume':
last.c:(.text+0x1f600): undefined reference to `wm8994_reg_read'
sound/built-in.o: In function `wm8994_read':
last.c:(.text+0x20160): undefined reference to `wm8994_reg_read'
sound/built-in.o: In function `wm8994_codec_probe':
last.c:(.text+0x2029c): undefined reference to `wm8994_reg_read'
last.c:(.text+0x20480): undefined reference to `wm8994_reg_read'
last.c:(.text+0x204b4): undefined reference to `wm8994_reg_read'
sound/built-in.o: In function `wm8994_write':
last.c:(.text+0x20e68): undefined reference to `wm8994_reg_write'
last.c:(.text+0x20ea4): undefined reference to `wm8994_reg_write'
sound/built-in.o: In function `wm8958_dsp2_fw':
last.c:(.text+0x2159c): undefined reference to `wm8994_bulk_write'

	Arnd
