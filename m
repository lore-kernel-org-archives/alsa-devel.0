From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fix pxa-ssp compiling issue
	under mach-mmp
Date: Tue, 22 May 2012 15:05:03 +0800
Message-ID: <CAN1soZwUW8XwpuCdHzXxhYmE_iuF428tNV+wVjfQXESNFyf35w@mail.gmail.com>
References: <1337669906-12745-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1337669906-12745-1-git-send-email-zhouqiao@marvell.com>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 22, 2012 at 2:58 PM, Qiao Zhou <zhouqiao@marvell.com> wrote:
> pxa-ssp.c uses API like cpu_is_pxa3xx(), cpu_is_pxa2xx(), which is
> defined under arch-pxa architecture, so to compile it under mach-mmp
> just add CONFIG_ARCH_PXA macro to separate it.
>
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
> ---
> =A0sound/soc/pxa/pxa-ssp.c | =A0 25 ++++++++++++++++++-------
> =A01 files changed, 18 insertions(+), 7 deletions(-)
>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Mark,
Do you mind that both of these two patches could apply into asoc git tree?

Regards
Haojian
