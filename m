From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1 emu10k1_main.c,1.12,1.13
Date: Wed, 17 Apr 2002 12:33:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CBD5D83.1000207@superbug.demon.co.uk>
References: <87it6qk9ra.fsf@www.gitteundmarkus.de>	<Pine.LNX.4.33.0204171032000.512-100000@pnote.perex-int.cz> <s5hsn5uu00h.wl@alsa2.suse.de>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
>
>>This behaviour is ok. When the raw S/PDIF device is used (passthough for 
>>EMU10K1), the switch is locked and can't be modified by another 
>>application.
>>
>>So, we know, at least, that for your card this switch must be off. 
>>Perhaps, it's only inverted?
>>    
>>
>
>i believe yes.  compared with oss code, i found the bit is flipped.
>i'll check in the fix now.
>
>
>Takashi
>
>  
>
Could all this be the long lost solution to those "Gateway" versions of 
the SB Live card, which have also never worked with alsa for passthru.
I don't have one of the "Gateway" cards, but I remember them being 
discussed on this list a long time ago.

Cheers
James
