From: Julian Scheel <julian@jusst.de>
Subject: Updated ICE1724.conf
Date: Sat, 30 Jul 2005 16:15:18 +0200
Message-ID: <200507301615.18765.julian@jusst.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2t46C0Y06x4pDpe"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

--Boundary-00=_2t46C0Y06x4pDpe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

attached is an updated ICE1724.conf - I have added channels X parameters to 
the .pcm.surroundXX-fields, because otherwise it's for example not possible 
to play a 5.1-stream on surround51 and a stereo-stream on side simultaneous.
I need this feature to do multiroom-sound through one single sound-card (one 
room playing a DVD with 5.1, another room playing some MP3s through channels 
7 and 8).
I hope you could follow my explanations and will add this to the tree.

Cheers,
Julian

--Boundary-00=_2t46C0Y06x4pDpe
Content-Type: text/plain;
  charset="us-ascii";
  name="ICE1724.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ICE1724.conf"

#
# Configuration for the ICE1724 (Envy24HT) chip
#

<confdir:pcm/front.conf>

ICE1724.pcm.front.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hw
	card $CARD
}	

<confdir:pcm/rear.conf>

ICE1724.pcm.rear.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hw
	card $CARD
	device 2
	subdevice 0
}	

<confdir:pcm/center_lfe.conf>

ICE1724.pcm.center_lfe.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hw
	card $CARD
	device 2
	subdevice 1
}	

<confdir:pcm/side.conf>

ICE1724.pcm.side.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hw
	card $CARD
	device 2
	subdevice 2
}

<confdir:pcm/surround40.conf>

ICE1724.pcm.surround40.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type route
	ttable.0.0 1
	ttable.1.1 1
	ttable.2.4 1
	ttable.3.5 1
	slave {
		channels 4
		pcm {
			type hw
			card $CARD
		}
	}
}	

<confdir:pcm/surround41.conf>
<confdir:pcm/surround50.conf>
<confdir:pcm/surround51.conf>

ICE1724.pcm.surround51.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type route
	ttable.0.0 1
	ttable.1.1 1
	ttable.2.4 1
	ttable.3.5 1
	ttable.4.2 1
	ttable.5.3 1
	slave {
		channels 6
                pcm {
			type hw
	 		card $CARD
		}
	}
}

<confdir:pcm/surround71.conf>

ICE1724.pcm.surround71.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type route
	ttable.0.0 1
	ttable.1.1 1
	ttable.2.4 1
	ttable.3.5 1
	ttable.4.2 1
	ttable.5.3 1
	ttable.6.6 1
	ttable.7.7 1
	slave {
		channels 8
		pcm {
			type hw
			card $CARD
		}
	}
}

<confdir:pcm/iec958.conf>

ICE1724.pcm.iec958.0 {
	@args [ CARD AES0 AES1 AES2 AES3 ]
	@args.CARD {
		type string
	}
	@args.AES0 {
		type integer
	}
	@args.AES1 {
		type integer
	}
	@args.AES2 {
		type integer
	}
	@args.AES3 {
		type integer
	}
	type asym
	playback.pcm {
		type hooks
		slave.pcm {
			type hw
			card $CARD
			device 1
		}
		hooks.0 {
			type ctl_elems
			hook_args [
				{
					interface MIXER
					name "IEC958 Output Switch"
					lock true
					preserve true
					value true
				}
				{
					interface PCM
					name "IEC958 Playback Default"
					device 1
					lock true
					preserve true
					value [ $AES0 $AES1 $AES2 $AES3 ]
				}
			]
		}
	}
	capture.pcm {
		type hw
		card $CARD
		device 1
	}
}

--Boundary-00=_2t46C0Y06x4pDpe--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
