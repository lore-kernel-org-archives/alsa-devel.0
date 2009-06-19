From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Why analog loopback of sigmatel devices got
 removed?
Date: Sat, 20 Jun 2009 00:05:01 +0300
Message-ID: <1245445501.5475.3.camel@localhost>
References: <1245369035.6830.27.camel@localhost>
	<s5h1vpgg2d6.wl%tiwai@suse.de> <1245435529.5573.1.camel@localhost>
	<s5h3a9wrrln.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id AEFAB24677
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 23:05:06 +0200 (CEST)
Received: by fxm26 with SMTP id 26so1404067fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 14:05:05 -0700 (PDT)
In-Reply-To: <s5h3a9wrrln.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-06-19 at 20:44 +0200, Takashi Iwai wrote:
> At Fri, 19 Jun 2009 21:18:49 +0300,
> Maxim Levitsky wrote:
> > 
> > On Fri, 2009-06-19 at 08:32 +0200, Takashi Iwai wrote:
> > > echo "loopback yes" > /sys/class/sound/hwC0D0/hints
> > 
> > 
> > This is unmerged  feature?
> > 
> > root@MAIN:/home/maxim# cat /sys/class/sound/hwC0D2/
> > dev        device/    power/     subsystem/ uevent     
> > 
> > 
> > I use -git of the kernel
> 
> Set CONFIG_SND_HDA_RECONFIG=y.
> 
> 
> Takashi

Ok, I see it now, but  then I put these commands in /etc/rc.local



echo  "loopback=yes" > /sys/class/sound/hwC0D2/hints
echo 1 > /sys/class/sound/hwC0D2/reconfig


and I get this, and almost empty mixer


[   57.353168] hda-codec: reconfiguring
[   57.426105] stac92xx_auto_fill_dac_nids: No available DAC for pin 0xd
[   59.121418] e1000e 0000:00:19.0: irq 29 for MSI/MSI-X
[   59.172115] e1000e 0000:00:19.0: irq 29 for MSI/MSI-X
[   60.585005] e1000e: eth0 NIC Link is Up 100 Mbps Full Duplex, Flow
Control: RX/TX
[   60.585011] 0000:00:19.0: eth0: 10/100 speed: disabling TSO



I had to reload the driver and apply the above commands to make it and
loopback work...


Why? It all did work fine before.


Regards,
	Maxim Levitsky
