From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error
 recognising the SB Live Platinum.
Date: Tue, 04 Oct 2005 12:05:29 +0100
Message-ID: <434261F9.4020708@superbug.co.uk>
References: <dc7e3d7c111741a991e11a1a39ca9262@pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net [194.217.242.91])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5E57F1A9
	for <alsa-devel@alsa-project.org>; Tue,  4 Oct 2005 13:05:31 +0200 (MEST)
In-Reply-To: <dc7e3d7c111741a991e11a1a39ca9262@pobox.sk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: Dave Jones <davej@redhat.com>, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Peter Zubaj wrote:

>If ac97_chip=1 and ac97 doesn't exists - driver will refuse to load.
>If ac97_chip=2 and ac97 doesn't exists - driver should ignore ac97
>
>But I don't know if this is correct (I am not author of patch and I not tested it).
>if message is printed then there is
>goto no_ac97; /* FIXME: get rid of ugly gotos.. */
>this will skip ac97 mixer creation (if ac97 is not there this will fail and driver refuses to load)
>But I don't know if snd_ac97_bus will fail if there is no ac97 codec (I think - not, and this is not correct), then test should be done on snd_ac97_mixer and not on snd_ac97_bus creation.
>
>Peter Zubaj
>
>  
>
>>-----P?vodn? spr?va-----
>>Od: Dave Jones [mailto:davej@redhat.com]
>>Odoslan?: 4. okt?bra 2005 0:54
>>Komu: Peter Zubaj
>>K?pia: alsa-devel@alsa-project.org; James@superbug.co.uk; Linux Kernel Mailing List; perex@suse.cz
>>Predmet: Re: [Alsa-devel] Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
>>
>>
>>On Mon, Oct 03, 2005 at 08:23:28AM +0200, Peter Zubaj wrote:
>>    
>>
>>>AFAIK this was fixed in CVS. Two cards have same model id (one has AC97, one not).
>>>
>>>Fix:
>>>
>>>http://sourceforge.net/mailarchive/forum.php?thread_id=8360485&forum_id=33141
>>>
>>>      
>>>
>>From the look of that patch, this will just print
>  
>
>>"emu10k1: AC97 is optional on this board Proceeding without ac97 mixers..."
>>and do nothing about actually making things work for people again,
>>or even to suggest what they can do to work around this situation
>>when their volume control breaks.  At the least this sounds like it
>>needs to mention a module parameter to force ac97 support.
>>
>>What actually happens if we set ac97_chip=1 on the boards that
>>don't have it ? Is it purely a cosmetic thing, showing some
>>sliders that do nothing?
>>
>>Dave
>>
>>
>>    
>>
In my view the patch as presented is the correct behaviour.
We are aiming to identify every sound card using it's PCI subversion 
IDs. We should then know exactly which sound card we have, and therefore 
know which chips are present. This information is vital for us 
developers when we get reports of Audigy card X  not working, as every 
single Audigy card has slight but very important differences that can 
only be detected via the PCI subversion IDs. This patch was required 
because two very different sound cards both had the same PCI subversion 
IDs. So, for this case, and only this case we have no alternative but to 
try and handle the two alternatives for this PCI subversion ID. One with 
AC97 chip, and one without the AC97 chip. This patch will therefore only 
effect 2 sound cards, and therefore has minimal impact on all the other 
sound cards currently recognised. It is always better to try and 
autodetect hardware features, than require a new module parameter, so 
adding a module parameter is not a viable option here. We already have a 
module parameter to force the driver to bypass is PCI subversion ID 
recognition and assume a different card id so when a new sound card 
appears, the user can work around the recognition problem until the 
recognition is added to the driver.

James



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
