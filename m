From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Audio miniconference at LPC/KS confirmed-
Date: Mon, 24 Oct 2016 21:57:05 +0900
Message-ID: <e02689cb-1eea-9a6f-ef73-7c1fade4a24d@sakamocchi.jp>
References: <20160701155438.GU6247@sirena.org.uk>
 <20160825153940.GF6635@sirena.org.uk>
 <4788d7ff-0fd7-9d62-be74-72c5a143c999@sakamocchi.jp>
 <20161020141138.GM10208@sirena.org.uk>
 <6cfff6e4-5aaa-d4e6-8d78-18207788ef9c@sakamocchi.jp>
 <20161022233055.GS10208@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id ACD162667E7
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 14:57:10 +0200 (CEST)
In-Reply-To: <20161022233055.GS10208@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girgwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Oct 23 2016 08:30, Mark Brown wrote:
> On Sat, Oct 22, 2016 at 08:42:15AM +0900, Takashi Sakamoto wrote:
> 
>> 1. Add tracepoints to pcm parameter processing in ALSA PCM core
>> In my memory of our previous mini audio conference, some issuers are
>> addressed about pcm parameters. This is my WIP related to it. The aim is
>> to monitor changes of pcm parameter refinement processing just after
>> calling ioctl(HW_REFINE/HW_PARAMS). See my working branch:
>> https://github.com/takaswie/sound/tree/trace-rules
> 
> Do we need to discuss this face to face - are there concerns people have
> about adding tracepoints or something?  I think it's a good idea to do
> the tracepoints, I'm just wondering if we're going to have much of a
> discussion or if it'd be a very brief thing.

A disadvantage we have; to enlarge binary size of snd-pcm.ko. Anyway,
I'll propose it on this mailing list, later.

>> 3. Dropping dice driver from ALSA firewire stack
>> A fatal quirk apperard that the most of TCAT ASIC called as 'DICE'
>> breaks the least significant protocol as a sound device[1][2]. The
>> chipsets don't transfer PCM frames as the same as current sampling
>> frequency (it's sampling transfer frequency in IEC 61883-6 word).
>> This is my suggestion to drop dice driver from ALSA firewire stack.
> 
> I guess this is something that is mainly going to be discussed by a few
> people?

Yep.


Regards

Takashi Sakamoto
