From: Angelo Dureghello <angelo70@gmail.com>
Subject: davinci_soc_platform_register and davinci-pcm-audio
	question
Date: Wed, 15 Oct 2014 18:40:09 +0200
Message-ID: <543EA369.8070406@gmail.com>
References: <543EA2D7.8050704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <543EA2D7.8050704@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear all,

i am referring to this patch:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/116088.html

My board, based on am1808(da850) cpu and codec wolfson wm8758 (created 
based on wm8985.c)
using mcbsp with a custom soc machine is actually broken,

This moving from kernel 3.5.1 to 3.17.

Alsa card is loaded correctly, but i can hear no sound:

omap_rtc omap_rtc: setting system clock to 2014-10-15 15:46:57 UTC 
(1413388017)
ALSA device list:
   #0: barix-ipam390
UBIFS: background thread "ubifs_bgt0_0" started, PID 1071
UBIFS: recovery needed


In the patch, seems "davinci-pcm-audio" is no more a driver.
And i should use "davinci_soc_platform_register" to have the pcm helper 
available.

But i don't understand in where i have to call this function.

Every help is appreciated.

Reagrds
angelo




