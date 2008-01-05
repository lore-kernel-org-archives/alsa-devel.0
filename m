From: Steve Thornley <stevencomerthornley@yahoo.com>
Subject: 5.1 surround--no front center speaker sound--[NVidia
	CK804]
Date: Fri, 4 Jan 2008 19:57:13 -0800 (PST)
Message-ID: <144010.62790.qm@web56905.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web56905.mail.re3.yahoo.com (web56905.mail.re3.yahoo.com
	[66.196.97.94]) by alsa0.perex.cz (Postfix) with SMTP id 84E42244ED
	for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2008 04:57:19 +0100 (CET)
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

Nforce 4 MSI motherboard integrated sound----since my Creative X-Fi isn't supported, YET

can not get the front center speaker to work.




jlt:/home/steven# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: CK804 [NVidia CK804], device 0: Intel ICH [NVidia CK804]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: CK804 [NVidia CK804], device 2: Intel ICH - IEC958 [NVidia CK804 - IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0



Here is my present asound.conf file that I created in /etc for my Debian etch 4.0----amd64 system
X2-4200-cpu




# Set default sound card
# Useful so that all settings can be changed to a different card here.
pcm.snd_card {
type hw
card 0
}

pcm.dmix6 {
type dmix
ipc_key 1024
ipc_key_add_uid false # let multiple users share
ipc_perm 0660 # IPC permissions (octal, default 0600)
slave {
pcm snd_card # see below
rate 48000
channels 6
period_time 0
period_size 1024
buffer_time 0
buffer_size 4096
}
}

#route for stereo only
pcm.dmix20 {
type route
slave.pcm "dmix6"
slave.channels 6
ttable.0.0 1
ttable.1.1 1
}

#route for stereo sound+center+subwoofer
pcm.ch31dup {
type route
slave.pcm "dmix6"
slave.channels 6
ttable.0.0 1
ttable.1.1 1
ttable.0.4 0.5
ttable.1.4 0.5
ttable.0.5 0.5
ttable.1.5 0.5
}


pcm.ch51dup {
type route
slave.pcm dmix6
slave.channels 6
ttable.0.0 1
ttable.1.1 1
ttable.0.2 1
ttable.1.3 1
ttable.0.4 0.5
ttable.1.4 0.5
ttable.0.5 0.5
ttable.1.5 0.5
}


pcm.duplex {
type asym
playback.pcm "ch51dup"
# playback.pcm "dmix2"
# capture.pcm "mydsnoop"
capture.pcm "snd_card"
}

###################
# CONVERSION PLUG #
###################
# Setting the default pcm device allows the conversion
# rate to be selected on the fly.
# duplex mode allows any alsa enabled app to read/write
# to the dmix plug (Fixes a problem with wine).
pcm.!default {
type plug
slave.pcm "duplex"
}

pcm.dsp "duplex"

pcm.dsp1 "duplex"

pcm.fr {
type route
slave.pcm "dmix6"
slave.channels 6
ttable.0.0 1
ttable.1.1 1
}

pcm.rr {
type route
slave.pcm "dmix6"
slave.channels 6
ttable.0.2 1
ttable.1.3 1
}

pcm.lfe {
type route
slave.pcm "dmix6"
slave.channels 6
ttable.0.4 1
ttable.1.5 1
}




Here is my back up with other configurations for the file that created the same 4 speakers and subwoofer sounds but no front center speaker sounds



pcm.ch51dup {
type route
slave.pcm dmix6
slave.channels 6
ttable.0.0 1
ttable.1.1 1
ttable.0.2 1
ttable.1.3 1
ttable.0.4 1
ttable.1.4 1
ttable.0.5 1
ttable.1.5 1
}
########Old Setup
# pcm.51to40
#       {
#        type route
#        slave.pcm surround51
#        slave.channels 6
#
#         # Front and rear, at 75% of original signal strength
#        ttable.0.0 0.75
#        ttable.1.1 0.75
#        ttable.2.2 0.75
#        ttable.3.3 0.75
#
          # Center channel routing (routed to front-left and front-right),
          # 6dB gaindrop (gain half of main channels) per channel
 #         ttable.4.0 0.375
 #         ttable.4.1 0.375

           # LFE channel routing (routed to front-left and front-right),
          # 6dB gaindrop (gain half of main channels) per channel
  #        ttable.5.0 0.375
  #        ttable.5.1 0.375
  #      }



When I changed a setting from Autodetect to ALSA I could not get any sound--so I compiled everything from source with the latests tars and still nothing, and once I turned the Autodetect in Multimedia Systems Selector<Preferences<Desktop for the Default output plugin, I still had no sound in my center front speaker.



Whew.

I'd love it for my Creative X-Fi card to be supported, but right now, I really like my front center speaker back.
I'm at the end of my list of possible fixes, maybe someone who understands can take a look at this an have a go




      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
