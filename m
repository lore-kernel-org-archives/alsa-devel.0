From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: namehint: Evaluate more possibilities for hw
	devices
Date: Fri, 1 Oct 2010 17:04:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010011701180.20467@eeebox2.perex-int.cz>
References: <4CA4B6BF.3080503@aknet.ru>
	<alpine.LNX.2.00.1010011332210.20467@eeebox2.perex-int.cz>
	<4CA5CB0D.9030003@aknet.ru>
	<alpine.LNX.2.00.1010011408410.20467@eeebox2.perex-int.cz>
	<4CA5D359.9040400@aknet.ru>
	<alpine.LNX.2.00.1010011512520.20467@eeebox2.perex-int.cz>
	<4CA5F5D5.4090508@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A1CB424459
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 17:04:26 +0200 (CEST)
In-Reply-To: <4CA5F5D5.4090508@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 1 Oct 2010, Stas Sergeev wrote:

> Sorry for bothering you again, but I think
> even now it is not all that good. :)
>
> ---
> $ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: Dummy [Dummy], device 0: Dummy PCM [Dummy PCM]
>  Subdevices: 8/8
>  Subdevice #0: subdevice #0
>  Subdevice #1: subdevice #1
>  Subdevice #2: subdevice #2
>  Subdevice #3: subdevice #3
>  Subdevice #4: subdevice #4
>  Subdevice #5: subdevice #5
>  Subdevice #6: subdevice #6
>  Subdevice #7: subdevice #7
> card 2: STx7100 [STx7109 audio subsystem], device 0:  [PCM player #0 (HDMI)]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
> card 2: STx7100 [STx7109 audio subsystem], device 1:  [PCM player #1]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
> card 2: STx7100 [STx7109 audio subsystem], device 2:  [SPDIF player (HDMI)]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
>
> $ aplay -L
> null
>    Discard all samples (playback) or generate zero samples (capture)
> default:CARD=Dummy
>    Dummy, Dummy PCM
>    Default Audio Device
> default:CARD=STx7100
>    STx7109 audio subsystem, PCM player #0 (HDMI)
>    Default Audio Device

The Dummy and STx7109 devices does not have appropriate configuration 
files in /usr/share/alsa/cards tree and namehint does not list hw: like 
devices by default. Use "defaults.namehint.showall=1" in your 
configuration file (~/.asoundrc).

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
