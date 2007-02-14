From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH]: Fix __devinit and __devexit issues with
	sound drivers
Date: Wed, 14 Feb 2007 10:09:22 -0500
Message-ID: <45D32622.8090503@redhat.com>
References: <20070209144903.22210.59758.sendpatchset@prarit.boston.redhat.com>
	<s5hveibmhs4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hveibmhs4.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: michael@tweakoz.com, alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote:
> At Fri, 9 Feb 2007 09:49:03 -0500,
> Prarit Bhargava wrote:
>   
>> Fix __devinit and __devexit issues with sound drivers.
>>
>> Resolves MODPOST warnings similar to:
>>
>> WARNING: sound/drivers/snd-dummy.o - Section mismatch: reference to
>> .init.text:snd_dummy_probe from .data.rel.local between 'snd_dummy_driver' (at
>> 		offset 0x0) and 'snd_dummy_controls'
>> WARNING: sound/drivers/snd-mtpav.o - Section mismatch: reference to
>> .init.text:snd_mtpav_probe from .data.rel.local between 'snd_mtpav_driver' (at
>> 		offset 0x0) and 'snd_mtpav_input'
>> WARNING: sound/drivers/snd-virmidi.o - Section mismatch: reference to
>> .init.text:snd_virmidi_probe from .data.rel.local after 'snd_virmidi_driver' (at
>> 		offset 0x0)
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>>     
>
>   

Sorry for the late reply Takashi -- I got tied up with a few other things.

> Thanks for the patch.  But I'm afraid we need to change more from
> __init* to __devinit*, i.e. the functions called from __devinit
> shouldn't be __init but also __deveinit (for example, some functions
> in sound/drivers/dummy.c should be __devinit too).  Ditto for
> __initdata.
>
>   

It's odd that MODPOST didn't kick out more warnings.  I was relying on 
it to complain about __init & __devinit collisions.  I've ping'd a few 
others to see if we can figure out why no further errors were output.

> Also, could you separate patches for sound/oss/* and others?  We keep
> only ALSA stuff in our tree and it's not easy to apply the patches to
> old OSS drivers all together.
>
>   

Sure -- new patcheset to follow.

P.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
