From: "daniel sheltraw" <l5gibson@hotmail.com>
Subject: Re: AW: general audio card Q
Date: Tue, 30 Jul 2002 13:00:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F25RQN738VIwWqjBr3D00018c50@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hotmail.com (f25.law7.hotmail.com [216.33.237.25])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA04437
	for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2002 20:00:42 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: annabellesgarden@yahoo.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello again ALSA list

Since it appears that my question may have been a little confusing
I will clarify below. Thanks for any help you can give me.

> > Besides the RME PST card, are there other sound cards which can do
> > interrupt driven data transfer to double-buffers (ie. no DMA) for
> > playback?
>
>i'm not exactly shure, what is double-buffers... the turtle beach 
>pinnacle/fiji has shared memory, that can be accessed
>simultanously from the pc & the sound card.

Some cards/chipsets (RME PST, ESS solo1) allow one to transfer
data for playback (record is similar) using a memory-mapped double-buffer. 
When buffer 1 has emptied its data to the DAC an
interrupt is issued. An ISR then fills buffer 1 with more
sound data while the buffer 2 continues to send its data to
the DAC for playback. When buffer 2 is emptied it causes an
interrupt and an ISR can fill it again. This goes on and on
until all data is played back.

In this method the transfer of the data from memory to the
memory-mapped buffers is performed by the CPU. This is in
contrast to DMA transfer of data where the busmaster on the
sound card controls transfer of data from memory to card.

So far I only know of the two cards mentioned above but there
must be others that allow data tranfser in this manner. I would
like to know which cards have the capablity to do this whether
or not ALSA supports this method yet in their drivers.

Thanks again,
Love ALSA!
Daniel Sheltraw





_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
