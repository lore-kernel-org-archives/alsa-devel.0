From: Bernhard Walle <bernhard@bwalle.de>
Subject: Re: [ice1712] Word Clock with Delta1010 E
Date: Fri, 21 May 2010 10:49:36 +0200
Message-ID: <20100521104936.88721rli64qamrz4@webmail.df.eu>
References: <4BF43556.3050505@bwalle.de> <s5hbpca4lrt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de
	[80.67.29.7]) by alsa0.perex.cz (Postfix) with ESMTP id 4602D103915
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 10:49:37 +0200 (CEST)
In-Reply-To: <s5hbpca4lrt.wl%tiwai@suse.de>
Content-Disposition: inline
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

Hi,

Zitat von Takashi Iwai <tiwai@suse.de>:
>
> Is register 0x01 set with bit 0x10 (aka SPDIF input-clock-master)?
> I haven't touched this driver for a very long time, so I'm not sure
> whether envy24control changed this bit automatically with word sync
> setup...

Yes, it's set. envy24control changes the mixer settings, but I added a

	spin_lock_irq(&ice->reg_lock);
	bval = inb(ice->profi_port + 0x01);
	spin_unlock_irq(&ice->reg_lock);
	snd_printk(KERN_WARNING "Register 0x01 has a value of 0x%x\n",
                    (unsigned int)bval);

to check. Any other ideas?


Regards,
Bernhard
