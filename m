From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: Midisport 2x2 spawns before Alsa, taking the device0 slot event though modules.conf puts snd-usb-midi as 3rd device -> result potential hardlocks when opening dsp
Date: Tue, 25 Feb 2003 18:28:16 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000101c2dd25$92a96a60$aa1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: 
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Forgot to include my modules.conf, so here it is:

#load hdsp mem before everything else
options snd-hammerfall-mem enable=1
options snd-hdsp line_outs_monitor=1

alias net-pf-4 ipx
alias autofs autofs4
probeall scsi_hostadapter ide-scsi
alias eth0 3c59x
#alias sound-slot-0 i810_audio
alias ieee1394-controller ohci1394
alias /dev/nvidia*   NVdriver

# ALSA portion
alias char-major-116 snd
alias char-major-14 soundcore
alias snd-card-0 snd-intel8x0
alias snd-card-1 snd-hdsp
alias snd-card-2 snd-usb-midi
options snd major=116 cards_limit=4 device_mode=0666 device_gid=0
device_uid=0
options snd-usb-midi vid=0x763 pid=0x1001 index=1

# OSS/Free portion
# CS4205
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
#alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
#alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

#HDSP
alias sound-slot-1 snd-card-1
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-1 snd-seq-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-8 snd-seq-oss
alias sound-service-1-12 snd-pcm-oss

#MIDISPORT
alias sound-service-2-1 snd-seq-oss
alias sound-service-2-8 snd-seq-oss

probeall usb-interface usb-uhci
#thought if I did usb-interface last that it would be superseded by
#the alsa, but that did not work



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
