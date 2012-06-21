From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2 0/5] mmp audio support
Date: Thu, 21 Jun 2012 11:01:21 +0800
Message-ID: <CAMj5Bkh=BOBi+SeKYvE4hZsO1hWUD9OQSz-_g=a1c-Scgxfu6g@mail.gmail.com>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
	<87y5nrw4ko.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <87y5nrw4ko.fsf@octavius.laptop.org>
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
Cc: linux-arm-kernel@lists.infradead.org, Eric Miao <eric.y.miao@gmail.com>, Saadia Baloch <saadia@laptop.org>, Leo Yan <leoy@marvell.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lrg@ti.com>, Qiao Zhou <zhouqiao@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, alsa-devel@vger.kernel.org, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 14, 2012 at 12:37 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Zhangfei,
>
> On Mon, Jun 11 2012, Zhangfei Gao wrote:
>> v1->v2:
>> modify accroingly with suggestion from Vinod and Mark
>> remove deprecated chan->private and dma.h
>> remove prep_slave_sg
>> remove module_init and move operation to probe
>> misc change
>>
>> v0->v1:
>> dmaengine -> soc-dmaengine.
>> update according to Mark's suggestion
>>
>> These patches provide mmp audio support under alsa via dmaengine
>> Support platfrom pxa688 and pxa910
>> mmp_tdma.c and mmp-pcm.c is shared for pxa688 and pxa910
>> pxa688 (mmp2) use mmp2-sspa.c
>> pxa910 directly use pxa-ssp.c
>> mmp_tdma.c is under dmaengine framework
>>
>> Verified on brownstone (pxa688) and ttc-dkb
>
> Great, we're looking into adopting this for OLPC XO-1.75 too.
>
> Could you explain how system suspend/resume should work with this
> patchset? =A0You don't seem to be adding any suspend/resume handlers.
>
> Thanks,
>
> - Chris.

Chris

Some confusion about audio suspend.
We use android environment, wake lock is hold preventing system
entering suspend when audio work.
Only entering early-suspend, which close LCD etc.
If this is the case, we may not need consider suspend during audio play bac=
k.

If support suspend during audio work, some modification required.
I found SNDRV_PCM_TRIGGER_START/STOP is send in suspend/resume
instead of SNDRV_PCM_TRIGGER_RESUME/SUSPEND as before.
The result is dmaengine_pcm_prepare_and_submit will be re-called every
suspend/resume.
Unfortunately we malloc descriptor in prep function, but no function
to free at such case.

Thanks
