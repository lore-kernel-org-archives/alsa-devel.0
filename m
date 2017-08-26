From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/23] alsa-utils: rewrite aplay
Date: Sat, 26 Aug 2017 19:30:40 +0900
Message-ID: <5b3fa29b-838f-fe99-e4eb-6621fc8f211e@sakamocchi.jp>
References: <20170817120004.15326-1-o-takashi@sakamocchi.jp>
 <s5hy3qct89u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 1F17A266998
 for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2017 12:30:46 +0200 (CEST)
In-Reply-To: <s5hy3qct89u.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for your comment but sorry to be late.

On Aug 22 2017 15:40, Takashi Iwai wrote:
> On Thu, 17 Aug 2017 13:59:41 +0200,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> I think all of you in this mailing list might have used the command 'aplay',
>> at least once. This patchset is my attempt to rewrite it because current
>> shape of code is not enough good. Especially, ALSA PCM interface have got
>> extensions since aplay was firstly developed. One of my motivation is to
>> refine the tool to test such extensions.
>>
>> Below diagram illustrates new internal design of this program:
>>
>>                                               <-> container <-> (file)
>> (device) <-> (alsa-lib) <-> xfer <-> aligner <-> container <-> (file)
>>                                               <-> container <-> (file)
>>
>> For description of each modules, please read patch comment.
>>
>> This patchset is early preview for developers to see the above design, thus
>> some features of original aplay are not still implemented. Especially, some
>> options have no actual effect even if they're parsed. Presently, I see below
>> command lines run as I expected:
>>
>> $ ./aplay -C (-v) (-M)(-N) -D [hw:0,0|default] record.wav
>> $ ./aplay -P (-v) (-M)(-N) -D [hw:0,0|default] playback.wav
>> $ ./aplay --list-devices
>> $ ./aplay --list-pcm
>> $ ./aplay --version
>>
>> Here, I work with Intel HDA (hw:0,0) and pulse PCM plugin (default).
>>
>> It's my pleasure if received some comments from you.
> 
> Thanks for the effort, the resultant codes look neat.
> But, my concern is that the incomplete implementation and the lack of
> regression test thereof.

Yep. It's my concern, too. I have a plan to add some unit tests for
each functionality which this patchset divides from original code, but
it's not necessarily enough to check the regression.

> The most common tactics for the code refactoring is "divide and
> conquer": i.e. split the lengthy codes at first, and rewrite each of
> them.  The merit by this way is that you can keep the functionality
> and check the regression test step-by-step.
> 
> Meanwhile the approach you're taking is rather a complete rewrite from
> the scratch, and it's error-prone in that regard.  OTOH, a scratch
> build may result in a cleaner, better structured code, eventually.

At first step of this work, I attempted to apply the usual method for
code refactoring, however as you know current implementation of aplay
has no structured shape and I guess that usual approach takes me a lot
of time against what I'd like to do. Then I decided to rewrite it from
the scratch.

> So, I find it's OK to go in this way, but we can put this as a
> different command at first.  Once when the code reaches to the 100%
> full compatibility with the existing aplay, we can obsolete the old
> code and provide a symlink to the new command for the compatibility.
> 
> In that way, we can merge the codes gradually without too much worry.

Hm. A negative point of your idea is to force us to maintain two similar
programs for a short term. But it sounds reasonable to me for this case.

Name of the new command is... 'axfer' is good, I think.

> About the code: I still had little time to read through the whole
> codes, but though a very quick glance:
> 
> - Please put the good explanation as in the cover letter into the
>    changelog.  A documentation for the big picture is missing.

OK. I'll try it in next time. But actually the sources is more verbose.

> - Try to avoid inventing a new term; e.g. aligner is a unique word,
>    and difficult to understand (whether it's for teeth or what else).

It comes from 'laser aligner' in lithographic technology, but actually
an unfamiliar word and it's better to use another work; e.g. mapper.


Thanks

Takashi Sakamoto
