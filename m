From: feng_tian <feng_tian@126.com>
Subject: can't use dmixer
Date: Wed, 5 Dec 2007 14:23:56 +0800 (CST)
Message-ID: <18616081.324771196835836994.JavaMail.coremail@bj126app88.126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m15-88.126.com (m15-88.126.com [220.181.15.88])
	by alsa0.perex.cz (Postfix) with SMTP id F107210392F
	for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2007 07:23:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, alsa-user <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi, all:
I have a problem with dmix of alsa. 
I'm using alsa v1.0.11rc2 now. And make it running on ATMEL AT91SAM9260EK board. It runs ok without Dmix. But when I tried:
bash> aplay -D dmixer test.wav
The errors are:

ALSA lib pcm_direct.c:790:(snd_pcm_direct_initialize_slave) slave plugin does not support mmap interleaved or mmap noninterleaved access
ALSA lib pcm_dmix.c:864:(snd_pcm_dmix_open) unable to initialize slave
aplay: main:547: audio open error: Invalid argument

The configuration of my alsa in /etc/asound.con is:

pcm.card0 {
	type hw
	card 0
	}
	
pcm.!default {
	type plug
	slave.pcm "dmixer"
	}
	
pcm.dmixer {
	type dmix
	ipc_key 1024
	slave {
		pcm "hw:0,0"
		format S16_LE
		period_time 0
		period_size 1024
		buffer_size 4096
		
		rate 22050 
		}
	bindings {
		0 0
		1 1
		}
	}
ctl.dmixer {
	type hw
	card 0
	device 0
	}
pcm.dsp {
	type plug
	slave.pcm "dmixer" #use our new PCM here
	}
ctl.mixer{
	type hw
	card 0
	}
bash> aplay -L
gives:

PCM list:
hw {
	@args.0 CARD
	@args.1 DEV
	@args.2 SUBDEV
	@args.CARD {
		type string
		default {
			@func getenv
			vars {
				0 ALSA_PCM_CARD
				1 ALSA_CARD
			}
			default {
				@func refer
				name 'defaults.pcm.card'
			}
		}
	}
	@args.DEV {
		type integer
		default {
			@func igetenv
			vars {
				0 ALSA_PCM_DEVICE
			}
			default {
				@func refer
				name 'defaults.pcm.device'
			}
		}
	}
	@args.SUBDEV {
		type integer
		default {
			@func refer
			name 'defaults.pcm.subdevice'
		}
	}
	type hw
	card $CARD
	device $DEV
	subdevice $SUBDEV
}
plughw {
	@args.0 CARD
	@args.1 DEV
	@args.2 SUBDEV
	@args.CARD {
		type string
		default {
			@func getenv
			vars {
				0 ALSA_PCM_CARD
				1 ALSA_CARD
			}
			default {
				@func refer
				name 'defaults.pcm.card'
			}
		}
	}
	@args.DEV {
		type integer
		default {
			@func igetenv
			vars {
				0 ALSA_PCM_DEVICE
			}
			default {
				@func refer
				name 'defaults.pcm.device'
			}
		}
	}
	@args.SUBDEV {
		type integer
		default {
			@func refer
			name 'defaults.pcm.subdevice'
		}
	}
	type plug
	slave.pcm {
		type hw
		card $CARD
		device $DEV
		subdevice $SUBDEV
	}
}
plug {
	@args.0 SLAVE
	@args.SLAVE {
		type string
	}
	type plug
	slave.pcm $SLAVE
}
shm {
	@args.0 SOCKET
	@args.1 PCM
	@args.SOCKET {
		type string
	}
	@args.PCM {
		type string
	}
	type shm
	server $SOCKET
	pcm $PCM
}
tee {
	@args.0 SLAVE
	@args.1 FILE
	@args.2 FORMAT
	@args.SLAVE {
		type string
	}
	@args.FILE {
		type string
	}
	@args.FORMAT {
		type string
		default raw
	}
	type file
	slave.pcm $SLAVE
	file $FILE
	format $FORMAT
}
file {
	@args.0 FILE
	@args.1 FORMAT
	@args.FILE {
		type string
	}
	@args.FORMAT {
		type string
		default raw
	}
	type file
	slave.pcm null
	file $FILE
	format $FORMAT
}
null {
	type null
}
cards 'cards.pcm'
front 'cards.pcm.front'
rear 'cards.pcm.rear'
center_lfe 'cards.pcm.center_lfe'
side 'cards.pcm.side'
surround40 'cards.pcm.surround40'
surround41 'cards.pcm.surround41'
surround50 'cards.pcm.surround50'
surround51 'cards.pcm.surround51'
surround71 'cards.pcm.surround71'
iec958 'cards.pcm.iec958'
spdif 'cards.pcm.iec958'
modem 'cards.pcm.modem'
phoneline 'cards.pcm.phoneline'
dmix 'cards.pcm.dmix'
dsnoop 'cards.pcm.dsnoop'
card0 {
	type hw
	card 0
}
default {
	type plug
	slave.pcm dmixer
}
dmixer {
	type dmix
	ipc_key 1024
	slave {
		pcm 'hw:0,0'
		format S16_LE
		period_time 0
		period_size 1024
		buffer_size 4096
		rate 22050
	}
	bindings {
		0 0
		1 1
	}
}
dsp {
	type plug
	slave.pcm dmixer
}
Is there anyone experienced in this kind of error?  Any helps or advices is wecome.

BR
Feng
