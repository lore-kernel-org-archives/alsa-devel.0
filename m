From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: ASoC Roadmap
Date: Thu, 01 Dec 2005 16:54:42 +0000
Message-ID: <1133456082.3450.112.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
Cc: Giorgio Padrin <giorgio@mandarinlogiq.org>, Richard Purdie <rpurdie@rpsys.net>
List-Id: alsa-devel@alsa-project.org

I'm putting together a road map of what I think is needed in ASoC before
we can look at submitting to alsa-kernel. I'd like to hear any feedback
from the community wrt to anything that I'm missing. I'm aiming to
submit the core code with support for the pxa2xx platform and Zaurus
machines at around Xmas time.

We currently have support in 0.8 (released yesterday) for:-

 o Codec <--> SoC audio interface enumeration
 o Codec <--> SoC hw format, speed and chn matching
 o ASoC bus interface.
 o Codec Dynamic Power Management (DPM)
 o Machine DPM
 o ASoC PM
 o Support for machine kcontrols.

This currently gives us working ALSA and OSS emulation playback and
capture on the pxa2xx platform.

I think we are still in need of:-

 o Support for user generated audio events, (i.e. headphone insertion
event to user space)
 o Support for codec generated events. e.g. Jack insertion type
detection (hp or mic) 
 o Move from xxx_t types
 o Support for codec quirks (e.g. some codecs require the i2s bus to run
constantly, even when no audio is played)
 o Move i2c control code into codec driver, with machine layer
responsible for setting i2c device address.
 o Better support for 3 wire control.
 o More Testing  
 o Cleanup

Oh, I think documentation would be nice as well.

After xmas, I'll be adding:-

 o Support for other SoC's (i.e. au1x00, iMX)
 o Changing oversampling rates, mic bias for better power consumption.
 o Time division multiplexing support (for i2s, pcm ports). 

Liam



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
