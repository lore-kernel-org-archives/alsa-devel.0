From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Subject: Re: [patch] pcm-record (was cs46xx record (Thinkpad
 A22) => deadlock)
Date: Thu, 31 Oct 2002 11:32:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC106CF.3020301@gmx.at>
References: <Pine.LNX.4.33.0210302132490.611-100000@pnote.perex-int.cz>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 30 Oct 2002, Takashi Iwai wrote:
>>At Tue, 29 Oct 2002 15:07:41 +0100,
>>Wilfried Weissmann wrote:
>>>[1  <text/plain; us-ascii (7bit)>]
>>>I dug a little around in the code. The infinitive loop was caused by 
>>>being stuck in DRAINING mode. snd_pcm_lib_read1() returns -EPIPE in this 
>>>case (pcm_lib.c: 2146). Then we return to snd_pcm_oss_read3() which 
>>>continues to call this function until jdoomsday (= SysRq+b). I changed 
>>>the code to call snd_pcm_update_hw_ptr() before that. The patch is 
>>>attached. It *seems* to fix it. You want to have a _real_ close look at 
>>>that if you want to apply the patch, as it is just a shot in the dark. 
>>>At least I know now that the problem is (I figured it out by inserting 
>>>printk).
>>
>>looks correct.  applied to cvs now.
> 
> 
> It's wrong. I reverted the change and included new updated code for the 
> OSS emulation.

I just tested the new patch. It works perfectly. Thanks all.

bye,
Wilfried



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
