From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] cleanup controllers in snd-usb-caiaq
Date: Wed, 26 Nov 2008 21:31:59 +0100
Message-ID: <4F8A1F19-C8D2-4DEF-BD2B-D00E39631A8E@caiaq.org>
References: <20081126151901.GB20061@buzzloop.caiaq.de>
	<s5habbmqypj.wl%tiwai@suse.de>
	<20081126185720.GA22925@buzzloop.caiaq.de>
	<s5hbpw2cjvx.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 936412433A
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 21:32:09 +0100 (CET)
In-Reply-To: <s5hbpw2cjvx.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 26.11.2008, at 21:28, Takashi Iwai wrote:

>> Ok, agreed and done. However, I considered it a good idea as it  
>> avoided
>> writing the array's name more than once.
>
> In that case, you can use a macro, such as,
>
> #define ADD_CTRLS(c, list) add_controls(c, ARRAY_SIZE(list), (list))
>
> But, don't make a too complex block as a macro.  A function often
> gives a better code (in this case it'll get smaller) in addition to a
> better readability than a big macro.

Ok. Do you want me to do this or are you fine with the code as-is?

Daniel
