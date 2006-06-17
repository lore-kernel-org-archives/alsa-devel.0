From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002174]: No sound at all using
	snd-hda-intel / alsa-1.0.11
Date: Sat, 17 Jun 2006 19:51:57 +0200
Message-ID: <7404b869a192eba02a9edb0b8faa28f8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A8D74157
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jun 2006 19:51:57 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2174> 
======================================================================
Reported By:                carllivitt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2174
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2122_FC5smp
======================================================================
Date Submitted:             05-30-2006 17:11 CEST
Last Modified:              06-17-2006 19:51 CEST
======================================================================
Summary:                    No sound at all using snd-hda-intel / alsa-1.0.11
Description: 
On my new Toshiba Satellite Pro P100 laptop, I cannot get sound from the
speakers or headphone jack. It has never worked.

I've used the standard FC5 kernel and the updated kernel
(2.6.16-1.2122FC5smp) without success. 

I've downloaded and installed the alsa-*-1.0.11 drivers etc, but still no
sound. Everything is unmuted, alsamixer can turn the volume controls up
and down, KDE's kmix also works fine but still no sound. There are no
error messages in the syslog. 

I've also tried using the 'single_cmd=1' module loading option. 

I tried the CVS version of ALSA, but it didn't work with my kernel - there
were unresolved symbols that I couldn't resolve. I'm back to using the
1.0.11 version.

======================================================================

----------------------------------------------------------------------
 jlpedrosa - 06-14-06 16:13 
----------------------------------------------------------------------
i used to know english... 

Here's mine.... the subsystem insn't the same. I don't know if its the
same ALCXXX... Maybe it's related to #2035...

i cheked the BIOS update... but were only related to Booting from lan and
adding support to celeron... so I din't update

in realtek there are the pin and signals diagrams for alc861...

00:1b.0 Class 0403: 8086:27d8 (rev 02)
        Subsystem: 1584:9072
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at fe0f8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable -
        Capabilities: [70] Express Unknown type IRQ 0


Hope it's useful...
(if somebody need more info or testing just mailme jlpedrosa at gmail)
Jose Luis Pedrosa



----------------------------------------------------------------------
 carllivitt - 06-17-06 19:51 
----------------------------------------------------------------------
Well, it's seems like this has stalled. I'm quite willing to dive in and
have a go at sorting it if somebody can offer guidance. I'm very familiar
with Linux, have done some kernel dev before (designed and coded a rootkit
about 4 years ago) and know C very well.

Any offers of help of where to start?

Thanks, 
Carl

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-30-06 17:11 carllivitt     New Issue                                    
05-30-06 17:11 carllivitt     Distribution              => Fedora Core 5   
05-30-06 17:11 carllivitt     Kernel Version            => 2.6.16-1.2122_FC5smp
06-04-06 23:36 carllivitt     Issue Monitored: carllivitt                    
06-04-06 23:37 carllivitt     Note Added: 0010065                          
06-12-06 21:51 carllivitt     Note Added: 0010174                          
06-12-06 22:03 rlrevell       Note Added: 0010175                          
06-12-06 22:52 carllivitt     Note Added: 0010176                          
06-12-06 22:54 rlrevell       Note Added: 0010177                          
06-12-06 23:10 carllivitt     Note Added: 0010178                          
06-12-06 23:14 rlrevell       Note Added: 0010179                          
06-12-06 23:29 carllivitt     Note Added: 0010180                          
06-12-06 23:35 rlrevell       Note Added: 0010181                          
06-12-06 23:49 carllivitt     Note Added: 0010182                          
06-12-06 23:58 rlrevell       Note Added: 0010183                          
06-13-06 15:33 godeater       Note Added: 0010193                          
06-13-06 18:13 rlrevell       Note Added: 0010198                          
06-13-06 18:53 jlpedrosa      Note Added: 0010199                          
06-13-06 18:58 rlrevell       Note Added: 0010200                          
06-13-06 19:17 jlpedrosa      Note Added: 0010202                          
06-14-06 10:11 carllivitt     File Added: lspci-nv.txt                     
06-14-06 10:12 carllivitt     Note Added: 0010207                          
06-14-06 10:21 carllivitt     File Added: codec0.txt                       
06-14-06 10:21 carllivitt     Note Added: 0010208                          
06-14-06 13:17 jlpedrosa      Note Added: 0010210                          
06-14-06 16:13 jlpedrosa      Note Edited: 0010210                         
06-17-06 19:51 carllivitt     Note Added: 0010288                          
======================================================================
