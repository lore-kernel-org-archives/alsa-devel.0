From: Keith Chew <keith.chew@gmail.com>
Subject: PCM multi A/V Sync bug on SMP system
Date: Sun, 25 Apr 2010 17:07:45 +1200
Message-ID: <n2i20f65d531004242207zde83c421gac35d243420dcaff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BB4BD24610
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Apr 2010 07:07:46 +0200 (CEST)
Received: by gwb19 with SMTP id 19so314719gwb.38
	for <alsa-devel@alsa-project.org>; Sat, 24 Apr 2010 22:07:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I have a SB Audigy Value card with 5.1 channel output. This is defined
in my asound.conf:
---------------------------
pcm.multi {
    type    multi
    slaves {
        a.pcm        "dmixerrear"
        a.channels   2
        b.pcm        "dmixerfront"
        b.channels   2
        c.pcm        "dmixercenter"
        c.channels   2
    }
    bindings {
        0.slave      a
        0.channel    0
        1.slave      a
        1.channel    1
        2.slave      b
        2.channel    0
        3.slave      b
        3.channel    1
        4.slave      c
        4.channel    0
        5.slave      c
        5.channel    1
    }
}

    pcm.dmixerfront  {
        type dmix
        ipc_key 1024
        slave {
            pcm "hw:0,0"
            channels 2
        }
    }

    pcm.dmixerrear  {
        type dmix
        ipc_key 1025
        slave {
            pcm "hw:0,1"
            channels 2
        }
    }
    pcm.dmixercenter  {
        type dmix
        ipc_key 1026
        slave {
            pcm "hw:0,2"
            channels 2
        }
    }
---------------------------

Playing a video with "mplayer -ao alsa:device=multi ..." works fine, I
can hear the 6-channel audio without any A/V sync issues. However,
this is on a uniprocessor system. On an SMP system, the A/V sync gets
out of sync from the start and drifts quite quickly.

I have narrowed it down to the pcm_multi component giving this
problem. On an SMP system, using just "mplayer -ao alsa ..." gives no
A/V sync issues (because it is not using multi) on the 6 channels.
Moreover, I have also tried "mplayer -ao alsa:device=dmixerfront ...",
"mplayer -ao alsa:device=dmixercenter ..." and "mplayer -ao
alsa:device=dmixerrear ...", all giving no A/V sync issues on the
individual devices.

Please advise how can I track down this problem in code, happy to make
changes and test.

PS: I need multi to work, so that I can add additional options like
softvol on top of it.

Regards
Keith
