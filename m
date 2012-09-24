From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: Re: snd_seq_parse_address accesses uninitialised data
Date: Mon, 24 Sep 2012 16:20:50 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1209241614170.2471@anubis.informatik.uni-halle.de>
References: <alpine.DEB.2.00.1209231903310.21223@anubis.informatik.uni-halle.de>
 <s5hsja7onmn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
 [141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id 240992615DE
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 16:20:55 +0200 (CEST)
In-reply-to: <s5hsja7onmn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Mon, 24 Sep 2012, Takashi Iwai wrote:

> At Sun, 23 Sep 2012 19:08:09 +0200 (CEST),
> Henning Thielemann wrote:
>>
>> ==27797== Syscall param ioctl(generic) points to uninitialised byte(s)
>> ==27797==    at 0x5209D27: ioctl (syscall-template.S:82)
>> ==27797==    by 0x4EC9168: snd_seq_hw_query_next_client (seq_hw.c:367)
>> ==27797==    by 0x4ECF3E2: snd_seq_parse_address (seqmid.c:416)
>> ==27797==    by 0x40069D: main (in /home/thielema/programming/haskell/alsa-seq/ctest/parse-address)
>> ==27797==  Address 0x7fefffd24 is on thread 1's stack
>
> This is no bug.  The uninitialized fields aren't referred in the ioctl
> at all.  valgrind is just too picky, so you can safely ignore it.


For me valgrind is pretty useless if I have to manually distinguish real 
problems from false alarms in a long list of valgrind messages. Are you 
sure that it is generally ok to pass pointers to uninitialized data to 
ioctl also if in this particular case the pointer is not touched by ioctl? 
If yes, then I think valgrind must be somehow teached to ignore this 
particular case.


Best,
Henning
