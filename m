From: Richard Chan <rspchan@starhub.net.sg>
Subject: Re: ALC655 in CVS: Are Center/LFE switched with Surround?
Date: Thu, 20 Nov 2003 00:35:10 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBB9BBE.20203@starhub.net.sg>
References: <3FBB8699.10602@starhub.net.sg> <s5hptfo1irr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hptfo1irr.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alas, the new VIA82XX.conf doesn't fix the problem.
(ALC655 does not have the "Slot Modify" feature of ALC650).
Also I realise I still need a plug with slave.channels 6

If I use surround51 directly I cannot get sound out of the other
four speakers. This plug gives me rear sound

pcm.testrear {
        type plug
####Aargh!! should be ttable.0.2 and ttable.0.3####
####Changing Swap Surround Slot doesn't help###
####ALC655 does not have Slot Modify control bits in register 6A###
        ttable.0.4  1
        ttable.1.5  1
        slave.pcm surround51
        slave.channels 6
}

(I notice surround50.conf has the slave channels set; can something similar
be put inside surround51.conf?)

xine will also not product surround sound with the surround51 device -
I need to use a plug with channels set to 6.

Funny though mplayer works with the surround51 device (though
channels are swapped).


Takashi Iwai wrote:

>At Wed, 19 Nov 2003 23:04:57 +0800,
>Richard Chan wrote:
>  
>
>>I've finally got 5.1 out of my via82xx/ALC655 system using the 
>>Line-In/Mic jacks!
>>Thanks Takashi.
>>    
>>
>
>glad to hear that it works now.  what was the problem?
>
> 
>  
>
>>However I seem to have got Center/LFE switched with Surround.
>>I.e. if I play xine & mplayer (L, R, RearL, RearR, Center, LFE)
>>through surround51 I get Center/LFE switched with Rear speakers.
>>    
>>
>
>ah, this reminds me an old story.
>there is a mixer switch "Swap Surround Slot".  and, IIRC, starngely
>enough, for 5.1 this should be turned on for 5.1 output while it's off
>for 4.0.
>
>  
>
>>I must use the following to work in .asoundrc
>>pcm_slave.sltest {
>>    pcm "hw:0,1"
>>    channels 6
>>}
>>
>>pcm.via51 {
>>    type plug
>>    ttable.0.0  1
>>    ttable.1.1  1
>>    ttable.2.4  1
>>    ttable.3.5  1
>>    ttable.4.2  1
>>    ttable.5.3  1
>>    slave sltest
>>}
>>    
>>
>
>this is also a solution, but the attached would be more "light" way.
>copy the attached file to /usr/share/alsa/cards.
>also, if you have chance, please test 4.0 output, too.
>
>
>thanks,
>
>Takashi
>  
>
>------------------------------------------------------------------------
>
>
>  
>




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
