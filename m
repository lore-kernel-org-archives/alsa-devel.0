From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: Re: snd_seq_parse_address accesses uninitialised data
Date: Mon, 24 Sep 2012 19:22:55 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1209241919140.6917@anubis.informatik.uni-halle.de>
References: <alpine.DEB.2.00.1209231903310.21223@anubis.informatik.uni-halle.de>
 <s5hsja7onmn.wl%tiwai@suse.de>
 <alpine.DEB.2.00.1209241614170.2471@anubis.informatik.uni-halle.de>
 <s5hk3vj8luz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
 [141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id 22FD92616B7
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 19:22:57 +0200 (CEST)
In-reply-to: <s5hk3vj8luz.wl%tiwai@suse.de>
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

> At Mon, 24 Sep 2012 16:20:50 +0200 (CEST),
> Henning Thielemann wrote:
>>
>> For me valgrind is pretty useless if I have to manually distinguish real
>> problems from false alarms in a long list of valgrind messages. Are you
>> sure that it is generally ok to pass pointers to uninitialized data to
>> ioctl also if in this particular case the pointer is not touched by ioctl?
>
> Only client field is read, and this is the field properly initialized
> in alsa-lib code.  Others are fields to be filled by the kernel, so it
> doesn't matter at all what's left there.
>
>> If yes, then I think valgrind must be somehow teached to ignore this
>> particular case.
>
> I have no idea how to teach valgrind, sorry.

I also asked in the valgrind mailing list and got this answer:
    http://sourceforge.net/mailarchive/forum.php?thread_name=506089CA.5030309%40bitwagon.com&forum_name=valgrind-users

Of course, I can suppress the message for me, but I expect that more 
people will stumble on it. Thus I'd prefer a resolution of the problem in 
ALSA.
