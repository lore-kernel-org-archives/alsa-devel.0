From: Tim Gardner <tim.gardner@canonical.com>
Subject: Re: No sound on Intel DQ965GF motherboard
Date: Fri, 16 Nov 2007 10:47:15 -0700
Message-ID: <473DD7A3.5070504@canonical.com>
References: <20071116061042.C5E9D830734@snark.thyrsus.com>	<s5hwssibvkp.wl%tiwai@suse.de>
	<20071116152117.GA14292@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tpi.com (mail.tpi.com [198.107.51.143])
	by alsa0.perex.cz (Postfix) with ESMTP id F260D2446A
	for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2007 18:47:34 +0100 (CET)
In-Reply-To: <20071116152117.GA14292@thyrsus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: esr@thyrsus.com
Cc: Takashi Iwai <tiwai@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eric S. Raymond wrote:
> Takashi Iwai <tiwai@suse.de>:
>> If you're using 2.6.24-rc* kernel (or did 1.0.15 backports), make sure
>> that you enabled all CONFIG_SND_HDA_CODEC_* configs.  Some people tend
>> to reduce options as much as possible although they are suggested as
>> default=y.
> 
> I'm using 2.6.22, which is the level of the stock Ubuntu 7.10 kernel.
> It has only one config symbol matching SND_HDA: CONFIG_SND_HDA_INTEL.
> I rebuilt the snd_hda_module from those sources.

I'm working on getting linux-backports-modules-2.6.22_2.6.22-14.11
uploaded today which will update your Ubuntu 7.10 ALSA drivers to
1.0.15. Look for it to appear in the repo sometime over the weekend (if
all goes well).

-- 
Tim Gardner tim.gardner@ubuntu.com
