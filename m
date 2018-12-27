From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] aplay: support no period wakeup option in
	argument
Date: Thu, 27 Dec 2018 20:58:01 +0900
Message-ID: <20181227115801.GA15692@workstation>
References: <1545823678-15563-1-git-send-email-shengjiu.wang@nxp.com>
 <20181226133517.GA25888@workstation>
 <VI1PR0402MB339296BEB0F8566BBD97D1FAE3B60@VI1PR0402MB3392.eurprd04.prod.outlook.com>
 <20181227042835.GA5399@workstation>
 <AM0PR0402MB3379A907F2E41F7DC17A1E5AE3B60@AM0PR0402MB3379.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A38502679EF
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2018 12:58:10 +0100 (CET)
Received: by mail-pg1-f193.google.com with SMTP id s198so8736358pgs.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2018 03:58:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AM0PR0402MB3379A907F2E41F7DC17A1E5AE3B60@AM0PR0402MB3379.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Dec 27, 2018 at 06:46:57AM +0000, S.j. Wang wrote:
> I still have two questions:
> 1. It seems the no-period-wakeup feature should be dropped for it isn't recommended
>    By alsa, right?  I still found some driver in kernel support it, what's the reason?
 
You can see the driver supports 'period-wakeup' runtime as well as
'no-period-wakeup' runtime. The driver likely includes a condition
statement to check 'struct snd_pcm_runtime.no_period_wakeup' flag,
then it switches own behaviour for both cases.

Please keep it in your mind that 'period-wakeup' runtime is a
default. At present, there's no way for drivers to tell userspace
applications that 'period-wakeup' runtime is not supported.

> 2. Shall we add this option in aplay for it is feature that alsa support, even it is optional?

Initially 'no-period-wakeup' runtime was introduced to achieve
timer-based scheduling model[1]. Current design of aplay is not
suitable to this model in many points (e.g. value of timeout
argument in each call of poll(2) system call). If adopting
aplay to the model, heavy refactoring is required. For this
reason, I'm not positive to your idea. It's not practical.

However, just configuring hardware parameter with 'no-period-wakeup'
flag, it's possible, as you posted. In this case, you misses some
issues. At least:
 - alsa-lib configures the flag just for non-blocking operation.
 - alsa-lib calls poll(2) without timeout in many parts. When
   configuring the flag to PCM runtime, no tasks and IRQ contexts
   awaken the sleep process. Therefore processing of PCM frame is
   blocked forever in some cases.

(A call of 'snd_pcm_sw_params_set_period_event()' expects 'hw' PCM
plugin in alsa-lib to use ALSA timer interface for 'emulated'
periodical wakeup, however an instance of timer is for the PCM
runtime with 'no-period-wakeup' thus it can't awakens the sleep
process. I think this is a bug in alsa-lib.)

[1] http://0pointer.de/blog/projects/pulse-glitch-free.html
[2] https://github.com/alsa-project/alsa-utils/blob/master/axfer/xfer-libasound-timer-mmap.c#L22


Thanks

Takashi Sakamoto
