From: Guillaume Clement <gclement@baobob.org>
Subject: [snd-usb-audio] frequent "delay: estimated xxx,
	actual yyy" messages
Date: Sat, 21 Apr 2012 12:22:48 +0200
Message-ID: <3172169.OcqrdKakkS@siegfried>
Reply-To: gclement@baobob.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
	[217.70.183.195])
	by alsa0.perex.cz (Postfix) with ESMTP id AF2BE248C9
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Apr 2012 12:23:16 +0200 (CEST)
Received: from siegfried.localnet (unknown
	[IPv6:2a01:e35:8b3b:6a90:224:1dff:fe73:2eb4])
	(Authenticated sender: tortuxm@baobob.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E26C0A809E
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Apr 2012 12:23:14 +0200 (CEST)
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

Hello,

I am using an USB soundcard (ID : 046d:0a24 : Logitech Speaker Lapdesk N550).

During playback, I have frequent messages like these :

delay: estimated 795, actual 662
delay: estimated 133, actual 0
delay: estimated 751, actual 662
delay: estimated 89, actual 0


When those messages appear, I am hearing some "cracks" from the soundcard.


I've tried to make some research on this, I only found some messages that hint 
about some interrupt problems. I'm not using any closed source driver and I 
can reproduce the issue with any computer running Linux.


On interesting thing to notice is that it happens only when the CPU is near 
idle. To workaround the problem, I can just do something like : 

nice -n 20 dd if=/dev/zero of=/dev/null bs=1k count=500G


This would keep my CPU busy and I have no more messages nor cracks.




This does not seem to be a recent regression since I've experienced this since 
I bought the lapdesk in december or so. I am still experiencing this issue 
with the latest rc (linux-3.4rc3 at the moment)

I tried using different .asoundrc setups, tried to install pulseaudio (usually 
I'm using bare alsa) and still experience the problem.


Below is some information that might help locating the problem. I can make 
some test if needed and even code if I have some information on where the 
problem might me located.






Note: those commands are typed during playback.

$ cat /proc/asound/N550/stream0 
Logitech, Inc. Logitech Speaker Lapdesk N550 at usb-0000:00:1d.0-2, full speed 
: USB Audio

Playback:
  Status: Running
    Interface = 1
    Altset = 1
    URBs = 2 [ 20 20 ]
    Packet Size = 200
    Momentary freq = 44100 Hz (0x2c.199a)
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 1 OUT (ADAPTIVE)
    Rates: 44100, 48000

$ cat /proc/asound/N550/pcm0p/info 
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: USB Audio
name: USB Audio
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0

$ cat /proc/asound/N550/pcm0p/sub0/hw_params 
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 5513
buffer_size: 22050


$ cat /proc/asound/N550/pcm0p/sub0/info 
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: USB Audio
name: USB Audio
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0


$ cat /proc/asound/N550/pcm0p/sub0/status 
state: RUNNING
owner_pid   : 1210
trigger_time: 3264.436419606
tstamp      : 3302.883104696
delay       : 20904
avail       : 2646
avail_max   : 21026
-----
hw_ptr      : 1695160
appl_ptr    : 1714564


$ cat /proc/asound/N550/pcm0p/sub0/sw_params 
tstamp_mode: NONE
period_step: 1
avail_min: 5513
start_threshold: 16537
stop_threshold: 22050
silence_threshold: 0
silence_size: 0
boundary: 1445068800
