From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Re: [PATCH 1/5] emu10k1 SB Live: Master volume and front
 channels via fxbus 8,9
Date: Wed, 23 Feb 2005 09:57:42 +0100
Message-ID: <421C4586.5090000@glocalnet.net>
References: <421A3A3A.6070009@glocalnet.net>  <Pine.LNX.4.58.0502220925540.1748@pnote.perex-int.cz> <1109109856.31071.44.camel@krustophenia.net> <Pine.LNX.4.58.0502230918440.1748@pnote.perex-int.cz>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 28BAC1DD
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 09:57:43 +0100 (MET)
Received: from mulder.hem.za.org (unknown [84.217.31.84])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id BDBC258DCF
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 09:57:42 +0100 (MET)
Received: from skinner.hem.za.org ([192.168.0.2])
	by mulder.hem.za.org with esmtp (Exim 4.34)
	id 1D3sL0-0000zj-W2
	for alsa-devel@alsa-project.org; Wed, 23 Feb 2005 09:57:43 +0100
Received: from localhost ([127.0.0.1])
	by skinner.hem.za.org with esmtp (Exim 4.34)
	id 1D3sL0-0002rg-HN
	for alsa-devel@alsa-project.org; Wed, 23 Feb 2005 09:57:42 +0100
In-Reply-To: <Pine.LNX.4.58.0502230918440.1748@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 22 Feb 2005, Lee Revell wrote:
> 
> 
>>There are two separate issues that the patch addresses.  One is that
>>unlike the Audigy configuration, the driver does not use separate FX
>>buses for front output and PCM.  So attenuating the front channels will
>>attenuate *all* PCM samples.  This has to be fixed in the driver.  And
>>it's essentially zero cost as the extra FX buses and GPRs are available.
> 
> 
> Sorry, but I don't understand very well why we need to have "PCM mix" FX
> buses. We can do this "down-mix" in the DSP code, but it's better to do it
> in application. My original DSP code for emu10k1 have only front, rear,
> center+lfe FX buses (6). I must miss something important here.
> 

I don't understand what you mean with "PCM mix". Are you thinking of the 
default output which are up-mixed to 5.1? The patch doesn't down-mix 5.1 
to front or something like that. It adds two fx inputs that are routed 
to front only and not up-mixed to 5.1. This is how the Audigy driver 
works. It also can make the configuration file a little cleaner, since 
it doesn't have to mute the up-mixed outputs.

/Mikael


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
