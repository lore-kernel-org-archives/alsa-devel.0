From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: VIA8235 SPDIF problems
Date: Sun, 13 Apr 2003 01:01:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304130101.24708.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi, I have a Shuttle SK41G machine. This has a VIA8235, with an Avance Logic 
ALC 650 Rev 0 on it.

Problem: I want to use the digital out on this board talking to my digital 
receiver for normal audio. I also want to have AC3/DTS passthrough when 
playing DVDs.

Something is playing up. Usually, I can get AC3 passthrough working for DVDs.. 
after a bit of random flailing at the mixer devices, but I can't always. I 
haven't been able to identify a consistent pattern of changes to make to make 
it 100% reliable. It just seems to "start working" eventually.

I can't get non-AC3/DTS digital audio output to work at all. My decoder DOES 
light up its wee "Digital" light when I starting playing something, but there 
is no sound. Oddly enough, I'm pretty sure I DID have this working at one 
point, but I cannot get anything now.

I'm changing: IEC958, IEC958 Input Monitor, IEC958 Output, IEC958 Playback 
AC97-SPSA, and Analog to IEC958 Output.. oh, and PCM, Master are set quite 
high.

I've also tried sending the output to the "iec958/spdif" devices, but with no 
luck (although this does seem to change which combinations of mixer settings 
mean my decoder light the DIGITAL light)

I'm using the latest CVS of ALSA, with Xine 1.0beta10.

Why am I posting this here? I'm going to try messing with the code to try and 
fix this, but I'm hoping someone can suggest some things for me to try as I 
am hampered by a lack of VIA8235 docs.

Finally, what are these "VIA DXS" mixer devices? I now have four of them and 
none of them seems to affect anything!



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
