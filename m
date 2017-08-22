From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v5 2/9] ASoC: soc-core: Allow searching dai
 driver name in snd_soc_find_dai
Date: Tue, 22 Aug 2017 22:39:06 +0800
Message-ID: <599C420A.80601@rock-chips.com>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
 <20170822075729.8438-3-jeffy.chen@rock-chips.com>
 <CAErzpmtbbWbt28KPaFLVdwzuWy3A7se7_WBN8q6aJrHLbtT-LQ@mail.gmail.com>
 <20170822140255.t2wfwkjr67v3eoxu@sirena.org.uk>
 <CAErzpmsg9fi0-ukHG13-dy2r02892h+oPXmtsusCbu-xLzazFQ@mail.gmail.com>
 <20170822142111.zlosryhkyi75htod@sirena.org.uk>
 <s5h8tib8yq4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 080C6266812
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 16:39:20 +0200 (CEST)
In-Reply-To: <s5h8tib8yq4.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, lars@metafoo.de, linux-kernel@vger.kernel.org, briannorris@chromium.org, dianders@chromium.org, Donglin Peng <dolinux.peng@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, mka@chromium.org, dgreid@chromium.org, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

Hi guys,

On 08/22/2017 10:26 PM, Takashi Iwai wrote:
> On Tue, 22 Aug 2017 16:21:11 +0200,
> Mark Brown wrote:
>>
>> On Tue, Aug 22, 2017 at 10:15:32PM +0800, Donglin Peng wrote:
>>> On Tue, Aug 22, 2017 at 10:02 PM, Mark Brown <broonie@kernel.org> wrote:
>>
>>>> We should be already verifying that drivers have a name, we assume one
>>>> elsewhere.
>>
>>> But I can't find any codes that set or check dai_driver->name in
>>> function snd_soc_register_codec or snd_soc_register_component.
>>
>> We should fix that then.
>
> Hmm, as far as I read the code, the NULL dai driver name is valid for
> a single component.  The dai name is determined by fmt_single_name().
>
>
> Takashi
>
>
sorry, i though that is checked too... new patch is coming, thanks for 
noticing :)
>
