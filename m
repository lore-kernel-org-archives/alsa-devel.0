From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp9652+alsamixer -> kernel panic
Date: Thu, 29 May 2003 12:27:49 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19LQBJ-00080C-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.44.0305291842040.856-100000@ecabase.localdomain>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 29 May 2003 18:57:23 +0300."
             <Pine.LNX.4.44.0305291842040.856-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>On Thu, 29 May 2003, Paul Davis wrote:
>
>>>c0106298 __up_wakeup
>>>c02bfff4 csum_partial_copy_generic_Rsmp_e8aa9a96
>> ah. are you running on an SMP system with current ALSA CVS? if so, its
>> broken within the "core" of ALSA. you will need to back up to April
>> 27th to get a working SMP version. nobody has a fix for this at this
>> time, despite the fact that it makes ALSA unusable on an SMP system.
>
>Hmm, anyway to easily and reliably reproduce the bug?

run jack? :))

>I'm running the latest ALSA and JACK CVS (updated both today) and works
>fine on my SMP box (dual-celeron). And so do my other ALSA apps. And this
>is not just with one card, I've tested both with es1371 and ice1712
>(Delta44) and no panics yet.

i should try an update and see if its been fixed. it wasn't last week.

--p


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
