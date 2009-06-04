From: Santo Chow <santo_chow@yahoo.com>
Subject: [HELP] snd-aloop with dmix?
Date: Wed, 3 Jun 2009 20:51:36 -0700 (PDT)
Message-ID: <754252.87488.qm@web110803.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web110803.mail.gq1.yahoo.com (web110803.mail.gq1.yahoo.com
	[67.195.13.226]) by alsa0.perex.cz (Postfix) with SMTP id 0B01C103806
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 05:51:38 +0200 (CEST)
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

HI all,

I'm trying to use snd-aloop as my default soundard. I have the .asoundrc that look like this.

pcm.sndcard{
    type hw
    card 1        #snd-aloop soundcard
    device 0
}

pcm.dmixer {
    type dmix
    ipc_key 1025
    ipc_perm 0660
    slave {
        pcm sndcard
        period_time 0
        period_size 881
        buffer_size 3524
        rate 44100
    }

    bindings {
               0 0
               1 1
       }
}

pcm.dsnooper {
    type dsnoop
    ipc_key 1026
    ipc_perm 0660
    slave {
        pcm sndcard
        period_time 0
        period_size 881
        buffer_size 3524
        rate 44100
    }

    bindings {
               0 0
               1 1
       }

}

pcm.duplexasym {
    type asym
    playback.pcm "dmixer"   # playback
    capture.pcm "dsnooper"  # capture
}

pcm.!default {
    type plug
    slave {
        pcm duplexasym
    }
}

ctl.duplex {
    type hw
    card 1
}

Right now my problem is, i can only get 1 sound from an application at a time. I can't run several applications at the same time and recorded all the sounds.

This is what I did :

My default sound card is indexed at 0, so the snd-aloop will be at index 1. To test this, I first run an MP3 player. Then I run this in terminal:

arecord -D hw:1,1 -f cd | aplay -D hw:0 -f cd

The sound come out good.

Then when I open a browser, go to youtube and play a song over there, the sound won't come out. I have to first close the browser and the currently playing MP3 player, then re-open a browser, go to youtube, and play a song, the sound will come out.

So, my question is.. is there something missing in my .asoundrc file? can the snd-aloop support multiple playbacks and captures at the same time? is there a way for me to achieve this?
