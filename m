From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: [linux-audio-dev] priority inversion & inheritance
Date: Fri, 12 Jul 2002 03:25:27 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207120241160.902-100000@ecabase.localdomain>
References: <200207112148.XAA10419@www.bluedns.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200207112148.XAA10419@www.bluedns.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-dev@music.columbia.edu
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

note! cross-posted to alsa-devel; some questions about the
      korg1212 driver...

On Thu, 11 Jul 2002, Martijn Sipkema wrote:

>> Ok, I guess here\'s the first real case against const-nframe.
> I thought i had already mentioned this several time :)

You didn't say it loud enough.. ;)

[soundcards for which 'sample_rate/interrupt_frequency' is fractional]
>> at least with ALSA you\'d be in trouble anyway as ALSA will wake your
>> driver only when period_count samples are available. If you set
> Perhaps this could be changed/added in ALSA?

Well... I wish you luck in getting that change accepted. :)

>> So like Paul said, do we need to support these soundcards...? For 
>> JACK-style operation both the above scenario are really, really bad.
> I don\'t have hardware that behaves like this :)
> But still, the yamahas are a common hardware. Is the korg card the 1212?
> I think it would still be nice to support these.

But even with a non-const-nframe, these might still be hopeless cases.  
As for the korg 1212, it doesn't be a similar case as the yamaha.  Its
current driver in ALSA CVS seems to have hardcoded values for total buffer
size and interrupt frequency. The used values are 8 blocks of 1024 sample
frames (ie. period_size=1024, buffer_size=8192). This is a pretty sucky
configuration. Unfortunately as part of the driver is implemented as
DSP-code, changing the default might not be easy.

Anyways, I don't have this card myself and have never tested it so the
above analysis might be totally wrong. So correct me I'm wrong here...

>> Basicly same approach is now in used in regards to the nframes issue. If
>> you try to use ecasound with a JACK driver (well, if there was such an
>> driver) with non-const-nframes, ecasound would just raise an error and
>> exit. In a way this makes sense as until I rewrite ecasound (which will
> Is adding an intermediate buffer for drivers with non-const nframes much work?

Some. I'd have to add code for the ringbuffer. Doesn't sound bad, but for
me it's a few hundred lines of new code that I have to maintain but very
likely nobody will ever use. The worst thing is that it would ruin my
beautiful codebase. ;) I hate having multiple code paths that do
essentially the same thing. The logic for handling JACK i/o is already
pretty hairy (connecting the JACK inputs and outputs to the ecasound
signal graph, master&slave timing modes, handling commands from the
ecasound ui, commands from jackd, etc, etc).

But again, the problem is really not what I have to do. All major ecasound
subsystems have been rewritten multiple times. If it needs to be done
again, I'll do it. But I'm not sure if it as likely that someone will
rewrite csound, pd, <insert-big-app-here> just to support JACK.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
PC Mods, Computing goodies, cases & more
http://thinkgeek.com/sf
