From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: big smile
Date: Tue, 24 Feb 2004 15:58:29 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403B74A5.2090701@superbug.demon.co.uk>
References: <Pine.LNX.4.58.0402241536450.1883@pnote.perex-int.cz> <403B6BFA.6080403@superbug.demon.co.uk> <Pine.LNX.4.58.0402241617010.1883@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA01674
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2004 16:51:39 +0100
In-Reply-To: <Pine.LNX.4.58.0402241617010.1883@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 24 Feb 2004, James Courtier-Dutton wrote:
> 
> 
>>Jaroslav Kysela wrote:
>>
>>>http://www.opensound.com/cuckoo.html
>>>
>>>:-) No comment, except that some comments are really wrong.
>>>
>>>						Jaroslav
>>>
>>
>>Hehe! ;-)
>>
>>Is there a list anywhere listing the differences between OSS and ALSA 
>>with regard to sound card hardware.
>>It would be nice to have a nice small list of all the sound hardware OSS 
>>supports, but ALSA does not.
>>Then the intention would be to reduce that list to no entries by 
>>implementing them all in ALSA.
>>
>>I only know of 2 sound cards on that list: -
>>1) SB Live (Dell version) emu10k1x
>>2) SB Audigy LS (A emu10k1x lookalive with minor differences)
> 
> 
> Yes, I definitely want to support these cards in ALSA in near future.
> It seems that Creative is very popular here in Europe.
> 
> Also there are some lynxone, lynxtwo modules in latest OSS drivers.
> 
> 						Jaroslav
> 

Can we add them in RED to the http://www.alsa-project.org/alsa-doc/  page?

SB Live (Dell version) emu10k1x: -
(lspci would give "Class 0401: 1102:0006")
SB Audigy LS (A emu10k1x lookalike with minor differences.)
(lspci would give "Class 0401: 1102:0007")

Maybe we should add an lspci info column to the table, so people could 
quickly see if their card was supported or not.

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
