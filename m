From: Robert Krakora <rob.krakora@messagenetsystems.com>
Subject: Re: 2.6.30: xruns caused by "ALSA: pcm - Safer
	boundary checks"
Date: Sat, 23 May 2009 17:34:54 -0400
Message-ID: <b24e53350905231434h44fb22e7l8ecd845e0b202f20@mail.gmail.com>
References: <20090522162709.2e04b688@dhcp-100-2-144.bos.redhat.com>
	<s5hmy94x0sy.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0905231430400.4067@eeebox2.perex-int.cz>
	<s5hk547el2j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f206.google.com (mail-gx0-f206.google.com
	[209.85.217.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AF3724347
	for <alsa-devel@alsa-project.org>;
	Sat, 23 May 2009 23:34:55 +0200 (CEST)
Received: by gxk2 with SMTP id 2so4812491gxk.8
	for <alsa-devel@alsa-project.org>; Sat, 23 May 2009 14:34:54 -0700 (PDT)
In-Reply-To: <s5hk547el2j.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Chuck Ebbert <cebbert@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Sat, May 23, 2009 at 2:22 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 23 May 2009 14:31:57 +0200 (CEST),
> Jaroslav Kysela wrote:
>>
>> On Fri, 22 May 2009, Takashi Iwai wrote:
>>
>> > At Fri, 22 May 2009 16:27:09 -0400,
>> > Chuck Ebbert wrote:
>> >>
>> >> Bug report: https://bugzilla.redhat.com/show_bug.cgi?id=498858
>> >>
>> >> To reproduce, pause a video in mplayer and then hit play:
>> >>
>> >> ALSA sound/core/pcm_lib.c:263: hda_codec: hw_ptr skipping! [Q] (pos=11263,
>> >> delta=17400, period=1024, jdelta=21/362/0)
>> >
>> > Does the patch fix the problem?
>>
>> This patch does not look as a proper fix.
>
> Hm, at which point?
> It just skips the first unreliable jiffies check.
> At least, it's interesting whether it works around the problem.
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>

Takashi:

I have submitted
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4523 in regards
to this problem.  I can recreated the xrun messages 100% of the time
and the routine in question never recovers.  With a workaround
suggested by Jaroslav, the xruns go away, but the calling process
ramps up to 100% CPU utilization and unless you are on a dual or quad
core machine there is quite a lockup.  I revert to the 1.0.19 pcmlib.c
in the 1.0.20 driver and I see neither problem.  Thanks for all of
your help Jaroslav.  If there is any way that I can help debug this
problem, please let me know.

Best Regards,

-- 
Rob Krakora
Senior Software Engineer
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677 Ext. 206
(317)663-0808 Fax
