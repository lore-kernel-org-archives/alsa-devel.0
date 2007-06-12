From: Timur Tabi <timur@freescale.com>
Subject: Re: Trouble understanding ALSA's DMA buffers
Date: Tue, 12 Jun 2007 11:36:33 -0500
Message-ID: <466ECB91.2030609@freescale.com>
References: <466DA941.40309@freescale.com>	<8d6898730706111329y666c7abdv5b464cbe4e9bb3b@mail.gmail.com>
	<s5hsl8xv4qz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id A3CCC1037F7
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 18:36:38 +0200 (CEST)
In-Reply-To: <s5hsl8xv4qz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Nobin Mathew <nobin.mathew@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Yes.  And the "ping-poing" is the case that you have two periods in a
> ring buffer.

Ok, I understand the 'periods' concept now, thanks.

So when/where does ALSA copy data to the DMA buffer?  Isn't there supposed to be some kind 
of callback where ALSA calls the driver and says, "here's some data, please copy it to 
your DMA buffer?"

Or does ALSA do all the copying itself whenever the driver calls snd_pcm_period_elapsed()?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
