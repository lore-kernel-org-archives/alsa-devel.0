From: federico <xaero@inwind.it>
Subject: combining two subdevs of the same device
Date: Sun, 16 Oct 2005 16:21:04 +0200
Message-ID: <435261D0.8060601@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

i just bought an ADAT I/O box (8+8).
i plugged into my soundcard, believing that it would extend my number of 
audio channels, from 2in+8out to 10in+16outs.

unfortunately seems that jack can't handle more than one (sub)device at 
time (i can use hw:1,0, wich is the analog part, OR hw:1,1 wich is the 
digital part)

i tried even various configurations of /etc/asound.conf, trying to merge 
the 1,0 and 1,1 subdevs, but no luck (you can see my asound.conf files 
in te bottom of message).... and someone told me that i cannot merge two 
subdevices that are part of the same device, because the ctl.* is the 
same, and it cannot control both subdevs.

does anyone knows how to workaround this?


here is asound.conf (1st try): (i used asym because Gina24 has 2 analog 
inputs, and 8 analog outputs)

pcm.!default {
   type plug
   slave sl44100
}
ctl.!default {
   type hw
   card 1
}
pcm_slave.sl44100 {
   pcm "hw:1,0"
   channels 2
   rate 44100
}

pcm.Gina_Capture {
   type asym
   playback {
       pcm {
           type null
       }
   }
   capture {
       pcm {
           type hw
           card 1
           device 0
       }
   }
}
pcm.Gina_Playback {
   type asym
   playback {
       pcm {
           type hw
           card 1
           device 0
       }
   }
   capture {
       pcm {
           type null
       }
   }
}
pcm.Fostex_ADAT {
   type hw
   card 1
   device 1
}

pcm.multi {
   type multi
   slaves.a.pcm "Gina_Playback"
   slaves.a.channels 8
   slaves.b.pcm "Gina_Capture"
   slaves.b.channels 2
   slaves.z.pcm "Fostex_ADAT"
   slaves.z.channels 8
   bindings.0.slave a
   bindings.0.channel 0
   bindings.1.slave a
   bindings.1.channel 1
   bindings.2.slave a
   bindings.2.channel 2
   bindings.3.slave a
   bindings.3.channel 3
   bindings.4.slave a
   bindings.4.channel 4
   bindings.5.slave a
   bindings.5.channel 5
   bindings.6.slave a
   bindings.6.channel 6
   bindings.7.slave a
   bindings.7.channel 7
   bindings.8.slave z
   bindings.8.channel 0
   bindings.9.slave z
   bindings.9.channel 1
   bindings.10.slave z
   bindings.10.channel 2
   bindings.11.slave z
   bindings.11.channel 3
   bindings.12.slave z
   bindings.12.channel 4
   bindings.13.slave z
   bindings.13.channel 5
   bindings.14.slave z
   bindings.14.channel 6
   bindings.15.slave z
   bindings.15.channel 7
   bindings.16.slave b
   bindings.16.channel 0
   bindings.17.slave b
   bindings.17.channel 1
}
ctl.multi {
   type hw
   card 1
}

pcm.ttable {
   type route
   slave.pcm "multi"
   ttable.0.0 1
   ttable.1.1 1
   ttable.2.2 1
   ttable.3.3 1
   ttable.4.4 1
   ttable.5.5 1
   ttable.6.6 1
   ttable.7.7 1
   ttable.8.8 1
   ttable.9.9 1
   ttable.10.10 1
   ttable.11.11 1
   ttable.12.12 1
   ttable.13.13 1
   ttable.14.14 1
   ttable.15.15 1
   ttable.16.16 1
   ttable.17.17 1
}
ctl.ttable {
   type hw
   card 1
}


here is the second try:
pcm.!default {
   type plug
   slave sl44100
}
ctl.!default {
   type hw
   card 1
}
pcm_slave.sl44100 {
   pcm "hw:1,0"
   channels 2
   rate 44100
}

pcm.Gina {
   type hw
   card 1
   device 0
}
pcm.Fostex_ADAT {
   type hw
   card 1
   device 1
}

pcm.multi {
   type multi
   slaves.b.pcm "Gina"
   slaves.b.channels 2
   slaves.z.pcm "Fostex_ADAT"
   slaves.z.channels 8
   bindings.0.slave z
   bindings.0.channel 0
   bindings.1.slave z
   bindings.1.channel 1
   bindings.2.slave z
   bindings.2.channel 2
   bindings.3.slave z
   bindings.3.channel 3
   bindings.4.slave z
   bindings.4.channel 4
   bindings.5.slave z
   bindings.5.channel 5
   bindings.6.slave z
   bindings.6.channel 6
   bindings.7.slave z
   bindings.7.channel 7
   bindings.8.slave b
   bindings.8.channel 0
   bindings.9.slave b
   bindings.9.channel 1
}
ctl.multi {
   type hw
   card 1
}

pcm.ttable {
   type route
   slave.pcm "multi"
   ttable.0.0 1
   ttable.1.1 1
   ttable.2.2 1
   ttable.3.3 1
   ttable.4.4 1
   ttable.5.5 1
   ttable.6.6 1
   ttable.7.7 1
   ttable.8.8 1
   ttable.9.9 1
}
ctl.ttable {
   type hw
   card 1
}




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
