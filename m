From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1 emu10k1_main.c,1.12,1.13
Date: Tue, 16 Apr 2002 15:58:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CBC3C32.5060909@superbug.demon.co.uk>
References: <873cxxmmjt.fsf@www.gitteundmarkus.de>	<Pine.LNX.4.33.0204160911040.509-100000@pnote.perex-int.cz>	<s5h7kn729d9.wl@alsa2.suse.de>	<87sn5vn72w.fsf@www.gitteundmarkus.de>	<3CBC26AB.6030907@superbug.demon.co.uk> <s5h8z7nvhlv.wl@alsa2.suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>>There are several different versions of the SB Live.
>>My SB Live rev06 is not a SB Live 5.1, so it has 2 audio stereo output 
>>jacks, one for front, one for rear, and then a spdif jack. The spdif 
>>jack is not switchable between analogue and digital. It is fixed at digital.
>>    
>>
> 
>does "Digital/Analog Jack" switch affects the behavior on your digital
>jack?  i guess it doesn't.
>if it doesn't affect, then we can switch this bit safely on all
>cards.
>
>
>Takashi
>
>  
>
My SB Live (non 5.1) does not have a Digital/Analog Jack, it just has a 
Digital Jack, so I would prefer that the Digital/Analogue Switch in 
alsamixer was removed for rev06 cards and below, but present for rev7 
cards and above.

Currently, toggling the alsamixer Digital/Analogue Switch has no effect 
what so ever.

I think this rev07 passthru issue might have been the user just not 
knowing about the Digital/Analogue switch in alsamixer.

Cheers
James
