From: Manu Sharma <manu.sharma@ma.tech.ascom.ch>
Subject: alsa issues on h5500 handheld
Date: Wed, 01 Dec 2004 17:46:53 +0100
Message-ID: <41ADF57D.5090005@ma.tech.ascom.ch>
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

Hi,

I am using a iPAQ h5500 runing familiar on it. The alsa drivers for this 
device are not part of official alsa sources, they are available from 
handhelds cvs. When I try to record sound () for a certain duration, the 
recording gets over in half the configured time.

For eg "time arecord -d 10 recording"

gives the following output ...
Recording WAVE 'recording' : Unsigned 8 bit, Rate 8000 Hz, Mono
real    0m 5.16s
user    0m 0.93s
sys     0m 2.78s

As far as I could figure out, the reason seems to be related to strange 
arrangement of things. The codec (ak4535) samples mono only, but the 
PXA's internal interface between DMA engine and I2S device controller is 
stereo. For this reason, all DMA configurations in the driver are done 
considering a stereo interface; additionally the driver configures its 
'snd_pcm_hardware_t' structure's channel fields (for capture) as :

channels_min = 2
channels_max = 2

My questions are ...
(i) Is forcing the device to be stereo (when it is actually mono), the 
right way to implement as per alsa design OR should the driver be 
converting DMA samples back to mono, so that things are consistent all 
along ?
(ii) What could be the reason of sample times being half of expected 
time, specially when the driver is registered as a stereo device ?

Thanks in advance
Manu


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
