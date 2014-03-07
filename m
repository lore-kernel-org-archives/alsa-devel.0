From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: Controlling the cards order
Date: Thu, 06 Mar 2014 23:06:55 -0500
Message-ID: <1394165215.15237.25.camel@Wailaba2>
References: <1394127734.15237.20.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qproxy1-pub.mail.unifiedlayer.com
 (qproxy1-pub.mail.unifiedlayer.com [173.254.64.10])
 by alsa0.perex.cz (Postfix) with SMTP id AA1A326593D
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 05:07:05 +0100 (CET)
Received: from [173.179.63.169] (port=37777 helo=[192.168.1.150])
 by box610.bluehost.com with esmtpsa (SSLv3:RC4-SHA:128) (Exim 4.80)
 (envelope-from <olivier@trillion01.com>) id 1WLm3m-0000L8-K2
 for alsa-devel@alsa-project.org; Thu, 06 Mar 2014 21:06:58 -0700
In-Reply-To: <1394127734.15237.20.camel@Wailaba2>
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

On Thu, 2014-03-06 at 12:42 -0500, Olivier Langlois wrote:
> Hi,
> 
> I have added a second sound device in my system and it unexpectedly took
> the first card slot.
> 
> I have found that it is easy to control the order as long as the devices
> use different drivers by modifying
> 
> /etc/modprobe.d/alsa.conf
> 
> ( http://alsa.opensrc.org/MultipleCards )
> 
> but in my situation I have 2 different devices using the same driver. I
> think that there is hope that I find an answer by digging the more
> general topic of ordering PCI devices drivers loading but if someone has
> few pointers to share, any help is welcome!
> 
> Here are my 2 devices that I would like to change the order:
> 
> lano1106@whippet2 /proc/asound $ cat cards
>  0 [PCH            ]: HDA-Intel - HDA Intel PCH
>                       HDA Intel PCH at 0xfbf20000 irq 84
>  1 [HDMI           ]: HDA-Intel - HDA ATI HDMI
>                       HDA ATI HDMI at 0xfbe60000 irq 88

I love Linux for allowing almost anything imaginable!

in the kernel command line, I added the following:

1.

pci-stub.ids=1002:aaa0,8086:1d20

2.

Create a systemd service

/usr/lib/systemd/system/snd_hda_intel-bind.service:

[Unit]
Description=Binds PCI Audio devices to snd_hda_intel in the specified
order
After=syslog.target

[Service]
EnvironmentFile=-/etc/snd_hda_intel.cfg
Type=oneshot
RemainAfterExit=yes
ExecStart=-/usr/bin/snd_hda_intel-bind $DEVICES

[Install]
WantedBy=multi-user.target

3.

/etc/snd_hda_intel.cfg:

DEVICES="0000:01:00.1 0000:00:1b.0"

4.

/usr/bin/snd_hda_intel-bind:

#!/bin/bash

modprobe snd_hda_intel

for var in "$@"; do
	if [ -e /sys/bus/pci/devices/$var/driver ]; then
		echo $var > /sys/bus/pci/devices/$var/driver/unbind
	fi
	echo $var > /sys/bus/pci/drivers/snd_hda_intel/bind
done


Result:

lano1106@whippet2 /proc/asound :( $ cat cards 
 0 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xfbe60000 irq 87
 1 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xfbf20000 irq 88


tadam!
