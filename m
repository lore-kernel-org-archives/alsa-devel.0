From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Re: [PATCH 1/5] emu10k1 SB Live: Master volume and front
 channels via fxbus 8,9
Date: Tue, 22 Feb 2005 11:19:40 +0100
Message-ID: <421B073C.1090007@glocalnet.net>
References: <421A3A3A.6070009@glocalnet.net> <Pine.LNX.4.58.0502220925540.1748@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EB1E0175
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 11:19:42 +0100 (MET)
Received: from mulder.hem.za.org (unknown [84.217.26.207])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 858F7581B4
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 11:19:42 +0100 (MET)
Received: from skinner.hem.za.org ([192.168.0.2])
	by mulder.hem.za.org with esmtp (Exim 4.34)
	id 1D3X8n-0002gN-M8
	for alsa-devel@alsa-project.org; Tue, 22 Feb 2005 11:19:41 +0100
Received: from localhost ([127.0.0.1])
	by skinner.hem.za.org with esmtp (Exim 4.34)
	id 1D3X8m-0004Tu-N7
	for alsa-devel@alsa-project.org; Tue, 22 Feb 2005 11:19:40 +0100
In-Reply-To: <Pine.LNX.4.58.0502220925540.1748@pnote.perex-int.cz>
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
> On Mon, 21 Feb 2005, Mikael Magnusson wrote:
> 
> 
>>This is the first in a set of five patches that add master volume and 
>>switch controls and front pcm channels via fxbus 8,9 to SB Live.
> 
> 
> I still feel that it's broken idea. We have also problems with AC97
> where the surround/center&lfe volumes are separate from AC97 Master Volume
> control, too (at least for Sigmatel codecs).
> 
> We need a layer in user space to handle these issues where we can express
> the control relations in very easy way and not mess the kernel with more 
> dust which is not necessary.
> 
> It might be easy to write a small daemon which will create "Master Volume" 
> control for SB cards at this time until a decent solution in alsa-lib is 
> finished.
> 
> 						Jaroslav
> 

I think a "Master Digital Volume" or separate controls for surround, 
center and lfe are needed.

How are you otherwise going to implement a "Master Volume" control in 
user space if you allow the user to change for example "Wave Surround" 
and "Surround"?

/Mikael


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
