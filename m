From: Ralf Hersel <ralf.hersel@gmx.net>
Subject: HDA-Intel headphone problem
Date: Sun, 04 Feb 2007 11:10:47 +0100
Message-ID: <1170583847.6557.11.camel@hersel-r>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello

After reading hunderts of forum messages with no result I would like to
ask you.

I'm not able to switch on the headphone jacks on my notebook.

Configuration:
Notebook: HP Pavilion dv9097ea
Jack layout on front: 1 Mic-in, 1 Audio-out chinch, 1 Audio-SPDIF-out
chinch

Soundcard and Codec:
	ralf@hersel-r:~$ cat /proc/asound/cards
	0 [Intel ]: HDA-Intel - HDA Intel
	HDA Intel at 0xde300000 irq 66
	1 [Headset ]: USB-Audio - Logitech USB Headset
	Logitech Logitech USB Headset at usb-0000:00:1d.0-2, full speed

	ralf@hersel-r:~$ head -n 1 /proc/asound/card0/codec*
	Codec: Generic 14f1 ID 50

ALSA-Mixer shows only 3 controls: Master, PCM, In-Gain.
I tried all possible combination of control settings without success.

I tried these settings in /etc/modprobe.d/alsa-base:
	3stack-digout
	z71v
	auto
	3stack-dig
Have not tried any 'position-fix' settings.

Thanks a lot for your help.
Regards
Ralf





-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
