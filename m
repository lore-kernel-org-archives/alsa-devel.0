From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [asoc:topic/wm9705 1/1]
 sound/soc/codecs/wm9705.c:330:18: error: implicit declaration of function
 'snd_soc_new_ac97_component'; did you mean 'snd_soc_new_ac97_codec'?
Date: Tue, 13 Feb 2018 10:48:33 +0800
Message-ID: <20180213024833.egm2gkucc7sutb2k@wfg-t540p.sh.intel.com>
References: <201802122255.cGsOCM1z%fengguang.wu@intel.com>
 <20180212144911.GD12976@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EE4C2673A1
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 03:48:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180212144911.GD12976@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Feb 12, 2018 at 02:49:11PM +0000, Mark Brown wrote:
>On Mon, Feb 12, 2018 at 10:19:57PM +0800, kbuild test robot wrote:
>
>>    sound/soc/codecs/wm9705.c: In function 'wm9705_soc_probe':
>> >> sound/soc/codecs/wm9705.c:330:18: error: implicit declaration of function 'snd_soc_new_ac97_component'; did you mean 'snd_soc_new_ac97_codec'? [-Werror=implicit-function-declaration]
>>       wm9705->ac97 = snd_soc_new_ac97_component(component, WM9705_VENDOR_ID,
>>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>                      snd_soc_new_ac97_codec
>
>I've dropped this and the other patch that had the same issue.
>I wonder why 0day didn't notice this on the list...

Sorry but all the robot can notice is when an error disappears
in the _same_ branch that introduced the error. It does not try to
understand comments in the mailing list. Internally, it associates
errors to git branches and commits. If a problematic patch is dropped
in branch A but still remains in branch B, we should probably still
report the issue in B? 

Thanks,
Fengguang
