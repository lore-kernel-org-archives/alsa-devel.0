From: "Nenad Sljivic" <nenad.sljivic@rt-rk.com>
Subject: Re: plughw, access modes
Date: Mon, 14 Feb 2011 15:44:46 -0800
Message-ID: <F065A87938B647EBABBE915132703FE8@domain.local>
References: <8C2D93A7301A488588BD4A2CAD8C6F4D@domain.local>
	<alpine.LNX.2.00.1102141206450.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.rt-rk.com (mail.rt-rk.ftn.uns.ac.rs [147.91.177.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DA6C2454C
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 00:44:53 +0100 (CET)
Received: from localhost (mail.localdomain [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 655D525C03A
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 00:44:52 +0100 (CET)
Received: from mail.rt-rk.com ([127.0.0.1])
	by localhost (mail.rt-rk.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lJ0dnOJFLwOZ for <alsa-devel@alsa-project.org>;
	Tue, 15 Feb 2011 00:44:52 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1102141206450.6272@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Jaroslav Kysela' <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav,

Thanks a lot for your prompt reply, but as far as I see, mmap_emulation flag
is not supported anymore. 
I am using 1.0.19 version of alsa-lib.

1) Should I use mmap_emul plugin instead of it? I haven't been able to find
any example or configuration that's using this plugin

2)  Additional to that, do I have to set SNDRV_PCM_INFO_MMAP in my device
driver, in order for mmap emulation to work?

Sorry for my ignorance, but I am an extreme newbie in this area so any help
is greatly appreciated.

Thanks a lot,
Nenad 

-----Original Message-----
From: Jaroslav Kysela [mailto:perex@perex.cz] 
Sent: 14 February 2011 03:10
To: Nenad Sljivic
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] plughw, access modes

On Mon, 14 Feb 2011, Nenad Sljivic wrote:

> Greetings guys,
>
>
>
> I am dealing with the device driver for the chip that has his own hardware
> buffer and the DMA is not available. Therefore, driver doesn't support
MMAP
> access and the data is copied using the copy file operation. My HW
natively
> supports BE format.
>
> However, I would like to be able to play little endian pcm as well.
>
> The problem, occurs when I try to use plughw device in order to play LE
pcm
> file
>
>
>
> " aplay: set_params:1022: Unable to install hw params: "
>
>
>
> My debugging session proved me that plughw device is trying to access
device
> driver with MMAP_INTERLEAVED mode. Does it mean that this is the only way
> for plughw to access device driver, and that I am not able to use plugins
> unless do some heavy modifications of device drivers (implement mmap
> access). Am I missing something?

You may enable mmap_emulation for the hw: plugin - see mmap_emulation in:

http://git.alsa-project.org/?p=alsa-lib.git;a=blob_plain;f=doc/asoundrc.txt;
hb=HEAD

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
