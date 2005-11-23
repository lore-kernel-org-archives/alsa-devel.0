From: Romain Beauxis <toots@rastageeks.org>
Subject: ac97 8 channels, software mixing and dshare
Date: Wed, 23 Nov 2005 15:15:45 +0100
Message-ID: <200511231515.45106.toots@rastageeks.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RmHhDBKjUQYInQh"
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

--Boundary-00=_RmHhDBKjUQYInQh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

	Hi all!

I've recently got a new mother borad, with a intel8x0 ac97 internal chipset.
This chipset is pretty raw, and does not handle hardware mixing neither seperate rear, front etc.. outputs.

The only way to reach rear and others channels is to open the card in 6 channels mode and then split those channels.

I've managed to get a working configuration with rear, front and center.
But my card is 8 channels capable, but the alsamixer only allows selection for 2, 4 and 6 channels, and aplay segfault when I try to open the card with 8 channels.

Also, one of my application -- xdtv -- crashes with this configuration. My hint is this is because it looks for a 2 channels default card while it is in 6 channels, because I get:
snd_pcm_hw_params_set_channels: Argument invalide
zsh: floating point exception  xdtv

Then I've searched on the documentation, and found that this would be possible with dshare, but dshare needs to be connected to hw, and hw is allready connected to dmix...

My questions would be:
-- Is the 8 channels ac97 output available in alsa
-- Can I set up a proper 2 channels device from a 6 channels dmix device? 


My audiochip is:
0000:00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Controller (rev a2)
0000:00:04.0 0401: 10de:0059 (rev a2)

And my .asoundrc is attached..

Thank for your answer  and keep up the good work!


Romain
-- 
If you are the big tree,
We are the small axe,
Ready to cut you down,
Sharpen to cut you down...

--Boundary-00=_RmHhDBKjUQYInQh
Content-Type: text/plain;
  charset="us-ascii";
  name=".asoundrc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".asoundrc"


pcm.dshare {
    type dmix
    ipc_key 2048
    slave {
        pcm "hw:0"
        rate 48000
	period_size 1096
	buffer_size 3384
	period_time 24000
	buffer_time 70000
        channels 6 #segfault if set to 8
    }
    bindings {
        0 0
        1 1
        2 2
        3 3
	4 4
	5 5
# 	6 6
# 	7 7
    }
}

pcm.dsnoop0 {
 type dsnoop;
 ipc_key 13758;
 slave.pcm "hw:0"
 }

pcm.!front {
    type plug
    slave {
        pcm "dshare"
        channels 6
    }
    ttable.0.0 1
    ttable.1.1 1
}

pcm.!center {
    type plug
    slave {
        pcm "dshare"
        channels 6
    }
    ttable.0.2 1
    ttable.1.3 1
}

pcm.!rear {
    type plug
    slave {
        pcm "dshare"
        channels 6
    }
    ttable.0.4 1
    ttable.1.5 1
}

pcm.!default {
 type asym
 capture.pcm "dsnoop0"
 playback.pcm "front"
 }

 ctl.!default {
 type hw
 card 0
 }



--Boundary-00=_RmHhDBKjUQYInQh--



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
