From: Paul Davis <pbd@op.net>
Subject: Re: AW: general audio card Q
Date: Tue, 30 Jul 2002 19:25:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207302324.BAA10183@alsa.alsa-project.org>
References: <F25RQN738VIwWqjBr3D00018c50@hotmail.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx2.fast.net (newmx2.fast.net [209.92.1.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA10183
	for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2002 01:24:25 +0200
In-Reply-To: Your message of "Tue, 30 Jul 2002 13:00:05 CDT."
             <F25RQN738VIwWqjBr3D00018c50@hotmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: daniel sheltraw <l5gibson@hotmail.com>
Cc: annabellesgarden@yahoo.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>i'm not exactly shure, what is double-buffers... the turtle beach 
>>pinnacle/fiji has shared memory, that can be accessed
>>simultanously from the pc & the sound card.
>
>Some cards/chipsets (RME PST, ESS solo1) allow one to transfer
>data for playback (record is similar) using a memory-mapped double-buffer. 
>When buffer 1 has emptied its data to the DAC an
>interrupt is issued. An ISR then fills buffer 1 with more
>sound data while the buffer 2 continues to send its data to
>the DAC for playback. When buffer 2 is emptied it causes an
>interrupt and an ISR can fill it again. This goes on and on
>until all data is played back.

this has nothing to do with DMA or not. what you're describing in ALSA
terms is a configuration with 2 periods per buffer. nothing more
less. just about all ALSA support hardware allows for this
configuration; a few don't allow anything else.

the question as i read it was about cards that cannot do DMA. no
matter how many periods, buffers or whatever, they rely on the host
CPU to move data into memory on their hardware. such cards are rare,
and getting rarer. see rui's recent post for a description of how
cards that do use DMA use it.

>In this method the transfer of the data from memory to the
>memory-mapped buffers is performed by the CPU. This is in
>contrast to DMA transfer of data where the busmaster on the
>sound card controls transfer of data from memory to card.

No, this has nothing to do with "double buffering". "double buffering"
is a description of a particular configuration, not a mechanism. it
can be accomplished in various ways.

>So far I only know of the two cards mentioned above but there
>must be others that allow data tranfser in this manner. I would
>like to know which cards have the capablity to do this whether
>or not ALSA supports this method yet in their drivers.

cards that do not use DMA should generally be considered inferior
because of the extra CPU cycles they force on the host system. 

ALSA neither supports nor not-supports this in the drivers. Its an
implementation detail for the low-level (h/w specific) driver code;
the mid-level code knows nothing about it.

--p


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
