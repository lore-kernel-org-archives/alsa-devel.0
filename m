From: Matt Flax <flatmax@ieee.org>
Subject: RealTek acl650 patch for alsa 0.9.2 [was Re: Re: SiS7012 hang alsa version 0.9.3c ]
Date: Wed, 28 May 2003 03:21:52 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030527172152.GA2890@ee.unsw.edu.au>
References: <20030524170852.GB15643@ee.unsw.edu.au> <Pine.HPX.4.33n.0305261041530.24202-100000@studcom.urz.uni-halle.de> <20030526132610.GA27490@ee.unsw.edu.au> <20030527063230.GA32370@ee.unsw.edu.au>
Reply-To: Matt Flax <flatmax@pgb.unsw.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA01662
	for <alsa-devel@alsa-project.org>; Tue, 27 May 2003 18:37:20 +0200
Content-Disposition: inline
In-Reply-To: <20030527063230.GA32370@ee.unsw.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: core sound <alsa-devel@alsa-project.org>
Cc: pctech@realtek.com.tw
List-Id: alsa-devel@alsa-project.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I was a little surprised that realtek have released a modified ALSA 
0.9.2 driver to try to support their ACL650 audio codec.

I have had a little progress regarding the driver ...
Available from Realtek's website, you can download the source for the 
alsa-driver version 0.9.2 :
http://www.realtek.com.tw/downloads/downloads1-3.aspx?series=8&Software=True

I had to alter the source code to get it to compile ... attatched is a 
diff for patching.

unfortunatly there are alot of unresolved symbols (also attatched) ...
they suggest these options :
snd_index=0 snd_id=ICH

A little unsure what to do now ???

Matt

On Tue, May 27, 2003 at 04:32:30PM +1000, Matt Flax wrote:
> OK - it would appear the win2k loads this soundcard as a realtek ac'97 
> sound card. 
> It gives it :
> IRQ=05
> I/O=0xf800-0xf8ff
> I/O=0xfe80-0xfeff
> 
> Is it possible to specify these ? I tried loading the intel8x0 driver 
> with :
> modprobe snd-intel8x0 irq=5
> but the same problem with irq=0 happened as before.
> 
> There is a driver available at realtek :
> http://www.realtek.com.tw/downloads/downloads1-3.aspx?series=8&Software=True
> 
> If that helps at all ?
> 
> Matt
> 
> On Mon, May 26, 2003 at 11:26:10PM +1000, Matt Flax wrote:
> > Hi,
> > 
> > I  just checked the BIOS - it is a mobile bios and does not let you turn 
> > IRQs on/off nor other stuff ...
> > 
> > In the bios it reports the card as a SiS 7018.
> > This would mean it requires the trident driver.
> > 
> > Still no success ! I am   beginning to believe that it is something else 
> > ! It is a mobile combo chip ... SiS M650 and SiS962
> > 
> > dmesg prints:
> > Trident 4DWave PCI soundcard not found or device busy
> > 
> > Module inst. reports :
> > /lib/modules/2.4.20-1-686/kernel/sound/pci/trident/snd-trident.o: 
> > init_module: No such device
> > Hint: insmod errors can be caused by incorrect module parameters, 
> > including invalid IO or IRQ parameters.
> >       You may find more information in syslog or the output from dmesg
> > /lib/modules/2.4.20-1-686/kernel/sound/pci/trident/snd-trident.o: insmod 
> > /lib/modules/2.4.20-1-686/kernel/sound/pci/trident/snd-trident.o failed
> > /lib/modules/2.4.20-1-686/kernel/sound/pci/trident/snd-trident.o: insmod 
> > snd-trident failed
> > 
> > 
> > lspci  -v  prints :
> > 
> > 00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
> > SiS7012 PCI Audio Accelerator (rev a0)
> >         Subsystem: CLEVO/KAPOK Computer: Unknown device 0400
> >         Flags: medium devsel
> >         I/O ports at 1c00 [disabled] [size=256]
> >         I/O ports at 1800 [disabled] [size=128]
> >         Capabilities: [48] Power Management version 2
> > 
> > 
> > 
> > 
> > On Mon, May 26, 2003 at 10:44:31AM +0200, Clemens Ladisch wrote:
> > > Matt Flax wrote:
> > > > When I try to load the intel alsa module I get a hang state, with this
> > > > output :
> > > > PCI: Enabling device 00:02.7 (0000 -> 0001)
> > > > PCI: No IRQ known for interrupt pin C of device 00:02.7. Please try
> > > > using pci=biosirq.
> > > > ALSA ../alsa-kernel/pci/intel8x0.c:2249: unable to grab IRQ 0
> > > >
> > > > So I appended that to the lilo.conf file and ran lilo, upon reboot -
> > > > same problem.
> > > 
> > > Apparently, your BIOS didn't allocate an interrupt for the AC'97 device.
> > > Try changing some PnP-related settings in the BIOS setup.
> > > 
> > > 
> > > HTH
> > > Clemens
> > > 
> > 
> > -- 
> > http://mffm.ee.unsw.edu.au
> > 
> > WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
> > FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
> > Vector Bass                : http://mffmvectorbass.sourceforge.net/
> > Multimedia Time Code       : http://mffmtimecode.sourceforge.net/
> > 
> > 
> > -------------------------------------------------------
> > This SF.net email is sponsored by: ObjectStore.
> > If flattening out C++ or Java code to make your application fit in a
> > relational database is painful, don't do it! Check out ObjectStore.
> > Now part of Progress Software. http://www.objectstore.net/sourceforge
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> -- 
> http://mffm.ee.unsw.edu.au
> 
> WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
> FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
> Vector Bass                : http://mffmvectorbass.sourceforge.net/
> Multimedia Time Code       : http://mffmtimecode.sourceforge.net/
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: ObjectStore.
> If flattening out C++ or Java code to make your application fit in a
> relational database is painful, don't do it! Check out ObjectStore.
> Now part of Progress Software. http://www.objectstore.net/sourceforge
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
http://mffm.ee.unsw.edu.au

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="insmod.errors.txt"

/lib/modules/2.4.20-1-686/kernel/sound/acore/seq/snd-seq-device.o: unresolved symbol snd_info_create_module_entry_Re29d7319
/lib/modules/2.4.20-1-686/kernel/sound/acore/seq/snd-seq-device.o: unresolved symbol snd_seq_root_R213fca71
/lib/modules/2.4.20-1-686/kernel/sound/acore/seq/snd-seq-device.o: unresolved symbol snd_device_new_R55ced6c2
/lib/modules/2.4.20-1-686/kernel/sound/acore/seq/snd-seq-device.o: unresolved symbol snd_info_unregister_R1edd2547
/lib/modules/2.4.20-1-686/kernel/sound/acore/seq/snd-seq-device.o: unresolved symbol snd_info_register_R0935365c
/lib/modules/2.4.20-1-686/kernel/sound/acore/seq/snd-seq-device.o: unresolved symbol snd_info_free_entry_R52ebb3de
/lib/modules/2.4.20-1-686/kernel/sound/acore/seq/snd-seq-device.o: insmod /lib/modules/2.4.20-1-686/kernel/sound/acore/seq/snd-seq-device.o failed
/lib/modules/2.4.20-1-686/kernel/sound/acore/seq/snd-seq-device.o: insmod snd-intel8x0 failed

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0.9.2.intel8x0.c.diff"

372a373,377
> #define pcm_mic pcm[1]
> #define pcm_mic2 pcm[2]
> #define pcm2 pcm[3]
> #define pcm_spdif pcm[4]
> #define pcm_ac97spdif pcm[5]
1243c1248
< 	chip->pcm = NULL;
---
> 	chip->pcm[0] = NULL;
1270c1275
< 	chip->pcm = pcm;
---
> 	chip->pcm[0] = pcm;
2062c2067
< 	subs = chip->pcm->streams[0].substream;
---
> 	subs = chip->pcm[0]->streams[0].substream;

--rwEMma7ioTxnRzrJ--


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
