From: Patrick Lightbody <patrick@lightbody.net>
Subject: Re: Strange Config: Fedora 8 running on Amazon EC2
Date: Wed, 28 Jan 2009 21:44:43 -0800
Message-ID: <c372afa40901282144if76cddet875b444c42e5e639@mail.gmail.com>
References: <c372afa40901281920k4504f7b0j7f06adca8b4b4bcf@mail.gmail.com>
	<74eb1fe20901282042ke3bc932gd443bb423c6b9f7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F0E810384A
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 06:44:44 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so6954239rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 21:44:43 -0800 (PST)
In-Reply-To: <74eb1fe20901282042ke3bc932gd443bb423c6b9f7b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sean McNamara <smcnam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sean and Lee,
Thanks for much for the ideas! A few moments ago someone on #lad on
IRC suggested I  try the snd-dummy module (modprobe snd-dummy). It
worked like a champ - the log messages went away and the Flash
component no longer crashed.

At least, on EC2's Fedora 8 instance.

Unfortunately, on another machine I need to get running (RHEL5), the
logs continue to persist even when snd-dummy was installed. I will try
both of your suggestions on that machine to see if it helps, but I
just wanted to let you know about snd-dummy working out partially for
me.

If you're curious, this is the alsa-info output for the RHEL machine:

http://www.alsa-project.org/db/?f=e8cc121e4c401a35969cd14e14b454c360037187

And this was on the one on the Fedora 8 machine (after having
installed snd-dummy):

http://www.alsa-project.org/db/?f=b2153e21c6fe272a72e9bd97a91c46f6452a38f3

Patrick


On Wed, Jan 28, 2009 at 8:42 PM, Sean McNamara <smcnam@gmail.com> wrote:
> Hi,
>
> On Wed, Jan 28, 2009 at 10:20 PM, Patrick Lightbody
> <patrick@lightbody.net> wrote:
>> I have a strange request (which is why I'm sending directly to the dev
>> list). I'm trying to run Flash video (v9 or v10) on Firefox 3 on a
>> Fedora 8 image running on Amazon EC2. I don't actually want/need sound
>> (it's of course technically not possible, since EC2 doesn't provide a
>> sound card). Video playback (when watched through VNC) goes fine for a
>> couple minutes, but then the browser and flash lock up entirely. I've
>> looked for ways to tell Firefox and/or Flash to not send audio out,
>> but I've come up empty so far. So now I'm hoping that fixing this
>> error and putting in perhaps some sort of "no op" device might help
>> out.
>>
>
>> I'm not positive the error is related to ALSA,
>
> Neither am I -- but we can definitely give you the info you need to
> test out null playback to see if it helps. It could still be a
> video-related issue.
>
>> though the fact that
>> there appear to be a ton of the following logs just before the lockup
>> is suspicious:
>>
>> ALSA lib confmisc.c:768:(parse_card) cannot find card '0'
>> ALSA lib conf.c:3513:(_snd_config_evaluate) function
>> snd_func_card_driver returned error: No such file or directory
>> ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
>> ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_concat
>> returned error: No such file or directory
>> ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
>> ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_refer
>> returned error: No such file or directory
>> ALSA lib conf.c:3985:(snd_config_expand) Evaluate error: No such file
>> or directory
>> ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM default
>> ALSA lib pcm_hw.c:1240:(_snd_pcm_hw_open) Invalid value for card
>>
>> (these lines repeat over and over again until the crash happens, then
>> it stops promptly)
>
> Yeah, you will want to eliminate such problems regardless of whether
> they are immediately fatal. The software (Flash) could have memory
> leaks or something if it fails to get a soundcard.
>
>>
>> As you can see by the alsa-info output at the following URL, I don't
>> have any running snd modules:
>>
>> http://www.alsa-project.org/db/?f=6b2431d0564b3638cdb798a6d1a21eb73982588c
>>
>> Similarly, I don't have any sound-related devices installed (ie:
>> /dev/audio, etc). My hope in emailing this list is that there may be a
>> solution that causes ALSA to no-op the requests that Firefox/Flash
>> send it's way, potentially solving the lockup I'm experiencing.
>
> Option 1 (less obvious unless you know where to look, but certainly
> viable): http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html
> <--- look up the "Null" plugin here. Drop a null plugin into
> /etc/asound.conf as the default:
>
> pcm.!default {
> type null
> }
>
> This is exactly the "no-op" soft PCM that you want. AFAIK all the APIs
> against this just return saying "OK, I've done it", and the
> configuration space is as flexible as possible.
>
> Option 2, which was my first guess before I remembered the link above:
> You could install PulseAudio and either pipe the sound over the
> network to your host, or load a null sink, then use ALSA<->pulse.
>
> Alternatively, you could provide "support" for no-op sounds from both
> PulseAudio _and_ ALSA clients by implementing both these options.
>
> HTH,
>
> Sean
>
>>
>> I would really appreciate any ideas that could be shared. Thank you very much!
>>
>> Patrick
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
