From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [Fwd: Re: [pulseaudio-discuss] pulseaudio debug
	mode]
Date: Mon, 26 Jul 2010 12:21:46 +0800
Message-ID: <AANLkTin4S-S-xKkx41ZVZKVJVJ+T8ppuHsi033J8ZT=3@mail.gmail.com>
References: <1280097015.29696.8.camel@localhost.localdomain>
	<AANLkTimj3W_tgi-+Qqgz-J31u-daOqJ8a2E74qEUzy8U@mail.gmail.com>
	<1280107804.29411.1.camel@localhost.localdomain>
	<AANLkTimoBu3baCYdDWoBQkATrXhG2R2ExYvWybKy1WK_@mail.gmail.com>
	<1280113577.19933.2.camel@localhost.localdomain>
	<AANLkTinc+yEo-xDpPHC1eoxEmmuSXfrhkK50zD75QwKR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6DBC32460D
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 06:21:49 +0200 (CEST)
Received: by vws20 with SMTP id 20so2355043vws.38
	for <alsa-devel@alsa-project.org>; Sun, 25 Jul 2010 21:21:46 -0700 (PDT)
In-Reply-To: <AANLkTinc+yEo-xDpPHC1eoxEmmuSXfrhkK50zD75QwKR@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/26 Raymond Yau <superquad.vortex2@gmail.com>

>
>
> 2010/7/26 Chris <cpollock@embarqmail.com>
>
>> On Mon, 2010-07-26 at 09:45 +0800, Raymond Yau wrote:
>> > 2010/7/26 Chris <cpollock@embarqmail.com>
>> >
>> > > On Mon, 2010-07-26 at 07:31 +0800, Raymond Yau wrote:
>> > > > 2010/7/26 Chris <cpollock@embarqmail.com>
>> > > >
>> > > > > Raymond, attached is a post I made today to the pulseaudio list.
>> > > > >
>> > > > > From: Chris <cpollock@embarqmail.com>
>> > > > > To: pulseaudio-discuss@mail.0pointer.de
>> > > > > Date: Sun, 25 Jul 2010 12:15:02 -0500
>> > > > > Subject: Re: [pulseaudio-discuss] pulseaudio debug mode
>> > > > > On Fri, 2010-07-23 at 08:58 +0100, Colin Guthrie wrote:
>> > > > > > 'Twas brillig, and Chris at 23/07/10 02:04 did gyre and gimble:
>> > > > > > > What is the best way to start PA for debugging and still have
>> all
>> > > the
>> > > > > > > usual clients running?
>> > > > > >
>> > > > > > If you mean having all the clients connect (e.g. applications
>> with
>> > > > > > libcanberra support or similar for sound events), then there are
>> > > > > > basically two ways.
>> > > > > >
>> > > > > > The first is as Luke suggests. These clients will automatically
>> > > > > > reconnect to PA if they need to (provided you have a vaguely
>> recent
>> > > > > > libcanberra), after it is restarted and run in debug mode.
>> > > > > >
>> > > > > > Alternatively you can simply set debug-level to "debug" in
>> > > daemon.conf
>> > > > > > (in /etc/pulse or ~/.pulse), and then "grep pulseaudio
>> > > /var/log/messages"
>> > > > > >
>> > > > > > Col
>> > > > > >
>> > > > >
>> > > > > Colin, link below is for debug output also some other output.
>> Anything
>> > > > > look out of place that would cause the overruns?
>> > > > >
>> > > > > http://pastebin.com/ZWSWmXZt
>> > > > > --
>> > > > >
>> > > >
>> > > > Most likely you will need to set debug-level to "debug" in
>> daemon.conf
>> > > > logout and login , and check the /var/log/messages
>> > > >
>> > > > I suspect it occur after PA server abort and auto spawn , so please
>> don't
>> > > > just post the PA log starting from "asyncq overrun" , you need to
>> post
>> > > from
>> > > > the last two PA startup sequence before the error occur since we
>> need to
>> > > > know why PA auto spawn
>> > >
>> > > Is this what you mean Raymond:
>> > > http://pastebin.com/4RT7YaG6
>> > >
>> > >
>> > No, you don't have "asyncq overrun" error in these log
>> >
>> > if you had change the "debug-level", the log still keep in
>> /var/log/messages
>> >
>> > The PA client which can connected to PA server before the PA server
>> start
>> > the playing thread is the PA client which autospawn the PA server
>>
>> The log level has been set to debug all day
>>
>> ### Read from configuration file: /home/chris/.pulse//daemon.conf ###
>> daemonize = no
>> fail = yes
>> high-priority = yes
>> nice-level = -11
>> realtime-scheduling = yes
>> realtime-priority = 5
>> allow-module-loading = yes
>> allow-exit = yes
>> use-pid-file = yes
>> system-instance = no
>> cpu-limit = no
>> enable-shm = yes
>> flat-volumes = yes
>> lock-memory = no
>> exit-idle-time = 20
>> scache-idle-time = 20
>> dl-search-path = /usr/lib/pulse-0.9.21/modules
>> default-script-file = /etc/pulse/default.pa
>> load-default-script-file = yes
>> log-target = auto
>> log-level = debug
>> resample-method = speex-float-0
>> enable-remixing = yes
>> enable-lfe-remixing = no
>> default-sample-format = s16le
>> default-sample-rate = 44100
>> default-sample-channels = 2
>> default-channel-map = front-left,front-right
>> default-fragments = 4
>> default-fragment-size-msec = 25
>> shm-size-bytes = 0
>> log-meta = no
>> log-time = yes
>> log-backtrace = 0
>> rlimit-fsize = -1
>> rlimit-data = -1
>> rlimit-stack = -1
>> rlimit-core = -1
>> rlimit-rss = -1
>> rlimit-as = -1
>> rlimit-nproc = -1
>> rlimit-nofile = 256
>> rlimit-memlock = -1
>> rlimit-locks = -1
>> rlimit-sigpending = -1
>> rlimit-msgqueue = -1
>> rlimit-nice = 31
>> rlimit-rtprio = 9
>> rlimit-rttime = 1000000
>>
>>
>> The is what happens after a fresh log-in and Mandrive update is running
>> and I also start Firefox:
>>
>> Jul 25 21:48:22 localhost mdkapplet[16332]: Computing new updates...
>> Jul 25 21:48:23 localhost mdkapplet[16332]: running: urpmi.update
>> --update
>> Jul 25 21:48:39 localhost mdkapplet[16332]: updating inactive backport
>> media Main Backports (Official2010.1-4), Contrib Backports
>> (Official2010.1-12), Non-free Backports (Official2010.1-20), PLF Free
>> backports, PLF Non-free backports
>> Jul 25 21:48:39 localhost mdkapplet[16332]: running: urpmi.update Main
>> Backports (Official2010.1-4)
>> Jul 25 21:48:46 localhost mdkapplet[16332]: running: urpmi.update
>> Contrib Backports (Official2010.1-12)
>> Jul 25 21:48:48 localhost mdkapplet[16332]: running: urpmi.update
>> Non-free Backports (Official2010.1-20)
>> Jul 25 21:48:51 localhost mdkapplet[16332]: running: urpmi.update PLF
>> Free backports
>> Jul 25 21:48:55 localhost mdkapplet[16332]: running: urpmi.update PLF
>> Non-free backports
>> Jul 25 21:48:57 localhost pulseaudio[26721]: (7440.932|  71.318)
>> client.c: Created 44 "Native client (UNIX socket client)"
>> Jul 25 21:48:57 localhost pulseaudio[26721]: (7440.932|   0.000)
>> protocol-native.c: Protocol version: remote 16, local 16
>> Jul 25 21:48:57 localhost pulseaudio[26721]: (7440.932|   0.000)
>> protocol-native.c: Got credentials: uid=500 gid=500 success=1
>> Jul 25 21:48:57 localhost pulseaudio[26721]: (7440.932|   0.000)
>> protocol-native.c: SHM possible: yes
>> Jul 25 21:48:57 localhost pulseaudio[26721]: (7440.932|   0.000)
>> protocol-native.c: Negotiated SHM: yes
>> Jul 25 21:48:57 localhost pulseaudio[26721]: (7440.934|   0.001)
>> module-augment-properties.c: Looking for .desktop file for firefox
>> Jul 25 21:49:19 localhost pulseaudio[26721]: (7462.497|  21.563)
>> asyncq.c: q overrun, queuing locally
>> Jul 25 21:49:19 localhost pulseaudio[26721]: (7462.577|   0.080)
>> asyncq.c: q overrun, queuing locally
>> Jul 25 21:49:19 localhost pulseaudio[26721]: (7462.577|   0.000)
>> asyncq.c: q overrun, queuing locally
>> Jul 25 21:49:19 localhost pulseaudio[26721]: (7462.657|   0.079)
>> asyncq.c: q overrun, queuing locally
>> Jul 25 21:49:19 localhost pulseaudio[26721]: (7462.737|   0.080)
>> asyncq.c: q overrun, queuing locally
>> Jul 25 21:49:19 localhost pulseaudio[26721]: (7462.737|   0.000)
>> asyncq.c: q overrun, queuing locally
>> Jul 25 21:49:19 localhost pulseaudio[26721]: (7462.737|   0.000)
>> asyncq.c: q overrun, queuing locally
>> Jul 25 21:49:19 localhost pulseaudio[26721]: (7462.737|   0.000)
>> asyncq.c: q overrun, queuing locally
>> Jul 25 21:49:19 localhost pulseaudio[26721]: (7462.817|   0.079)
>> asyncq.c: q overrun, queuing locally
>> Jul 25 21:49:19 localhost pulseaudio[26721]: (7462.817|   0.000)
>> asyncq.c: q overrun, queuing locally
>> Jul 25 21:49:19 localhost pulseaudio[26721]: (7462.897|   0.079)
>> asyncq.c: q overrun, queuing locally
>> Jul 25 21:49:51 localhost mdkapplet[16332]: Packages are up to date
>>
>>
> you should ask PA developer to add code to debug since this is a queue used
> by PA and has no relationship with alsa ,
>
>  alsa-sink and alsa-source can only post PA_CORE_MESSAGE_UNLOAD_MODULE
>
> modules/alsa/alsa-sink.c:    pa_asyncmsgq_post(u->thread_mq.outq,
> PA_MSGOBJECT(u->core), PA_CORE_MESSAGE_UNLOAD_MODULE, u->module, 0, NULL,
> NULL);
> modules/alsa/alsa-source.c:    pa_asyncmsgq_post(u->thread_mq.outq,
> PA_MSGOBJECT(u->core), PA_CORE_MESSAGE_UNLOAD_MODULE, u->module, 0, NULL,
> NULL);
>
>
> and you have to copy definition of struct asyncmsgq_item from asyncmsgq.c
>
>
> void pa_asyncq_post(pa_asyncq*l, void *p) {
>     struct localq *q;
> +   struct asyncmsgq_item *i;
>
>     pa_assert(l);
>     pa_assert(p);
>
> +  i=( struct asyncmsgq_item *)p;
>
>     if (flush_postq(l, FALSE))
>         if (pa_asyncq_push(l, p, FALSE) >= 0)
>             return;
>
>     /* OK, we couldn't push anything in the queue. So let's queue it
>      * locally and push it later */
>
>     if (pa_log_ratelimit())
> -        pa_log_warn("q overrun, queuing locally");
> +        pa_log_warn("q overrun, queuing locally  code %d",i->code);
>


you have to find out why this fail to return

flush_postq() return false or pa_asyncq_push() return negative number

    if (flush_postq(l, FALSE))
        if (pa_asyncq_push(l, p, FALSE) >= 0)
            return;
