From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: plughw, access modes
Date: Mon, 14 Feb 2011 12:09:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102141206450.6272@eeebox2.perex-int.cz>
References: <8C2D93A7301A488588BD4A2CAD8C6F4D@domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id AB16C103813
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 12:09:57 +0100 (CET)
In-Reply-To: <8C2D93A7301A488588BD4A2CAD8C6F4D@domain.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nenad Sljivic <nenad.sljivic@rt-rk.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Feb 2011, Nenad Sljivic wrote:

> Greetings guys,
>
>
>
> I am dealing with the device driver for the chip that has his own hardware
> buffer and the DMA is not available. Therefore, driver doesn't support MMAP
> access and the data is copied using the copy file operation. My HW natively
> supports BE format.
>
> However, I would like to be able to play little endian pcm as well.
>
> The problem, occurs when I try to use plughw device in order to play LE pcm
> file
>
>
>
> " aplay: set_params:1022: Unable to install hw params: "
>
>
>
> My debugging session proved me that plughw device is trying to access device
> driver with MMAP_INTERLEAVED mode. Does it mean that this is the only way
> for plughw to access device driver, and that I am not able to use plugins
> unless do some heavy modifications of device drivers (implement mmap
> access). Am I missing something?

You may enable mmap_emulation for the hw: plugin - see mmap_emulation in:

http://git.alsa-project.org/?p=alsa-lib.git;a=blob_plain;f=doc/asoundrc.txt;hb=HEAD

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
