From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: syslog requested reporting this to ALSA developers
 (ubuntu 10.04 inside virtualbox)
Date: Sat, 19 Mar 2011 06:58:26 +0800
Message-ID: <AANLkTimQZFyYY4wFU-kq7S9qnN0P3Q6w3tcN1UcWVXDF@mail.gmail.com>
References: <AANLkTingNU5fuLRQ0+-_ugqRtqdj8bd_-MWhaP3Ag5-h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8218F103A0F
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 23:58:29 +0100 (CET)
Received: by fxm6 with SMTP id 6so3947052fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 15:58:27 -0700 (PDT)
In-Reply-To: <AANLkTingNU5fuLRQ0+-_ugqRtqdj8bd_-MWhaP3Ag5-h@mail.gmail.com>
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

2011/3/18 Jason E. Aten <j.e.aten@gmail.com>

> from my syslog, it requests a report to ALSA developers. Let me know if I
> can provide further assistance. -Jason
>
> $ tail /var/log/syslog
> Mar 17 13:58:25 virtub pulseaudio[1038]: alsa-source.c: ALSA woke us up to
> read new data from the device, but there was actually nothing to read!
> Mar 17 13:58:25 virtub pulseaudio[1038]: alsa-source.c: Most likely this is
> a bug in the ALSA driver 'snd_intel8x0'. Please report this issue to the
> ALSA developers.
>


> Mar 17 13:58:29 virtub gdm-session-worker[1030]: GLib-GObject-CRITICAL:
> g_value_get_boolean: assertion `G_VALUE_HOLDS_BOOLEAN (value)' failed
> Mar 17 13:58:35 virtub rtkit-daemon[1043]: Sucessfully made thread 1256 of
> process 1256 (n/a) owned by '1000' high priority at nice level -11.
> Mar 17 13:58:35 virtub rtkit-daemon[1043]: Supervising 4 threads of 2
> processes of 2 users.
> Mar 17 13:58:35 virtub pulseaudio[1256]: alsa-util.c: Disabling timer-based
> scheduling because running inside a VM.
>

Architecture: amd64

It seem that pulseaudio server think that it is running inside a VM  ?

are you running qemu or virtualbox ?

What is the onboard sound card in your AMD64 ?
