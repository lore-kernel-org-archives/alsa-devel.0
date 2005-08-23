From: Bernard Leak <bernard@brenda-arkle.demon.co.uk>
Subject: Re: Building ALSA away from the source tree: some patches
Date: Tue, 23 Aug 2005 12:01:20 +0100
Message-ID: <430B0200.7070509@brenda-arkle.demon.co.uk>
References: <43026EFB.9030802@brenda-arkle.demon.co.uk>	<s5hvf1x6hoa.wl%tiwai@suse.de>	<430A3CE2.30900@brenda-arkle.demon.co.uk>	<s5hmzn957vs.wl%tiwai@suse.de>	<430AFA55.2070108@brenda-arkle.demon.co.uk> <s5hhddh54ct.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhddh54ct.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dear List,

Takashi Iwai wrote:

>Ah, no, I meant to split the patches to alsa-lib and alsa-utils, since
>they are basically different trees.  The changes to a single tree for
>a single purpose should be to a single patch (unless it becomes too
>big).
>  
>
I was a bit puzzled by that part of the requirements, but you
did ask for it specifically. My patches were always grouped
as one patch per tree (though this wasn't obvious when they
were textually included in the original posting).

>One question:
>
>  
>
>>--- alsa-lib-1.0.9/src/Makefile.am-old	2005-05-10 11:52:30.000000000 +0100
>>+++ alsa-lib-1.0.9/src/Makefile.am	2005-08-16 21:38:08.000000000 +0100
>>@@ -1,9 +1,9 @@
>> SUBDIRS=control mixer ordinary_mixer pcm ordinary_pcm rawmidi timer hwdep seq instr compat conf alisp
>>-EXTRA_DIST=Versions
>>+EXTRA_DIST=$(srcdir)/Versions
>>    
>>
>
>Do we need this really?
>  
>
Ah, doubtless not! A change made on autopilot, which of course broke
nothing and so was not brought to my attention again.

Thanks for your patience (you've needed it).

Bernard Leak.
--
Before they made me, they broke the mould.




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
