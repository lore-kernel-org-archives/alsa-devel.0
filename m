From: gt bradley <baykelper@gmail.com>
Subject: Re: USB Audio out PS3
Date: Sun, 29 Jul 2007 14:39:13 -0700
Message-ID: <46AD0901.1080108@gmail.com>
References: <mailman.0.1185703202.30883.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E07724371
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Jul 2007 23:39:10 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so251680rvb
	for <alsa-devel@alsa-project.org>; Sun, 29 Jul 2007 14:39:09 -0700 (PDT)
In-Reply-To: <mailman.0.1185703202.30883.alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have connected a soundblaster mp3+ via usb to my ps3.
it shows up in the sound-config applet and plays stereo just fine using 
the various test commands.

I was using Fedora 7, (which has alsa ver. 1.0.14),  and had been 
compiling bleeding edge kernels, with the sound modules set up as modules.

The stereo part was almost plug-and-play, except that to install the 
USB, I did have to enable the "CONFIG_USB_EHCI_SPLIT_ISO (Experimental) 
" option in the kernel. 

I gave up trying to configure the SPDIF to do surround sound (long story).
GT
