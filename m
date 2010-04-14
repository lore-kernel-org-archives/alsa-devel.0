From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] ALSA: pcm_lib - read/write IO improvement
Date: Wed, 14 Apr 2010 09:58:02 +0300
Message-ID: <20100414095802.6f24e87f.jhnikula@gmail.com>
References: <20100413144959.601bb9db.jhnikula@gmail.com>
	<s5hljcrz3ps.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id 864B0243FC
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 08:57:54 +0200 (CEST)
Received: by ewy19 with SMTP id 19so2162214ewy.22
	for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2010 23:57:54 -0700 (PDT)
In-Reply-To: <s5hljcrz3ps.wl%tiwai@suse.de>
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

On Tue, 13 Apr 2010 19:01:35 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > So by not doing the padding the distance to xrun is about the same and
> > the wake-up semantics remains the same. I understood from the thread
> > below that not all applications like if the wake-up happens before
> > avail >= avail_min what would happen with the second idea.
> > 
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2009-December/023986.html
> 
> Well, my understanding is that it's an application thing.
> It feeds the unaligned data while it expects the aligned wake-up.
> 
> Or, any other real example that doesn't work?
> 
Actually I noticed this by wondering why there are wake-ups happening
only for every second period even if there are only two periods. E.g.

aplay -D hw:0 -f dat --period-size=1024 --buffer-size=2048 /dev/zero

Then I noticed that this situation occurs if the hw_ptr has advanced
from the period boundary when checking for the avail in
snd_pcm_lib_write1 and snd_pcm_lib_read1 happens.

Let's image with the above command. First the both periods are filled up
and stream started.

Int 1
- appl_ptr = 2048
- hw_ptr >= 1024
- avail >= avail_min
- wake-up

Process running
- Filling up the period 1 
- Let the hw_ptr be 1026 in next iteration of snd_pcm_lib_write1
-> padding two frames into period 2

Int 2
- appl_ptr = 3074
- hw_ptr >= 2048
- wake-only if hw_ptr >= 2050
- Let the hw_ptr be 2049 -> no wake-up

Int 3
- appl_ptr = 3074
- hw_ptr >= 3072
- avail >= 2046
-> wake-up

Process running
- Padding rest of frames into period 2
- Filling up period 1
- Again if the hw_ptr has advanced, then one or more frames are padded
into period 2 and avail can be less than 1024 when the next interrupt
happens.

Now since the hw_ptr is always greater or equal in process running time
than wake-up time, it means that padding usually happens and most
usually the avail < avail_min when the next interrupt happens (unless
there is a long int latency at that time).

What I'm typically seeing that the avail_max is very near to buffer
size even under idle system. However, xruns do not occur very often
even if there are some busy loops running so the scheduler seems to do
good work by waking up us early enough :-)


-- 
Jarkko
