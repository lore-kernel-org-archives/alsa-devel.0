From: Johan Bilien <jobi@via.ecp.fr>
Subject: start_threshold having no effect
Date: Mon, 20 Oct 2003 19:30:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031020173030.GC28408@via.ecp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Resent-To: alsa-devel@lists.sourceforge.net
Resent-Message-Id: <20031020205427.CB24092B42@coruscant.bilien.org>
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

Hi,

I am trying to build an application using ALSA, and which requires low
playback delays.

My first idea was to have a small hardware buffer to limit the playout
delays. But then if for some reason the buffer gets full, the card stops,
and the next writei will block for about one second.

My second idea was to have a rather big hw buffer (500ms), and then set
the start_threshold to a low value (32 frames for instance). But whatever
my parameters were, I always got a playout delay of about the hw buffer
size.

I think the best way is the second one, but I can't figure out what I
did wrong. Here are the parameters I'm using:

20/10 18:56 /proc/asound/card0/pcm0p/sub0% cat hw_params 
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 1
rate: 8000 (8000/1)
period_size: 32
buffer_size: 4000
tick_time: 1000

20/10 19:12 /proc/asound/card0/pcm0p/sub0% cat sw_params 
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 16
xfer_align: 32
start_threshold: 32
stop_threshold: 4000
silence_threshold: 0
silence_size: 0
boundary: 2097152000

I am using a 2.6.0-test3 kernel (preemptive) with the 0.9.6 libasound.
My soundcard is a USB Plantronics Headset. The card is open both in
PLAYBACK and CAPTURE mode.

Thanks,
-- 
Jobi


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
