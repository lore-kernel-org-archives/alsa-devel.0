From: Josh Buhl <uzs33d@uni-bonn.de>
Subject: Re: intel8x0 driver motorboots (gets caught in loop)
 in Quake 3
Date: Fri, 14 Feb 2003 11:57:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4CCBB3.7060300@uni-bonn.de>
References: <3E4A8A39.9000608@uni-bonn.de>	<s5h4r78mrrr.wl@alsa2.suse.de>	<3E4B6E83.2070000@uni-bonn.de>	<s5hznp0lc2u.wl@alsa2.suse.de>	<3E4B77D1.3070904@uni-bonn.de> <s5hof5fjjmf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hof5fjjmf.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Thanks for continuing to look into this.

> could you also give the contents of the ohter files there (hw_params,
> sw_params, etc)?

Here are polls taken while the sound is looping:


josh@spleen:/proc/asound/card0/pcm0p/sub0$ cat hw_params
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 1024
buffer_size: 16384
tick_time: 10000
OSS format: S16_LE
OSS channels: 2
OSS rate: 48000
OSS period bytes: 4096
OSS periods: 16

josh@spleen:/proc/asound/card0/pcm0p/sub0$ cat sw_params
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 1024
xfer_align: 1
start_threshold: 1
stop_threshold: 1073741824
silence_threshold: 0
silence_size: 0
boundary: 1073741824

josh@spleen:/proc/asound/card0/pcm0p/sub0$ cat status
state: RUNNING
trigger_time: 1045219754.742409
tstamp      : 1045219994.302920
delay       : -5523094
avail       : 5539478
avail_max   : 5539478
-----
hw_ptr      : 11499158
appl_ptr    : 5976064

josh@spleen:/proc/asound/card0/pcm0p/sub0$ cat status
state: RUNNING
trigger_time: 1045219754.742409
tstamp      : 1045220044.890011
delay       : -7951425
avail       : 7967809
avail_max   : 7967809
-----
hw_ptr      : 13927489
appl_ptr    : 5976064

josh@spleen:/proc/asound/card0/pcm0p/sub0$ cat info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: Intel ICH
name: SiS SI7012
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0

josh@spleen:/proc/asound/card0/pcm0p/sub0$ cat prealloc
64







> 
> thanks,
> 
> Takashi
> 

-- 
"When you wake up in the morning, Pooh," said Piglet at last,
"what's the first thing you say to yourself?"

"What's for breakfast?" said Pooh.  "What do you say, Piglet?"

"I say, 'I wonder what's going to happen exciting today?'" said Piglet.

Pooh nodded thoughtfully.  "It's the same thing," he said.

	-- A.A. Milne

-----------------------------------------------------
http://www.nyfairuse.org/

WTO + WIPO = DMCA http://www.anti-dmca.org

Innovation vs Patent Inflation http://swpat.ffii.org/

120000 voices and 400 Firms against logic patents
http://www.noepatents.org/
-----------------------------------------------------




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
