From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp9652+alsamixer -> kernel panic
Date: Thu, 29 May 2003 13:44:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19LRNl-0001Sn-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.44.0305291925460.28435-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 29 May 2003 19:27:46 +0200."
             <Pine.LNX.4.44.0305291925460.28435-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: d <dieb13@klingt.org>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>On Thu, 29 May 2003, Paul Davis wrote:
>
>> >ok, since i'm more a musician than a kernel-hacker, i don't exactly know 
>> >what to do with the panic output.
>> >i see EIP: 0010:[<c0280005>] and search for it in /var/log/ksymoops right?
>> >there i find
>> >...
>> >c0106298 __up_wakeup
>> >c02bfff4 csum_partial_copy_generic_Rsmp_e8aa9a96
>> 
>> ah. are you running on an SMP system with current ALSA CVS? if so, its
>> broken within the "core" of ALSA. you will need to back up to April
>> 27th to get a working SMP version. nobody has a fix for this at this
>> time, despite the fact that it makes ALSA unusable on an SMP system.
>
>Anybody is willing to turn spinlock debugging in SMP kernel? I posted 
>twice the guide... Edit linux/include/linux/spinlock.h:

somebody already replied that this #define only has any impact in
non-SMP mode. i haven't checked if this was true, it didn't seem
unlikely.



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
