From: Kristof Pelckmans <kristof.pelckmans@antwerpen.be>
Subject: [BUG] Delta 410 support broken from 0.9.8 -> 1.0.0rc2
Date: Fri,  2 Jan 2004 14:29:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040102142918.ng0s8ooo4488cwcc@albert.homedns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I tried out version 1.0.0rc2 on my M-Audio Delta 410 and all I hear is a series
of pops when I play a sound.

In 0.9.8 everything is perfect.

Do I have to pass some new parameter to the ice1712 module ?

Kind regards,

Kristof

-- ouput aplay --
aplay -Ddelta410p -v /usr/lib/xcdroast-0.98/sound/test.wav
Playing WAVE '/usr/lib/xcdroast-0.98/sound/test.wav' : Signed 16 bit Little
Endian, Rate 44100 Hz, Stereo
Plug PCM: Route conversion PCM (sformat=S32_LE)
Transformation table:
0 <- 0
1 <- 1
2 <- none
3 <- none
4 <- none
5 <- none
6 <- none
7 <- none
8 <- none
9 <- none
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 6553
period_size  : 3276
period_time  : 74285
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 3276
xfer_align   : 3276
start_threshold  : 6552
stop_threshold   : 6553
silence_threshold: 0
silence_size : 0
boundary     : 1717829632
Slave: Hardware PCM card 0 'M Audio Delta 410' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 10
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 24
buffer_size  : 6553
period_size  : 3276
period_time  : 74285
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 3276
xfer_align   : 3276
start_threshold  : 6552
stop_threshold   : 6553
silence_threshold: 0
silence_size : 0
boundary     : 1717829632

-- asound.conf --
pcm_slave.delta_s {
        pcm delta410
}

pcm.delta410 {
        type hw
        card 0
}

ctl.delta410 {
        type hw
        card 0
}

pcm.delta410p {
        type plug
        slave delta_s
}

ctl.delta410p {
        type hw
        card 0
}

-- /etc/modules.d/alsa --
# Alsa 0.9.X kernel modules' configuration file.
# $Header:
/home/cvsroot/gentoo-x86/media-sound/alsa-driver/files/alsa-modules.conf-rc,v
1.1 2002/12/21 06:31:52 agenkin Exp $

# ALSA portion
alias char-major-116 snd
# Set this to the correct number of cards.
options snd cards_limit=2

# OSS/Free portion
alias char-major-14 soundcore

#
# IMPORTANT:
# You need to customise this section for your specific sound card(s)
# and then run `update-modules' command.
# Read alsa-driver's INSTALL file in /usr/share/doc for more info.
#
#  ALSA portion
alias snd-card-0 snd-ice1712
alias snd-card-1 snd-intel8x0
#alias snd-card-1 snd-ens1371
#alias snd-card-2 snd-ens1371
#  OSS/Free portion
alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1
#alias sound-slot-2 snd-card-2

# OSS/Free portion - card #1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
# OSS/Free portion - card #2
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-1 snd-seq-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-8 snd-seq-oss
alias sound-service-1-12 snd-pcm-oss
# OSS/Free portion - card #2
#alias sound-service-2-0 snd-mixer-oss
#alias sound-service-2-1 snd-seq-oss
#alias sound-service-2-3 snd-pcm-oss
#alias sound-service-2-8 snd-seq-oss
#alias sound-service-2-12 snd-pcm-oss

alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
#alias /dev/midi snd-seq-oss



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
