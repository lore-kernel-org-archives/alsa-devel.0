From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1 emu10k1_main.c,1.12,1.13
Date: Tue, 16 Apr 2002 23:26:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CBCA523.8030802@superbug.demon.co.uk>
References: <873cxxmmjt.fsf@www.gitteundmarkus.de>	<Pine.LNX.4.33.0204160911040.509-100000@pnote.perex-int.cz>	<s5h7kn729d9.wl@alsa2.suse.de> <87sn5vn72w.fsf@www.gitteundmarkus.de>	<s5hads3vhph.wl@alsa2.suse.de> <87elhfn1rd.fsf@www.gitteundmarkus.de>	<s5h3cxvvd8h.wl@alsa2.suse.de> <87lmbnli6r.fsf@www.gitteundmarkus.de>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Markus Plail <plail@web.de>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Markus Plail wrote:

>Hi Takashi!
>
>* Takashi Iwai writes:
>  
>
>>yes.  now please check the state of this switch by alsamixer.  try to
>>play raw data once, and check whether the switch is changed.
>>alsamixer will show the current status (and change the status if any
>>notified).
>>    
>>
>
>This is the same as if I changed the switch in alsamixer by hand, right?
>This does not work. I have done this before thousands of times. The
>switch is working fine, but has nothing to do with my problem
>(IMHO). Only if I change emumixer the way you did by accident I get AC3
>passthrough.
>If AC3 passthrough is enabled, i.e. I watch a DVD with xine, the
>digital/analog switch doesn't do anything, i.e. I can't turn off the
>audio. If I play for example a mp3 with xmms, the digital/analog switch
>is working as expected.
>
>Regards
>Markus
>  
>
I think what Takashi is saying is that when xine attempts to do 
passthru, it should change the switch automatically. It will in fact 
override whatever you entered in alsamixer. So maybe before it was 
overriding it to "analogue" instead of overriding it to "digital".

I think that is what Takashi was trying to say.

Cheers
James
