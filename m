From: "anuj aggarwal" <anuj.aggarwal@gmail.com>
Subject: Re: Unable to play aplay
Date: Wed, 10 Sep 2008 23:54:13 +0530
Message-ID: <2ee9e08d0809101124t76b0aca9n314185c989a50019@mail.gmail.com>
References: <eeb9eca50809100546w5475ebffqafd3d1e8224206c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 43CC224464
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Sep 2008 20:24:15 +0200 (CEST)
Received: by gv-out-0910.google.com with SMTP id i36so688302gve.24
	for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2008 11:24:14 -0700 (PDT)
In-Reply-To: <eeb9eca50809100546w5475ebffqafd3d1e8224206c0@mail.gmail.com>
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
To: vasudha rao <vasudha.jrao@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Vasudha,

Could you please check the device nodes in /dev/snd folder? The
desired output is:

[root@ /home]# ls -l /dev/snd/
crw-rw----    1 root     root     116,   5 Jan  1 00:00 controlC0
crw-rw----    1 root     root     116,   4 Jan  1 00:00 pcmC0D0c
crw-rw----    1 root     root     116,   3 Jan  1 00:00 pcmC0D0p

If the nodes are not there, you have to create them first before trying aplay.

Regards,
Anuj


On Wed, Sep 10, 2008 at 6:16 PM, vasudha rao <vasudha.jrao@gmail.com> wrote:
>
> Hi ,
>
> I want to play and record audio file in my custom atmel 9263 board running
> with linux(2.6.20).
> when I tried to play aplay for a wave file, I got
>
> $aplay /home/alarm.wav
> ALSA lib pcm.c:1707:(snd_pcm_open_noupdate) Unknown PCM default
> aplay: main:446: audio open error: No such file or directory
>
> $aplay -l
> aplay: device_list:187: no soundcards found...
>
> $cat /proc/asound/devices
>  2:        : timer
>  3:        : sequencer
>  4: [ 0- 0]: digital audio playback
>  5: [ 0]   : control
>
> Can you tel me where I am doing wrong..??
>
> Thanks in advance..
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



--
Best Regards,
Anuj Aggarwal
