From: Garett Shulman <shulmang@colorado.edu>
Subject: envy24 cant open more than one mixer channel
Date: Tue, 18 Nov 2003 10:47:41 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBA5B3D.8020705@colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello, I can't seem to open more than one mixer output device on my 
envy24 card at a time. If one of the following apps is used with say 
44channel1 and another of them tries to open 44channel2 I get the 
following behavior.

Fluidsynth gives the following error:
ALSA lib pcm_hw.c:1055:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: 
Device or resource busy

mplayer just blocks

and xmms complains that it cant open the output device.

Any ideas are greatly appreciated. Here is my asound.conf, and my 
mondules.conf alsa stuff is below that. I get the same behavior with or 
without modules.conf entries for alsa. Also, I am only loading 
snd-ice1712 not snd-pcm-oss or snd-seq-oss. Thanks a lot. -Garett

pcm.delta44 {
type hw
card 0
device 0
}

pcm.delta2496 {
type hw
card 1
device 0
}

pcm.44channel1 {
type plug
ttable.0.0 1 # (monitor bedroom ...
ttable.0.1 1 # (monitor bedroom ...
slave.pcm delta44
}

pcm.44channel2 {
type lpug
ttable.0.2 1 # (studio monitor ...
ttable.0.3 1 # (studio monitor ...
slave.pcm delta44
}

pcm.44channel3 {
type plug
ttable.0.4 1 # (virtual ...
ttable.0.5 1 # (virtual ...
slave.pcm delta44
}

pcm.44channel4 {
type plug
ttable.0.6 1 # ...
ttable.0.7 1 # ...
slave.pcm delta44
}
pcm.44 channel5 {
type plug
ttable.0.8.1 # ...
ttable.1.9 1 # ...
slave.pcm delta44
}

pcm.44mon_mix {
type plug
ttable.0.10 1 # ...
ttable.1.11 1 # ...
slave.pcm delta44
}

pcm.multi_send {
type plug
ttable.0.0 1 # ...
ttable.0.1 1 # ...
ttable.0.4 1 # ...
ttable.0.5 1 # ...
ttable.0.6 1 # ...
ttable.0.7 1 # ...
slave.pcm delta44
}

pcm.2496channel1 {
type plug
ttable.0.0 1 # ...
ttable.0.1 1 # ...
slave.pcm delta2496
}

pcm.2496channel2 {
type plug
ttable.0.2 1 # ...
ttable.0.3 1 # ...
slave.pcm delta2496
}

pcm.2496channel3 {
type plug
ttable.0.4 1 # ...
ttable.0.5 1 # ...
slave.pcm delta2496
}

pcm.2496channel4 {
type plug
ttable.0.6 1 # ...
ttable.0.7 1 # ...
slave.pcm delta2496
}

pcm.2496_spdif {
type plug
ttable.0.8 1 # ...
ttable.1.9 1 # ...
slave.pcm delta2496
}

pcm.2496mon_mix {
type plug
ttable.0.10 1 # ...
ttable.1.11 1 # ...
slave.pcm delta2496
}

my modules.conf contains:

# ALSA portion
alias char-major-116 snd
alias snd-card-0 snd-ice1712
alias snd-card-1 snd-ice1712





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
