From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Emu10k1x driver
Date: Fri, 14 May 2004 19:48:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A51468.7020003@superbug.demon.co.uk>
References: <20040511.173158.16937.167326@webmail27.nyc.untd.com>	<40A188EE.4050606@superbug.demon.co.uk>	<s5hwu3fkkww.wl@alsa2.suse.de>	<40A4FE87.2030001@superbug.demon.co.uk> <s5hsme2lxsp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsme2lxsp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 14 May 2004 18:14:47 +0100,
> James Courtier-Dutton wrote:
> 
>>>>I would like to add some information that might help people modifying 
>>>>this for the Audigy LS.
>>>>
>>>>The outputs for the card work in 2 modes.
>>>>1) Probably analogue on the output jacks.
>>>>snd_emu10k1x_ptr_write(chip, 0x41, 0, 0x70f);
>>>>snd_emu10k1x_ptr_write(chip, 0x45, 0, 0);
>>>
>>>>2) Probably digital spdif on the output jacks.
>>>>snd_emu10k1x_ptr_write(chip, 0x41, 0, 0x1000f);
>>>>snd_emu10k1x_ptr_write(chip, 0x45, 0, 0x700);
>>>
>>Those (1) and (2) should work on bother the LS and the Dell OEM.
> 
> 
> then, are they exclusive?
> 
> 

I think you could add a mixer toggle switch for either (1) or (2).
I don't know what each bit in those registers does, so for now it could 
probably be exclusive.

I have also heard that the way to program the Audigy LS might also apply 
  in some way the Audigy 2 to get the high samples rates working on the 
Audigy 2.

Hopefully I will get certain answers soon.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
