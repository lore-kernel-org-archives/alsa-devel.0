From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 V3] ASoC: fix pxa-ssp compiling issue
	under mach-mmp
Date: Mon, 11 Jun 2012 03:44:42 +0100
Message-ID: <20120611024442.GC28211@opensource.wolfsonmicro.com>
References: <1338777664-2625-1-git-send-email-zhouqiao@marvell.com>
	<1338777664-2625-2-git-send-email-zhouqiao@marvell.com>
	<4FD54F64.9020204@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4FD54F64.9020204@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 11, 2012 at 09:52:36AM +0800, Qiao Zhou wrote:
> On 06/04/2012 10:41 AM, Qiao Zhou wrote:

Delete irrelevant quotes from your mails!  There's about 180 lines of
text here and only one line of new text buried right at the bttom.

> > pxa-ssp.c uses API like cpu_is_pxa3xx(), cpu_is_pxa2xx(), which is
> > defined under arch-pxa architecture, and drivers under mach-mmp

> do you have any suggestion/comment about the patch series?

I'm hoping that the arch/arm patch can can get reviewed...
