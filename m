From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: [PATCH] add the nvidia HDMI codec driver
	for	MCP77/79
Date: Wed, 03 Sep 2008 14:11:16 +0200
Message-ID: <48BE7EE4.8020800@insite.cz>
References: <200809031558156739794@gmail.com>
	<s5hhc8xpq6z.wl%tiwai@suse.de>	<15F501D1A78BD343BE8F4D8DB854566B31F8F744@hkemmail01.nvidia.com>
	<s5h4p4xph6x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id ED38E245A4
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 08:32:58 +0200 (CEST)
In-Reply-To: <s5h4p4xph6x.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Peer Chen <pchen@nvidia.com>, Wei Ni <wni@nvidia.com>, alsa-devel <alsa-devel@alsa-project.org>, akpm <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


>> ......
>> According to these codes, It only can get the realtek codec and can not
>> get hdmi codec, if just change azx_max_codecs[AZX_DRIVER_NVIDIA] to 4
>> I think if remove "if (!audio_codecs)", it will be better, and I only
>> need to chang azx_max_codecs[AZX_DRIVER_NVIDIA] to 4
> 
> Well, the check is there for a good reason.
> 
> There are many machines with broken BIOS reporting the 4th slot
> available although it isn't actually.  It's a workaround to skip such
> a bogus information.  So, it cannot be changed so easily.
> 
> We need to sort out this in a better way...  Oh well.


Please, please, put the above information as a comment to the respective 
place. These "hacks" should be commented :)

Thanks a lot,

Pavel.
