From: Vincent Meserette <vmeserette@aldebaran-robotics.com>
Subject: how to link multi plugin to dsnoop ?
Date: Wed, 11 May 2011 15:35:39 +0200
Message-ID: <BANLkTinPN1Whe-0u53S7MD81a018eZukrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4520A103849
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 15:35:40 +0200 (CEST)
Received: by gyg8 with SMTP id 8so178286gyg.38
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2011 06:35:39 -0700 (PDT)
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

Hi all,

I would like to allow multiple applications to access the audio inputs and
outputs of my system at same time.
I succeded to make it for the audio outputs by using the dmix plugin, but I
don't know how to do it with the dsnoop plugin because it seems I cannot
link directly the multi plugin to dsnoop.
Here is the error message I have with the /etc/asound.conf file presented
below :

arecord -D"alduplex" -c4 -r48000 -fS16_LE /tmp/test.wav
ALSA lib pcm_direct.c:1490:(_snd_pcm_direct_get_slave_ipc_offset) Invalid
type 'multi' for slave PCM
arecord: main:654: audio open error: Invalid argument

Does someone know how can I route the multi plugin to dsnoop ?

Thanks in advance

My /etc/asound.conf file :

#output device
pcm.AD1989A_outputs{
    type hw
    card 0
}

pcm.aldmix{
    type dmix
     ipc_key 1024
    ipc_perm 0666
    slave{
        pcm AD1989A_outputs
    }

}

#input device
pcm.4channelsDeinterleaved {
        type multi

        slaves.a.pcm "hw:0,0,0"
        slaves.a.channels 2
        slaves.b.pcm "hw:0,0,2"
        slaves.b.channels 2

        bindings.0.slave a
        bindings.0.channel 0
        bindings.1.slave a
        bindings.1.channel 1
        bindings.2.slave b
        bindings.2.channel 0
        bindings.3.slave b
        bindings.3.channel 1
}

pcm.AD1989A_inputs {
        type route
        slave.pcm "4channelsDeinterleaved"
        ttable.0.0 1
        ttable.1.1 1
        ttable.2.2 1
        ttable.3.3 1
}

#4 channels dsnoop (plug-in for capture)
pcm.aldsnoop{
    type dsnoop
    ipc_key 1025
        ipc_perm 0666
    slave{
        pcm AD1989A_inputs
        rate 48000
        channels 4
    }

}

pcm.alduplex {
    type asym
    capture.pcm "aldsnoop"
    playback.pcm "aldmix"
}

### CTL DEVICES (controls)
ctl.mixer0 {
    type hw
    card 0
}
