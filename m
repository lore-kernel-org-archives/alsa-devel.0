From: =?ISO-8859-1?Q?Ingo_M=FCller?= <alsa@ingomueller.net>
Subject: Re: are the alsa wiki instructions for mercurial
	correct?
Date: Thu, 22 Feb 2007 22:37:28 +0100
Message-ID: <45DE0D18.3080505@ingomueller.net>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8A2@sea-exch-01.na.corp.dmxmusic.com>	<s5hvehu797j.wl%tiwai@suse.de>
	<F8FB97052F1BEF409F7842E960E49B5AAAF8A6@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <F8FB97052F1BEF409F7842E960E49B5AAAF8A6@sea-exch-01.na.corp.dmxmusic.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I just realized that we weren't talking about the same wiki :-D You sure
now the unofficial wiki at http://alsa.opensrc.org/... Thanks a lot
anyway! I'm currently working on the other wiki, so if the licences
permit it, I'll copy your text to this one, too...

Regards, Ingo



John Utz schrieb:
> 
> 
> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thu 2/22/2007 2:55 AM
> To: John Utz
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] are the alsa wiki instructions for mercurial correct?
>  
> At Wed, 21 Feb 2007 17:13:55 -0800,
> John Utz wrote:
>> However, all that i seem to be pulling down is the stub file and not the real
>> iplementations
>>
>> ie:
>>
>> [jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l {} \;
>> -rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 ./alsa-driver/pci/ac97/ac97_patch.c
>> -rw-r--r-- 1 jutz jutz 74 Feb 21 17:17 ./alsa-driver-2908/pci/ac97/ac97_patch.c
>> -rw-r--r-- 1 jutz jutz 74 Feb 21 17:13 ./alsa-kernel-2908/pci/ac97/ac97_patch.c
>> -rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 ./alsa-kernel/pci/ac97/ac97_patch.c
>>
>> these are just the files that include the 'real' implementations:
>>
>> [jutz@localhost alsa-hg]$ more alsa-driver/pci/ac97/ac97_patch.c
>> #define __NO_VERSION__
>> #include "../../alsa-kernel/pci/ac97/ac97_patch.c"
>>
>> am i doing something wrong or is mercurial missing some stuff?
> 
> The real codes are found in alsa-kernel tree.  These are synced with
> the linux kernel tree.  When you run hgconfigure script, it makes
> symlink from alsa-driver/alsa-kernel pointing that directory.
> 
> 
> Takashi
> 
> 
> 
> 
> Please look at the file info, the files in both the alsa-driver and alsa-kernel are identical, the ones in the alsa-kernel should be the full sized ones, not copies of the stub file
> 
> is there something that i am failing to understand?
> 
> tnx!
> 
> johnu
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
