From: Raymond <rayau@netvigator.com>
Subject: mixer control - Captuer Source - rename item name in enumerated control
Date: Tue, 13 Sep 2005 23:22:14 +0800
Message-ID: <4326EEA6.8070007@netvigator.com>
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

Is it possible to rename "Video" to "MPU401" in enumerated "Capture 
Source" mixer control by the au88x0 driver ?

numid=39,iface=MIXER,name='Capture Source'
   ; type=ENUMERATED,access=rw---,values=2,items=8
   ; Item #0 'Mic'
   ; Item #1 'CD'
   ; Item #2 'Video' <---------------MPU 401 / wavetable daugther card
   ; Item #3 'Aux'
   ; Item #4 'Line'
   ; Item #5 'Mix'
   ; Item #6 'Mix Mono'
   ; Item #7 'Phone'
   : values=0,0


http://www.dearhoney.idv.tw/MUSEUM/soundcard-07.php

In Vortex and Vortex 2 sound cards , which has the wavetable connector, 
the output of the wavetable daughter card is connected to capture source 
- Video of analog mixer of AC97 codec.

This exclude all those onboard au8820 on IWill LE370, onboard au8830 on 
ASUS P3B-1394.

http://www.3dsoundsurge.com/faqs/vortex1techfaq.html#Why%20am%20I%20not%20getting%20any%20sound%20from%20my%20wavetable%20daughterboard?

http://www.3dsoundsurge.com/faqs/vortex2techfaq.html#Why%20am%20I%20not%20getting%20any%20sound%20from%20my%20wavetable%20daughterboard?




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
