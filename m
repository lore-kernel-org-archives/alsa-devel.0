From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Request for test (1.0.18 final)
Date: Tue, 28 Oct 2008 14:24:49 +0100
Message-ID: <490712A1.9070202@ladisch.de>
References: <Pine.LNX.4.61.0810271449320.12044@tm8103.perex-int.cz>	<4905F6EB.8080507@gmail.com>	<4906C822.7070807@ladisch.de>	<s5hr6615asc.wl%tiwai@suse.de>	<4906FD24.608@ladisch.de>
	<s5h63ndlyiu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6286D24467
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 14:24:54 +0100 (CET)
In-Reply-To: <s5h63ndlyiu.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > obj-$(CONFIG_SND_FM801_TEA575X) += snd-tea575x-tuner.o
>
> But this is already in alsa-kernel/i2c/other/Makefile.

Oops, you're right (I didn't actually test compiling with tea575x
enabled).  Your patch is fine.


Regards,
Clemens
