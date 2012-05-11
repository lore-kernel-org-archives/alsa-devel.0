From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: Realtek ACL892: audio gap ~ each 10 seconds?
 [SOLVED]
Date: Fri, 11 May 2012 11:53:09 -0300
Message-ID: <4fad27d8.6974340a.5e07.6c22@mx.google.com>
References: <jnue8p$8li$1@dough.gmane.org> <jo53ht$j45$2@dough.gmane.org>
	<jobd2a$bj$1@dough.gmane.org> <johqka$tn$1@dough.gmane.org>
	<s5hehqruvh9.wl%tiwai@suse.de>
	<4facb947.541b340a.08eb.130c@mx.google.com>
	<s5hy5oztb63.wl%tiwai@suse.de>
	<4fad162b.07b3340a.14cb.5a06@mx.google.com>
	<s5h3976akpa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D2E1B104139
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 16:53:15 +0200 (CEST)
Received: by vbip1 with SMTP id p1so2962910vbi.38
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2012 07:53:15 -0700 (PDT)
In-Reply-To: <s5h3976akpa.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 11 May 2012 15:52:49 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> Could you check which unsolicited events are triggered on your
> machine?  When you build your kernel with the tracing support
> (CONFIG_TRACEPOINTS=y), you can enable the tracing via
> 
>   % echo 1 > /sys/kernel/debug/tracing/events/hda/hda_unsol_event/enable
>   .....
> 
> Check whether the events come up frequently even without
> plugging/unplugging any jacks.  Usually this shouldn't happen.  But in
> the case of problematic hardware with the auto-mute, many bogus unsol
> events are triggered.

	Takashi, I got the following:

# tracer: nop
#
# entries-in-buffer/entries-written: 12/12   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
          <idle>-0     [000] d.h3   449.885014: hda_unsol_event: [0] res=40000c1, res_ex=10
          <idle>-0     [000] d.h3   449.906339: hda_unsol_event: [0] res=4000041, res_ex=10
          <idle>-0     [000] d.h3   472.269431: hda_unsol_event: [0] res=40000c1, res_ex=10
          <idle>-0     [000] d.h3   472.290721: hda_unsol_event: [0] res=4000041, res_ex=10
          <idle>-0     [000] d.h3   478.262018: hda_unsol_event: [0] res=40000c1, res_ex=10
          <idle>-0     [000] d.h3   478.283319: hda_unsol_event: [0] res=4000041, res_ex=10
          <idle>-0     [000] d.h3   482.934742: hda_unsol_event: [0] res=40000c1, res_ex=10
          <idle>-0     [000] d.h3   482.956033: hda_unsol_event: [0] res=4000041, res_ex=10
          <idle>-0     [000] d.h3   584.308420: hda_unsol_event: [0] res=40000c1, res_ex=10
          <idle>-0     [000] d.h3   584.329693: hda_unsol_event: [0] res=4000041, res_ex=10
          <idle>-0     [000] d.h3   593.781622: hda_unsol_event: [0] res=40000c1, res_ex=10
          <idle>-0     [000] d.h3   593.802890: hda_unsol_event: [0] res=4000041, res_ex=10

	***

	But I couldn't notice it happening exactly during the click and
pop... When click and pop happens, nothing happens in this file... So I
don't know if it will be useful to you. 

	Anyway, I'm confortable with auto-mute off... If you need more
testing, just ask. I'll be glad to help.

	Thank you.

-- 
Linux 3.4.0-rc6: Saber-toothed Squirrel
http://www.youtube.com/DanielFragaBR
