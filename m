From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] New snd-audigyls driver available.
Date: Fri, 03 Dec 2004 20:19:08 +0000
Message-ID: <41B0CA3C.8070606@superbug.co.uk>
References: <41AF9A47.3060706@superbug.co.uk>	<s5hk6rzzk5i.wl@alsa2.suse.de>	<41B0BC11.5090106@superbug.co.uk> <s5h4qj32ln6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 394091E5
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2004 21:19:11 +0100 (MET)
In-Reply-To: <s5h4qj32ln6.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 03 Dec 2004 19:18:41 +0000,
> James Courtier-Dutton wrote:
> 
>>Takashi Iwai wrote:
>>
>>>At Thu, 02 Dec 2004 22:42:15 +0000,
>>>James Courtier-Dutton wrote:
>>>
>>>
>>>>I have updated the snd-audigyls driver.
>>>>It now consists of several .c files because the old audigyls.c was 
>>>>getting too big.
>>>>
>>>>Please download from
>>>>http://www.alsa-project.org/~james/alsa-driver/audigyls.0.0.20.tar.bz2
>>>>
>>>>untar that into ./alsa-driver/pci/emu10k1
>>>
>>>
>>>How about to create its own subdirectory pci/audigyls?
>>>There is no sharing module between audigyls and emu10k.
>>>
>>>
>>>Takashi
>>>
>>>
>>
>>There are no major similarities between the ca0106 driver and the emu10k 
>>driver.
>>So creating a new directory seems like a good idea to me.
>>The chip on the card is labeled "CA0106-DAT", so maybe we should rename 
>>audigyls to ca0106.
>>So, the new directory would be ca0106, and the filename would change.
>>e.g. audigyls_main.c -> ca0106_main.c
>>
>>I think this renaming might be a good idea, because that driver works 
>>with the "AudigyLS" and "Live 24bit" so calling the driver the 
>>"audigyls" is a bit of a mistake really.
> 
> 
> OTOH, ca0106 would be hard to find out that Audigy LS corresponds to
> it...
> 
> I don't mind to rename it from the technical viewpoint, though.
> 
> 
>>So, just take the files, make those simple changes and then add them to 
>>the alsa cvs.
> 
> 
> Shall I replace the struct/function names from audigyls to ca0106,
> too?  Or, would you like to keep audigyls there?
> 
> 
> Takashi
> 

Ah! Good question. I think for the sake of consistancy, replacing those 
would also be a good idea.
Do you want me to do that, or would it be easier if you do it.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
