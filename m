From: "daniel sheltraw" <l5gibson@hotmail.com>
Subject: Re: AW: general audio card Q
Date: Wed, 31 Jul 2002 01:07:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F85N6E5BgSeWjD0NG1x000194d2@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hotmail.com (f85.law7.hotmail.com [216.33.237.85])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA14439
	for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2002 08:08:35 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul

Thanks for your reply and the education. My main reason behind asking
this question is that I am using the RME PST card presently to do
CPU controlled transfer of data to the memory mapped buffers in those
cards. I am interested in using the CPU to do the transfer since
I have heard that DMA or busmastering produces many millisecond latency
in sound data playback. Such latency would be unacceptable in my app.
BTW I am using RTAI to schedule tasks.

I see in the ESS docs that many (maybe all) of their chipsets do
something similar to the RME PST card except that the ESS does
not use mapped-memory buffers. Instead it appears the use a single
FIFO which generates interrupts as the data in the FIFO moves past
the half-full (half empty :-) mark). These fifos are much smaller
than the RME buffers if I recall correctly. The ESS docs refer to
this as "ping-pong" transfer of sound data. I naive have called
both the RME and ESS "ping-pong" methods double-buffering. My error.

So I guess I should say that I am looking for cards that can use
the ping-pong method in addition to the RME and ESS chipsets.

Where does the DMA latency arise?

Thanks again,
Daniel Sheltraw




>From: Paul Davis <pbd@op.net>
>To: "daniel sheltraw" <l5gibson@hotmail.com>
>CC: annabellesgarden@yahoo.de, alsa-devel@alsa-project.org
>Subject: Re: AW: [Alsa-devel] general audio card Q Date: Tue, 30 Jul 2002 
>19:25:50 -0400
>
> >>i'm not exactly shure, what is double-buffers... the turtle beach
> >>pinnacle/fiji has shared memory, that can be accessed
> >>simultanously from the pc & the sound card.
> >
> >Some cards/chipsets (RME PST, ESS solo1) allow one to transfer
> >data for playback (record is similar) using a memory-mapped 
>double-buffer.
> >When buffer 1 has emptied its data to the DAC an
> >interrupt is issued. An ISR then fills buffer 1 with more
> >sound data while the buffer 2 continues to send its data to
> >the DAC for playback. When buffer 2 is emptied it causes an
> >interrupt and an ISR can fill it again. This goes on and on
> >until all data is played back.
>
>this has nothing to do with DMA or not. what you're describing in ALSA
>terms is a configuration with 2 periods per buffer. nothing more
>less. just about all ALSA support hardware allows for this
>configuration; a few don't allow anything else.
>
>the question as i read it was about cards that cannot do DMA. no
>matter how many periods, buffers or whatever, they rely on the host
>CPU to move data into memory on their hardware. such cards are rare,
>and getting rarer. see rui's recent post for a description of how
>cards that do use DMA use it.
>
> >In this method the transfer of the data from memory to the
> >memory-mapped buffers is performed by the CPU. This is in
> >contrast to DMA transfer of data where the busmaster on the
> >sound card controls transfer of data from memory to card.
>
>No, this has nothing to do with "double buffering". "double buffering"
>is a description of a particular configuration, not a mechanism. it
>can be accomplished in various ways.
>
> >So far I only know of the two cards mentioned above but there
> >must be others that allow data tranfser in this manner. I would
> >like to know which cards have the capablity to do this whether
> >or not ALSA supports this method yet in their drivers.
>
>cards that do not use DMA should generally be considered inferior
>because of the extra CPU cycles they force on the host system.
>
>ALSA neither supports nor not-supports this in the drivers. Its an
>implementation detail for the low-level (h/w specific) driver code;
>the mid-level code knows nothing about it.
>
>--p
>
>
>-------------------------------------------------------
>This sf.net email is sponsored by: Dice - The leading online job board
>for high-tech professionals. Search and apply for tech jobs today!
>http://seeker.dice.com/seeker.epl?rel_code=31
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel




_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
