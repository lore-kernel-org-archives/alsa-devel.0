From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: snd-intel-hda: screaming IRQ with 3.5.3 kernel
	(HDMI)
Date: Mon, 10 Sep 2012 12:58:23 -0700 (PDT)
Message-ID: <1347307103.57319.YahooMailNeo@web120304.mail.ne1.yahoo.com>
References: <504B4F2D.40002@yahoo.com> <s5hligitcd0.wl%tiwai@suse.de>
 <1347272938.6237.YahooMailNeo@web120301.mail.ne1.yahoo.com>
 <s5hfw6qtbhq.wl%tiwai@suse.de>
Reply-To: Chris Rankin <rankincj@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm37-vm7.bullet.mail.ne1.yahoo.com
 (nm37-vm7.bullet.mail.ne1.yahoo.com [98.138.229.135])
 by alsa0.perex.cz (Postfix) with SMTP id CF7A52602DC
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 21:58:24 +0200 (CEST)
In-Reply-To: <s5hfw6qtbhq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

----- Original Message -----
> Did you try any workaround boot options such as irqpoll, pci=nocrs or whatever?


OK, the "irqpoll=1" option does help here. Although this message is obviously scary:

Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance


And the "pci=nocrs" option does Really Bad Things to the display at boot-time.

So what is "irqpoll" actually doing, please? Is it just a temporary workaround for a driver bug?

Thanks,
Chris
