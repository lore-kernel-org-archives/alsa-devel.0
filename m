From: Panagiotis Papadakos <papadako@csd.uoc.gr>
Subject: Re: Problems with SBLive! and current CVS
Date: Wed, 25 Sep 2002 00:41:50 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.44.0209250037500.13764-100000@oneiro.csd.uch.gr>
References: <s5hvg4voefq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvg4voefq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hw_params:

access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 4096
buffer_size: 32768
tick_time: 10000


info:

card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: emu10k1
name: EMU10K1
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 32
subdevices_avail: 31


status:

state: RUNNING
trigger_time: 1032900260.282144
tstamp      : 1032903565.206917
delay       : 27890
avail       : 4878
avail_max   : 4878
-----
hw_ptr      : 145774350
appl_ptr    : 145802240


sw_params:

tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 4096
xfer_align: 4096
start_threshold: 1
stop_threshold: 32768
silence_threshold: 0
silence_size: 0
boundary: 1073741824

This is a 2.4.20-pre7 kernel on an Athlon 600 Mhz (Slot-A) with 512 Mb
RAM.

Regards
	Panagiotis Papadakos



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
