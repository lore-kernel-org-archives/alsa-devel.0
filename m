From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: DMA feature question.
Date: Sat, 26 Jun 2004 15:44:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40DD8BD0.40705@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-37.mail.demon.net (anchor-post-36.mail.demon.net [194.217.242.86])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7859B2CD
	for <alsa-devel@alsa-project.org>; Sat, 26 Jun 2004 15:42:02 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-37.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1BeDRR-000HLc-0b
	for alsa-devel@alsa-project.org; Sat, 26 Jun 2004 14:42:01 +0100
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

I have a sound card that requires access to 2 DMA areas per substream.
1) Is for the audio samples buffer. I can already do that with:

err = snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV, 
snd_dma_pci_data(emu->pci), 32*1024, 32*1024);


2) Is for a table of periods..
This table will contain:-
{ u32 Pointer_into_samples_buffer,
u32 number_of_bytes }
So, each record in the table is 8 bytes long, and identify each period 
in the buffer.

So, the table will contain a list of the different periods.
So, if there are 8 periods, the table will have 8 entries, each 8 bytes 
long, so I will need a DMA map for 64 bytes.

Is there any way to use the snd_pcm_lib_preallocate_pages() for this 
"table or periods".

If not, I will just have to make (1) a bit bigger, and place the "table 
of periods" in there.

Cheers

James


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
