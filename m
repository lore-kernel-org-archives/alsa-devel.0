From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA-SOC support for OpenRD Client/Ultimate
Date: Fri, 12 Nov 2010 16:51:05 +0000
Message-ID: <20101112165105.GE28804@sirena.org.uk>
References: <4CDB9122.20706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BC3E103970
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 17:51:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CDB9122.20706@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Robas, Teodor" <teodor.robas@gmail.com>
Cc: alsa-devel@alsa-project.org, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 11, 2010 at 08:45:54AM +0200, Robas, Teodor wrote:

> I am writing to this list in the hope that somebody can clear me out
> if this platform is supported and I am doing something wrong, or if
> it is still work in progress.

> The drivers that I think should work with my hardware (OpenRD ultimate)
> are located in sound/soc/kirkwood/*.

Please remember to always CC maintainers on posts to Linux lists.  I've
added a CC to Arnaud and not cut any text for his benefit.

> Sound on this device worked (partially) with the default software
> it came but not with the latest about 10 kernels I have tried.
> 
> I added bellow the output of alsa-info.sh script. If needed I can look
> for more or try to fix it (with some help).
> 
> 
> Best Regards,
> Teodor
> 
> 
> 
> !!################################
> !!ALSA Information Script v 0.4.59
> !!################################
> 
> !!Script ran on: Thu Nov 11 06:27:39 UTC 2010
> 
> 
> !!Linux Distribution
> !!------------------
> 
> Debian GNU/Linux squeeze/sid \n \l
> 
> 
> !!DMI Information
> !!---------------
> 
> Manufacturer:
> Product Name:
> 
> 
> !!Kernel Information
> !!------------------
> 
> Kernel release:    2.6.37-rc1
> Operating System:  GNU/Linux
> Architecture:      armv5tel
> Processor:         unknown
> SMP Enabled:       No
> 
> 
> !!ALSA Version
> !!------------
> 
> Driver version:     1.0.23
> Library version:    1.0.23
> Utilities version:  1.0.23
> 
> 
> !!Loaded ALSA modules
> !!-------------------
> 
> 
> 
> !!Sound Servers on this system
> !!----------------------------
> 
> No sound servers found.
> 
> 
> !!Soundcards recognised by ALSA
> !!-----------------------------
> 
> --- no soundcards ---
> 
> 
> !!PCI Soundcards installed in the system
> !!--------------------------------------
> 
> 
> 
> !!Advanced information - PCI Vendor/Device/Susbsystem ID's
> !!--------------------------------------------------------
> 
> 
> 
> !!Modprobe options (Sound related)
> !!--------------------------------
> 
> snd-atiixp-modem: index=-2
> snd-intel8x0m: index=-2
> snd-via82xx-modem: index=-2
> snd-pcsp: index=-2
> snd-usb-audio: index=-2
> 
> 
> !!Loaded sound module options
> !!--------------------------
> 
> 
> !!ALSA Device nodes
> !!-----------------
> 
> crw-rw---- 1 root audio 116, 33 Nov 11 08:23 /dev/snd/timer
> 
> 
> !!Aplay/Arecord output
> !!------------
> 
> APLAY
> 
> aplay: device_list:235: no soundcards found...
> 
> ARECORD
> 
> arecord: device_list:235: no soundcards found...
> 
> !!Amixer output
> !!-------------
> 
> 
> !!Alsactl output
> !!-------------
> 
> --startcollapse--
> --endcollapse--
> 
> 
> !!All Loaded Modules
> !!------------------
> 
> Module
> snd_soc_kirkwood
> snd_soc_core
> snd_pcm
> snd_timer
> snd
> snd_page_alloc
> bridge
> stp
> llc
> nfsd
> lockd
> nfs_acl
> auth_rpcgss
> sunrpc
> exportfs
> loop
> xgifb
> fb
> cfbcopyarea
> mv_cesa
> cfbimgblt
> aes_generic
> cfbfillrect
> sd_mod
> crc_t10dif
> usb_storage
> sata_mv
> libata
> ehci_hcd
> scsi_mod
> usbcore
> mv643xx_eth
> libphy
> nls_base
> 
> 
> !!ALSA/HDA dmesg
> !!------------------
> 
> 
> PS: please note that none of the snd* modules are loaded by default.
> 
> PPS: Somewhere in the code (sound/soc/kirkwood/kirkwood-openrd.c)
> there is a check: machine_is_openrd_client() but in my case it should
> be machine_is_openrd_ultimate(). I removed this check anyway.
> 
> 
> -- 
>   _
> ( )   ascii ribbon campaign - against html e-mail
>   X    www.asciiribbon.org   - against proprietary attachments
> / \
> 
> 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
