From: James Trevelyan <james@jamestrevelyan.com>
Subject: Edirol M-16 DX
Date: Fri, 04 Apr 2008 12:05:00 +0100
Message-ID: <courier.47F60B5C.000011F0@bigbox.jt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bigbox.jt.com (host-83-217-174-146.sta.dsl.vispa.com
	[83.217.174.146])
	by alsa0.perex.cz (Postfix) with ESMTP id A61B824876
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Apr 2008 13:04:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I recently bought an Edirol M-16DX and am trying to get it working with 
Linux.  I'm almost there but would appreciate some help in getting it over 
the line. 

The M-16DX 
(http://www.rolandus.com/products/productdetails.aspx?ObjectId=860&ParentId= 
114) is a fairly new and pretty neat piece of kit - it works as a standalone 
16-channel hardware mixer, with a USB2.0 connection which can send each 
separate input to the computer, with the ability also to send a stereo 
stream back to the mixer.  In addition it can be put in a DAW controller 
mode where it acts a control surface with almost all the mixer knobs usable. 

It's set up as a vendor specific device so at first nothing happens when the 
usb cable connected.  The usb configuration has three interfaces, like some 
of the other Edirol devices.  So I put a new quirk in usbquirks.h for the 
appropriate device id, with a QUIRK_AUDIO_STANDARD_INTERFACE on interfaces 1 
and 2, and a QUIRK_MIDI_FIXED_ENDPOINT on interface 3.  Accodring to lsusb 
 -v, each interface provides what looks like a proper class-specific 
descriptor. 

Having recompiled, the system now detects the device and loads the usb-audio 
module when the device is plugged in.  It successfully creates alsa devices 
for capture and playback, as well as midi, with the correct sample rate 
(44.1, 48 or 96 as set on the device), correct number of channels (18 in and 
2 out).  All looks as it should. 

When I aplay an audio file to the device, it plays fine - almost.  
Everything sounds good, except that every 9-10 seconds, there is a kind of 
nasty high pitched digital distortion which lasts for a second.  (definitely 
not in the audio file!)  This seems to be synchronised to the start of the 
stream - when I aplay a file, it opens a new stream and the distortion is 
always in the same places in the song.  If I open the ports on jack so the 
stream stays open, and play music through it on ardour, the distortion is at 
different points in the song (always about 9-10 seconds apart). 

I haven't tried capture yet. 

It all runs fine under windows in the same configuration. 

I'm at a bit of a loss as to the problem here - perhaps there is something 
wrong with the detection, and I haven't yet tried creating an 
AUDIO_FIXED_ENDPOINT quirk to play with the settings manually.  But I would 
have thought in that case it just wouldn't work at all.  I know the sample 
rate and # channels is correct. 

My system's pretty up to date (2.6.24.3 kernel, alsa-libs 1.0.16).  I can 
provide full lsusb and /proc/asound information as necessary. 

Suggestions welcome! 

James 
