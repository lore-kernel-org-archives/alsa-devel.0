From: Raymond <rayau@netvigator.com>
Subject: au88x0 - arecord, aoss
Date: Wed, 30 Mar 2005 00:56:52 +0800
Message-ID: <424988D4.2070805@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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


Although au88x0 support hardware mixing, there is only one pair of
AC97 input CODECIN(0), CODECIN(1) for capturing stereo sound using hw:0,0

# more /proc/asound/au8830/pcm0c/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: AU88x0 ADB
name: adb
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 32
subdevices_avail: 32


It seem that multiple instances of arecord can be run at the same time.
1) Is this a bug ?

2) Do we need to define snd_vortex_capture_hw_adb to prevent multiple
programs perform recording while allowing multiple playback for ALSA and
OSS emulation ?







-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
