From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Re: [PATCH 1/5] emu10k1 SB Live: Master volume and front
 channels via fxbus 8,9
Date: Tue, 22 Feb 2005 12:38:03 +0100
Message-ID: <421B199B.4090606@glocalnet.net>
References: <421A3A3A.6070009@glocalnet.net> <Pine.LNX.4.58.0502220925540.1748@pnote.perex-int.cz> <421B073C.1090007@glocalnet.net> <Pine.LNX.4.58.0502221116300.1748@pnote.perex-int.cz>
Reply-To: ALSA development <alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4C1D0172
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 12:38:05 +0100 (MET)
Received: from mulder.hem.za.org (unknown [84.217.19.155])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id EB2B7582A6
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 12:38:04 +0100 (MET)
Received: from skinner.hem.za.org ([192.168.0.2])
	by mulder.hem.za.org with esmtp (Exim 4.34)
	id 1D3YMe-00026H-Dr
	for alsa-devel@alsa-project.org; Tue, 22 Feb 2005 12:38:04 +0100
Received: from localhost ([127.0.0.1])
	by skinner.hem.za.org with esmtp (Exim 4.34)
	id 1D3YMd-0002gI-Og
	for alsa-devel@alsa-project.org; Tue, 22 Feb 2005 12:38:03 +0100
In-Reply-To: <Pine.LNX.4.58.0502221116300.1748@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 22 Feb 2005, Mikael Magnusson wrote:
> 
> 
>>Jaroslav Kysela wrote:
>>
...
>>
>>I think a "Master Digital Volume" or separate controls for surround, 
>>center and lfe are needed.
>>
>>How are you otherwise going to implement a "Master Volume" control in 
>>user space if you allow the user to change for example "Wave Surround" 
>>and "Surround"?
> 
> 
> As you noted here, the implemention of Master is only one abstraction view 
> for this device. Other users might use the card as two virtual PCM devices 
> (front = card1, rear = card2) and in this case is Master completely 
> useless for this example.
> 
> The control API allow to lock the specific control for writing (and only 
> application which locked the control can write to it), thus the user space 
> implementation can use this feature.
> 
> 						Jaroslav

And how do I adjust the rear, center and lfe volumes if the controls are 
locked? Should I have to use the soft volume plugin?

/Mikael


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
