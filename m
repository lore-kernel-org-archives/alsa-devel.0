From: "vasudha rao" <vasudha.jrao@gmail.com>
Subject: Re: Unable to play aplay
Date: Thu, 11 Sep 2008 10:07:43 +0530
Message-ID: <eeb9eca50809102137s6047fb36pe49bb47cf973f208@mail.gmail.com>
References: <eeb9eca50809100546w5475ebffqafd3d1e8224206c0@mail.gmail.com>
	<2ee9e08d0809101124t76b0aca9n314185c989a50019@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id E0BE12417D
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Sep 2008 06:37:47 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so170387rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2008 21:37:43 -0700 (PDT)
In-Reply-To: <2ee9e08d0809101124t76b0aca9n314185c989a50019@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: aggarwal <anuj.aggarwal@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Anuj,

Nodes were not there before..I created now..

Now when I did $aplay -l ,
I got,

 **** List of PLAYBACK Hardware Devices ***
*ALSA lib control.c:739:(snd_ctl_open_noupdate) Invalid CTL hw:0
aplay: device_list:208: control open (0): No such file or directory
aplay: conf.c:3083: snd_config_update_free: Assertion `update->count > 0 &&
update->finfo' failed.Aborted

Where I am doing wrong..??













Thank you..







On Wed, Sep 10, 2008 at 11:54 PM, anuj aggarwal <anuj.aggarwal@gmail.com>wrote:

> Vasudha,
>
> Could you please check the device nodes in /dev/snd folder? The
> desired output is:
>
> [root@ /home]# ls -l /dev/snd/
> crw-rw----    1 root     root     116,   5 Jan  1 00:00 controlC0
> crw-rw----    1 root     root     116,   4 Jan  1 00:00 pcmC0D0c
> crw-rw----    1 root     root     116,   3 Jan  1 00:00 pcmC0D0p
>
> If the nodes are not there, you have to create them first before trying
> aplay.
>
> Regards,
> Anuj
>
>
> On Wed, Sep 10, 2008 at 6:16 PM, vasudha rao <vasudha.jrao@gmail.com>
> wrote:
> >
> > Hi ,
> >
> > I want to play and record audio file in my custom atmel 9263 board
> running
> > with linux(2.6.20).
> > when I tried to play aplay for a wave file, I got
> >
> > $aplay /home/alarm.wav
> > ALSA lib pcm.c:1707:(snd_pcm_open_noupdate) Unknown PCM default
> > aplay: main:446: audio open error: No such file or directory
> >
> > $aplay -l
> > aplay: device_list:187: no soundcards found...
> >
> > $cat /proc/asound/devices
> >  2:        : timer
> >  3:        : sequencer
> >  4: [ 0- 0]: digital audio playback
> >  5: [ 0]   : control
> >
> > Can you tel me where I am doing wrong..??
> >
> > Thanks in advance..
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>
> --
> Best Regards,
> Anuj Aggarwal
>
