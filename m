From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: After warm boot Alsa not detecting sound card
Date: 03 Nov 2003 13:04:31 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1067893471.24188.135.camel@cmn37.stanford.edu>
References: <1067832822.2011.8.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1067832822.2011.8.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>    This is not a new problem on my system, but I wanted to get up to
> date with Alsa before I presented it here. If I do a cold boot then Alsa
> is correctly installed and both my HDSP 9652 and my MidiSport 2x2 are
> detected and work fine. However, after a warm boot Alsa never installs
> for the HDSP 9652.
> 
>    A BIT IMPROVEMENT with 0.9.8 is that Alsa will now load if I stop and
> start Alsa by hand after the warm boot, so thanks for that! I used to
> have to completely power down with 0.9.6, so this is a big improvement!
> However, I'd like to get this fixed so that even these by-hand steps are
> not required.
> 
>    After a warm boot the card is visible as a PCI device, but it isn't
> given an interrupt and the drivers aren't loaded:
> 
> Wizard asound # lspci
> <SNIP>
> 00:0e.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
> DSP (rev 65)
> <SNIP>
> Wizard asound # 
> 
> 
> Wizard asound # cat /proc/interrupts 
>            CPU0       
>   0:      86720    IO-APIC-edge  timer
>   1:       1271    IO-APIC-edge  keyboard
>   2:          0          XT-PIC  cascade
>   8:          2    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
> 12:      12786    IO-APIC-edge  PS/2 Mouse
> 14:       6276    IO-APIC-edge  ide0
> 15:          5    IO-APIC-edge  ide1
> 16:      27066   IO-APIC-level  ohci1394, radeon@PCI:1:0:0
> 18:         62   IO-APIC-level  eth0
> 21:       1332   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
> NMI:          0 
> LOC:      86667 
> ERR:          0
> MIS:          0
> Wizard asound # 
> 
> bash-2.05b$ su -
> Password: 
> Wizard root # lsmod
> Module                  Size  Used by    Not tainted
> radeon                103400   1 

The following two are the oss usb modules, you should blacklist them in
/etc/hotplug/blacklist so that only the alsa modules are loaded. 

> usb-midi               17180   0  (unused)
> audio                  41400   0  (unused)

It _is_ strange that the alsa usb modules are also loaded...

> snd-usb-audio          46336   0 
> snd-rawmidi            15072   0  [snd-usb-audio]
> snd-pcm                64804   0  [snd-usb-audio]
> snd-page-alloc          6676   0  [snd-pcm]
> hid                    15108   1 
> snd-seq                39408   0  (unused)
> snd-timer              15876   0  [snd-pcm snd-seq]
> snd-seq-device          4416   0  [snd-rawmidi snd-seq]
> snd                    35428   0  [snd-usb-audio snd-rawmidi snd-pcm
> snd-seq snd-timer snd-seq-device]
> sbp2                   17984   0  (unused)
> raw1394                 8028   0  (unused)
> ohci1394               18196   0  (unused)
> ieee1394               35280   0  [sbp2 raw1394 ohci1394]
> Wizard root # 
> 
> 
> Wizard asound # pwd  
> /proc/asound
> Wizard asound # more version 
> Advanced Linux Sound Architecture Driver Version 0.9.8.
> Compiled on Nov  2 2003 for kernel 2.4.20-gentoo-r7 with versioned
> symbols.
> Wizard asound # 
> 
> 
>   I can at this point stop and restart Alsa and everything works:

This is, I think, a problem with the stock alsasound script. It does not take into
account that other stuff may start alsa subsystems before the alsasound script
runs. 

In this case hotplug loads the alsa usb driver. A while later alsasound is
executed but it tests for /proc/asound to determine if it is "already running",
that test is true and the rest of the alsa modules are not started. 

If this is (as I suspect) in your Gentoo box you could try copying the hacks
I made to the Planet CCRMA alsasound script so that it loads anything that has
not been loaded so far. That should fix the problem. 

-- Fernando

> Wizard root # lsmod
> Module                  Size  Used by    Not tainted
> radeon                103400   1 
> usb-midi               17180   0  (unused)
> audio                  41400   0  (unused)
> hid                    15108   1 
> sbp2                   17984   0  (unused)
> raw1394                 8028   0  (unused)
> ohci1394               18196   0  (unused)
> ieee1394               35280   0  [sbp2 raw1394 ohci1394]
> Wizard root # /etc/init.d/alsasound start
>  * Loading ALSA drivers...
>  * Loading: snd-seq-oss
>  * Loading: snd-pcm-oss
>  * Loading: snd-mixer-oss
>  * Loading: snd-hdsp
>  * Loading: snd-usb-audio
>  * Loading: snd-seq-midi
>  * Loading: snd-seq-oss
>  * Running card-dependent scripts
>  * Restoring Mixer
> Levels                                                                         [ ok ]
> Wizard root # lsmod
> Module                  Size  Used by    Not tainted
> snd-pcm-oss            39492   0  (unused)
> snd-mixer-oss          13648   0  [snd-pcm-oss]
> snd-usb-audio          46336   0 
> snd-seq-midi            4096   0  (autoclean) (unused)
> snd-hdsp               39204   0 
> snd-pcm                64804   0  (autoclean) [snd-pcm-oss snd-usb-audio
> snd-hdsp]
> snd-rawmidi            15072   0  (autoclean) [snd-usb-audio
> snd-seq-midi snd-hdsp]
> snd-page-alloc          6676   0  (autoclean) [snd-hdsp snd-pcm]
> snd-hwdep               5344   0  (autoclean) [snd-hdsp]
> snd-seq-oss            30368   0  (unused)
> snd-seq-midi-event      3840   0  [snd-seq-midi snd-seq-oss]
> snd-seq                39408   2  [snd-seq-midi snd-seq-oss
> snd-seq-midi-event]
> snd-timer              15876   0  [snd-pcm snd-seq]
> snd-seq-device          4416   0  [snd-seq-midi snd-rawmidi snd-seq-oss
> snd-seq]
> snd                    35428   0  [snd-pcm-oss snd-mixer-oss
> snd-usb-audio snd-seq-midi snd-hdsp snd-pcm snd-rawmidi snd-hwdep
> snd-seq-oss snd-seq-midi-event snd-seq snd-timer snd-seq-device]
> radeon                103400   1 
> usb-midi               17180   0  (unused)
> audio                  41400   0  (unused)
> hid                    15108   1 
> sbp2                   17984   0  (unused)
> raw1394                 8028   0  (unused)
> ohci1394               18196   0  (unused)
> ieee1394               35280   0  [sbp2 raw1394 ohci1394]
> Wizard root # 
> 
> Wizard root # cat /proc/interrupts 
>            CPU0       
>   0:     115711    IO-APIC-edge  timer
>   1:       1673    IO-APIC-edge  keyboard
>   2:          0          XT-PIC  cascade
>   8:          2    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  12:      20211    IO-APIC-edge  PS/2 Mouse
>  14:       6667    IO-APIC-edge  ide0
>  15:          5    IO-APIC-edge  ide1
>  16:      40297   IO-APIC-level  ohci1394, radeon@PCI:1:0:0
>  17:          0   IO-APIC-level  hdsp
>  18:         68   IO-APIC-level  eth0
>  21:       1673   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
> NMI:          0 
> LOC:     115660 
> ERR:          0
> MIS:          0
> Wizard root # 
> 
> At this point the card has an interrupt, the drivers are loaded, and
> everything works.
> 
> My modules.conf file is attached. 
> 
>    Thanks in advance for any ideas.
> 
> Cheers,
> Mark




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
