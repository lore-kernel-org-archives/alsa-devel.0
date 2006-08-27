From: Jonas Grote <jonas@jonasgrote.de>
Subject: Computer freezing when connecting midi ports
Date: Sun, 27 Aug 2006 19:44:04 +0000
Message-ID: <20060827191117.GA3765@tux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa-devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello alsa-dev list,

I'm using Gentoo Linux, kernel 2.6.16-gentoo-r11, and I have a "Trident
Microsystems 4DWave DX" soundcard, alsa and drivers compiled as modules.

When I try to connect two ports of the soundcard with aconnect, my
computer freezes, if sound was running the last miliseconds are repeated
over and over again. There is nothing I can do except pressing the reset
button to get back access to my system.

I guess if I could fix the aconnect-problem, there would be no more
problems with rosegarden and other programs that try to access my midi
port.
Until I installed timidity, solfege created the same error.

This is the output of "aconnect -o" after "aconnect -x":

--
j@tux:~$ aconnect -o
client 16: 'Trident TRID4DWAVEDX MIDI' [type=kernel]
    0 'Trident TRID4DWAVEDX MIDI'
client 17: 'Trident 4DWave-DX' [type=kernel]
    0 'Trident 4DWave-DX port 0'
    1 'Trident 4DWave-DX port 1'
    2 'Trident 4DWave-DX port 2'
    3 'Trident 4DWave-DX port 3'
--

In #gentoo.de on freenode someone said it could be a interrupt problem,
so I rearranged my cards, this is "cat /proc/interrupts":

--
j@tux:~$ cat /proc/interrupts 
           CPU0       
  0:    3191058          XT-PIC  timer
  1:      48298          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
 10:     402996          XT-PIC  ohci_hcd:usb1, eth0
 11:     867160          XT-PIC  nvidia
 12:     246248          XT-PIC  Trident Audio
 14:    1052225          XT-PIC  ide0
 15:         27          XT-PIC  ide1
--

I think the problem cannot be that there is no midi-instrument connected
to the soundcard.

I have no idea what to do to get this working. I would like to try
rosegarden, and maybe even use some midi-keyboard or -guitar at some
time. I'd buy a new soundcard at some day anyway, but why should I
acquiesce that it doesn't work with this one?

I hope I am not wrong at this list, but I thought alsa-main would not
have been better.

It might also be a hardware problem, but then the alsa driver maybe
could catch that. I know that I had this problem with debian as well.

Another application I just remeber creating the same "error" is wine. I
think it uses midi as well?

Anyway, I first want to get aconnect working / not freezing my whole
computer.

Thank you for your attention, I'll send you any output you request and
I'll try to do everything that you ask me for (if it's related to this
problem of course ;-) ).

Jonas

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
