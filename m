From: alfp <alfp@adsmr.co.za>
Subject: asoundc for routing all cards through one device
Date: 11 Dec 2002 10:10:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1039594233.390.3.camel@didjeridu.adsmr.co.za>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

It took me a while to figure this out, so I thought i'd share it.

If you stick this into you .asoundrc, it creates a virtual device
called 'all', which will play to four cards at once.

ie aplay -Dall /usr/share/sounds/phone.wav

alf

######## All cards as one ####################
#### Device (pcm) definitions #############
pcm.m0 { type hw card 0 }
pcm.m1 { type hw card 1 }
pcm.m2 { type hw card 2 }
pcm.m3 { type hw card 3 }

#### Multi-device definition ##############
pcm.mlt {
          type multi;
          slaves [
                 { pcm m0 channels 2 }
                 { pcm m1 channels 2 }
                 { pcm m2 channels 2 }
                 { pcm m3 channels 2 }
          ]

          bindings [
                   { slave 0 channel 0 }
                   { slave 0 channel 1 }
                   { slave 1 channel 0 }
                   { slave 1 channel 1 }
                   { slave 2 channel 0 }
                   { slave 2 channel 1 }
	           { slave 3 channel 0 }
                   { slave 3 channel 1 }
          ]
}

#### Auto-generated routing ###############
pcm.all {
       type plug
       slave { pcm mlt }
       route_policy duplicate
}




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
