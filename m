From: Paul Davis <pbd@op.net>
Subject: ALSA Hammerfall DSP driver
Date: Mon, 13 May 2002 21:33:32 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205140133.g4E1XWJ32168@op.net>
Reply-To: alsa-devel@alsa-project.org
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA17628
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2002 03:32:24 +0200
Received: from unknown (HELO op.net) ([209.92.100.30]) (envelope-sender <pbd@op.net>)
          by newmx1.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 14 May 2002 01:32:21 -0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, linux-audio-announce@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

I'm pleased to announce that ALSA now has support for the Hammerfall
DSP audio interface. Details of the Hammerfall DSP are available at
RME's website (www.rme-audio.com). The driver supports:

      * all sample rates
      * both MIDI ports
      * "simple mixer" controls to allow alsamixer to control
           each playback stream's volume. Remember: as usual
	   with ALSA, the initial state is "all output muted".
      * peak meters for input, output and playback, with serial
	  clipping counters.
      * a non-standard control element for the matrix mixer (this
          may change; do not plan long term application support
	  around it)

Things that are not tested but should work:

    * big-endian systems
    * multiface i/o box
    * cardbus interface 
    * different sample clock sync sources
    
Things that don't work:
  
    * RMS meters
    * Flashing the firmware into the I/O box

The driver is similar in some ways the Hammerfall driver. Most
notably, it requires large chunks of physically contiguous
memory. This is best provided for by loading the snd-hammerfall-mem
module early during booting, which provides memory for both Hammerfall
and Hammerfall DSP drivers. The module has a snd-enable option which
takes a comma-separated list of 0's or 1's indicating whether or not
to allocate memory for the n'th Hammerfall or Hammerfall DSP
device. If you have only once such device, then snd-enable=1 will be
sufficient. The module checks for installed devices, so you can always
insert the module and the right thing will happen even if you have
removed your Hammerfall/Hammerfall DSP cards.

I am sure there will be minor glitches along the way. I would really
appreciate feedback from anyone with an H-DSP (marcus - that means
you! :)

A huge thank you to RME for the foresight and sense to make available
sufficient information to make this driver possible. 

--p



_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
