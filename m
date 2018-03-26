From: frederik@ofb.net
Subject: two cards as one [frederik@ofb.net: [Alsa-user] the
 mythical "el-cheapo"]
Date: Mon, 26 Mar 2018 16:58:07 -0700
Message-ID: <20180326235807.GA21205@ofb.net>
Reply-To: frederik@ofb.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from so254-26.mailgun.net (so254-26.mailgun.net [198.61.254.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A920267076
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 01:58:10 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear ALSA devel,

I'm forwarding a message I sent to ALSA-user a week ago; it didn't get
any replies. It asks some questions about combining stereo devices
into a single multi-channel device. Is this the right place to ask?
I'll summarize because maybe the original message was a bit verbose:

1. Is this document still correct (i.e. saying that ALSA doesn't do
any resampling when you combine two devices in a "multi"
configuration):
https://github.com/opensrc/alsa/blob/master/lib/md/TwoCardsAsOne.md

2. What is the best way to combine output devices? Pulseaudio?

3. Is there a way to configure an ALSA pcm which routes to a
non-default Pulseaudio sink?

Thanks,

Frederick

----- Forwarded message from frederik@ofb.net -----

Date: Mon, 19 Mar 2018 19:10:47 -0700
From: frederik@ofb.net
To: alsa-user@lists.sourceforge.net
Subject: [Alsa-user] the mythical "el-cheapo"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,
	SPF_HELO_PASS,SPF_PASS,T_DKIM_INVALID autolearn=unavailable
	autolearn_force=no version=3.4.1
X-Spam-Level: 
User-Agent: Mutt/1.9.4 (2018-02-28)
X-My-Message-ID: <20180320021047.GA4304@ofb.net>#2
X-My-Tags: inbox alsa-user

Dear ALSA user,

I am trying to develop some software to use for a custom sound-masking
system where I live (to e.g. mask the sound of construction beeping
going on outside). It is crucial to have more than two speakers,
because if you can tell where the noise is coming from then it becomes
distracting. But I would want this to be an inexpensive solution for
students and such and so I don't want to depend on a surround sound
system being present. So currently I'm using three $7 USB stereo sound
adapters, which control six speakers.

For various reasons it would be good for me to be able to combine the
USB cards into one audio device. One reason is that users might want
to play music on the same speakers that they're using for
sound-masking. Another is that having one device with one sample rate
would simplify the coding of the noise generation, which might be
based on some adaptive algorithm that e.g. listens to a microphone
signal, and which might be written in a high-level language where
threads are inefficient.

However, there are a few documents discouraging me from trying to
combine devices in ALSA, saying "you will drift out of sync over time"
because of differences in the crystals of the various sound cards.

https://www.alsa-project.org/main/index.php/Asoundrc#Virtual_multi_channel_devices
https://github.com/opensrc/alsa/blob/master/lib/md/TwoCardsAsOne.md

But they describe a "route/multi" configuration using ALSA which often
seems to work OK for me. For example, I can generate six independent
pink noise streams with SoX and it doesn't usually sound glitchy:

AUDIODEV=noise play -c 6 -r 44100 -n synth pinknoise gain -10 channels 6

Music also seems to play OK. I've experienced glitches with movie
audio, which resolve when I pause/unpause, but sometimes these issues
seemed to persist even when I routed the movie audio to a single pair
of speakers. I never tracked down the problem but I thought it might
be a sample rate issue.

Pulseaudio advertises the ability to combine devices correctly using
module-combine-sink which tracks the actual frequencies of the various
sink crystals:

https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#index11h3

However, the pulseaudio latency is very high and it makes movie audio
out of sync with the picture. Furthermore, it seems difficult to use
with ALSA because the "pulse" ALSA module doesn't seem to take a
parameter which would let me specify which pulse sink or source I am
interested in. Thus it seems impossible to use ALSA programs like
SoX's play command (above) to output to a non-default Pulseaudio sink.
Is this correct?

I want to be able to write software which other people can easily
install and which can coexist alongside other software they have
installed, including audio software. For example I don't want my
system to force them to adopt a certain Pulseaudio sink as "default".
Even depending on Pulseaudio seems somewhat undesirable. But since I
lack familiarity with audio software, I am hoping someone on this list
can point me to useful projects or sources of information so that I
can solve these problems in a standard way, and produce software that
might actually end up being useful to others.

Thank you,

Frederick Eaton

pcm.mix1 {
    type dmix
    ipc_key 2852 # must be unique
    slave {
        pcm "hw:3"
        </home/frederik/hw-settings>
}
}

pcm.mix2 {
    type dmix
    ipc_key 2853
    slave {
        pcm "hw:1"
        </home/frederik/hw-settings>
    }
}

pcm.mix3 {
    type dmix
    ipc_key 2842 # must be unique
    slave {
        pcm "hw:0"
        </home/frederik/hw-settings>
}
}

pcm.multi_mix {
    type multi;
    slaves.a.pcm "mix1";
    slaves.b.pcm "mix2";
    slaves.c.pcm "mix3";
    slaves.a.channels 2;
    slaves.b.channels 2;
    slaves.c.channels 2;
    bindings.0.slave a;
    bindings.0.channel 0;
    bindings.1.slave a;
    bindings.1.channel 1;

    bindings.2.slave b;
    bindings.2.channel 0;
    bindings.3.slave b;
    bindings.3.channel 1;

    bindings.4.slave c;
    bindings.4.channel 0;
    bindings.5.slave c;
    bindings.5.channel 1;
}
# pcm.multi_mix {
#     type multi;
#     slaves.a.pcm "mix2";
#     slaves.b.pcm "mix1";
#     slaves.a.channels 2;
#     slaves.b.channels 2;
#     bindings.0.slave a;
#     bindings.0.channel 0;
#     bindings.1.slave a;
#     bindings.1.channel 1;

#     bindings.2.slave b;
#     bindings.2.channel 0;
#     bindings.3.slave b;
#     bindings.3.channel 1;
# }

pcm.upmix {
    type route;
    slave.pcm "multi_mix";

    ttable.0.0 1;
    ttable.1.1 1;

    ttable.0.2 1;
    ttable.1.3 1;

    ttable.0.4 1;
    ttable.1.5 1;
}
# pcm.upmix {
#     type route;
#     slave.pcm "multi_mix";

#     ttable.0.0 1;
#     ttable.1.1 1;

#     ttable.0.2 1;
#     ttable.1.3 1;
# }

pcm.noise {
    type softvol
    ## FHE 01 Mar 2018
    # why is plug: needed here? if i put plug:multi_mix in the upmix
    # device it breaks
    slave.pcm "plug:multi_mix"
    control {
        name "Noise"
        card 1
    }
}

ctl.noise {
    type hw
    card 1
}

pcm.music {
    type softvol
#    slave.pcm "plug:mix1"
    slave.pcm "plug:upmix"

    ## the following gives "invalid argument", why?
     # slave {
     #       pcm "upmix";
     #       channels 2;
     # }
     
    control {
        name "Music"
        card 1
    }
}

ctl.music {
    type hw
    card 1
}

pcm.music_no_bass {
    type plug;
    slave.pcm {
        type ladspa
    #    slave.pcm "plughw:0,0";
        slave.pcm "plug:music";
        path "/usr/lib/ladspa/";
        plugins [{
            label hpf
            input {
                controls [ 1000 ]
            }
        }]
        hint {
            show on
            description "Highpass filter for music"
        }
    }
}

# pcm.!default {
# type asym
# #playback.pcm "music"
# playback.pcm "plug:music_no_bass"
# #playback.pcm "plug:hw0mix"
# capture.pcm "hw:0"
# }

# FHE 10 Mar 2018
## we need an "asym" with capture and playback to make pulseaudio happy
pcm.!default {
    type asym
    playback.pcm {
    ## from https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture/Example_Configurations
    # set the default device according to the environment
    # variable ALSA_DEFAULT_PCM and default to plug:music_no_bass
        @func refer
        name { @func concat
            strings [ "pcm."
                      { @func getenv
                              vars [ ALSA_DEFAULT_PCM ]
                              default "music_no_bass"
                              }
            ]
        }
    }
    capture.pcm "hw:0"
}

# FHE 10 Mar 2018 old version
## FHE 01 Mar 2018
# pcm.!default {
#     @func refer
#     name { @func concat
#            strings [ "pcm."
#                      { @func getenv
#                        vars [ ALSA_DEFAULT_PCM ]
#                        default "music_no_bass"
#                      }
#            ]
#          }
# }

        rate 44100
        format S16_LE

## FHE 01 Mar 2018
# Eshelman's settings
       period_time 0
       period_size 2048
       buffer_size 65536
       buffer_time 0
       periods 128

## overrides
# https://www.alsa-project.org/main/index.php/FramesPeriods
# buffer size must be >= 2*period_size*(channels*bytes)
#    = 8*period_size
# interrupt frequency is period_size * rate
# we seem to get errors with period_size <= 256
# these settings seem to increase CPU usage only slightly, e.g. from
# 5.3% (for above settings) to 7.3% (for below) with mpv
       # period_size 512
       # buffer_size 4096
       # period_size 1024
       # buffer_size 8192
# This will cause the device to interrupt 86 times per second


#!/bin/zsh

#front-left,front-right,rear-left,rear-right,front-center,lfe

pacmd load-module module-alsa-sink device=mix1 sink_name=mix1 channels=2 channel_map=front-left,front-right
pacmd load-module module-alsa-sink device=mix2 sink_name=mix2 channels=2 channel_map=rear-left,rear-right
pacmd load-module module-alsa-sink device=mix3 sink_name=mix3 channels=2 channel_map=front-center,lfe

pacmd load-module module-combine-sink sink_name=mix123 slaves=mix1,mix2,mix3 channels=6 channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user


----- End forwarded message -----
