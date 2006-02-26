From: Markus Grabner <grabner@icg.tu-graz.ac.at>
Subject: Line6 USB driver in ALSA?
Date: Sun, 26 Feb 2006 12:07:30 +0100
Message-ID: <200602261207.31050.grabner@icg.tu-graz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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
Cc: clemens@ladisch.de, rlrevell@joe-job.com
List-Id: alsa-devel@alsa-project.org


	Hi everybody!

    I just had a brief conversation with Lee Revell about the question if a 
USB driver for Line6 guitar equipment I am working on since 2004 (see 
http://www.tanzband-scream.at/line6) could be included in ALSA. In 
particular, the following devices are supported:
*) POD series (http://www.line6.com/products/pods): these devices digitally 
simulate the sound of different guitar amplifiers. The user can control these 
devices by several dials without connecting them to the PC, or by appropriate 
software running on a PC to which the device is connected via USB. Moreover, 
the guitar signal can be captured, and simultaneously a PCM signal from the 
PC can be played back (full-duplex).
*) Variax guitars (http://www.line6.com/variax) connected to the PC via an USB 
interface (http://www.line6.com/variaxWorkbench): these guitars digitally 
simulate the sound of different guitars. The model parameters (e.g., pickup 
type and position) can be modified via USB (the current version of the Linux 
driver can only read these parameters, however).

The driver I wrote registers the POD devices as a soundcard, therefore the PCM 
portion would perfectly fit into ALSA. Moreover, POD parameters are 
controlled via ALSA's MIDI interface, commands are translated to USB (the 
devices also have a MIDI port, which can be accessed with the standard raw 
MIDI driver, but PCM is not available via MIDI).
However, I'm not so sure if other features of the driver are within the scope 
of ALSA. These include
*) a set of files registered under /sys/bus/usb/drivers/... to allow access to 
the current states of the POD/Variax model parameters (as ASCII numbers)
*) a method to access all parameters of a single or multiple models as a 
binary block of data
*) a guitar tuner
*) and some more features not immediately related to audio

The current driver source code is available under 
"http://www.tanzband-scream.at/line6/download/line6usb-0.6.1.tar.bz2". The 
main files are:
*) pcm.*: the PCM interface
*) midi.*: the MIDI interface
*) pod.*: POD-specific code
*) variax.*: Variax-specific code
*) driver.*: generic code for all supported Line6 devices

What is your opinion on how such a driver could fit into the ALSA concept?

	Kind regards,
		Markus


-- 
Markus Grabner - Computer Graphics and Vision
Graz University of Technology, Inffeldgasse 16/II, 8010 Graz, Austria
Phone: +43/316/873-5041, Fax: +43/316/873-5050
WWW: http://www.icg.tu-graz.ac.at/Members/grabner


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
