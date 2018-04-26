From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 8/8] ALSA: add new 32-bit layout for
	snd_pcm_mmap_status/control
Date: Thu, 26 Apr 2018 13:31:17 +0200
Message-ID: <CAK8P3a19Nst2UwZart_kzbT6iJD+D9RPMpq_yAzgumjNtxFNGg@mail.gmail.com>
References: <e7d7ed852943b5a35c5d494071f522465620371b.1524570852.git.baolin.wang@linaro.org>
 <201804261905.bMSzVUh7%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 95E8626722C
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 13:31:19 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id w12-v6so30945481qti.4
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 04:31:19 -0700 (PDT)
In-Reply-To: <201804261905.bMSzVUh7%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <lkp@intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jeeja.kp@intel.com, SF Markus Elfring <elfring@users.sourceforge.net>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Ingo Molnar <mingo@kernel.org>, gudishax.kranthikumar@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>, subhransu.s.prusty@intel.com, Dan Carpenter <dan.carpenter@oracle.com>, hardik.t.shah@intel.com, Fabian Frederick <fabf@skynet.be>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Baolin Wang <baolin.wang@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, kbuild-all@01.org, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 1:25 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Arnd,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on v4.17-rc2]
> [cannot apply to sound/for-next asoc/for-next arm-soc/for-next next-20180426]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Fix-year-2038-issue-for-sound-subsystem/20180426-010145
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>    sound/firewire/motu/motu-pcm.c:35:29: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:35:29: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:36:29: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:36:29: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:65:32: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:65:32: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:66:32: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:66:32: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:92:36: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:92:36: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:93:36: sparse: expression using sizeof(void)
>    sound/firewire/motu/motu-pcm.c:93:36: sparse: expression using sizeof(void)
>>> sound/firewire/motu/motu-pcm.c:204:50: sparse: restricted snd_pcm_state_t degrades to integer
>    sound/firewire/motu/motu-pcm.c:223:50: sparse: restricted snd_pcm_state_t degrades to integer
>    sound/firewire/motu/motu-pcm.c:238:50: sparse: restricted snd_pcm_state_t degrades to integer
>    sound/firewire/motu/motu-pcm.c:254:50: sparse: restricted snd_pcm_state_t degrades to integer

>From what I can tell, these are all existing driver problems, no idea why we now
have one more warning than before.

       Arnd
