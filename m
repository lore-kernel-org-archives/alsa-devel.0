From: Andreas Hartmann <andihartmann@freenet.de>
Subject: Re: [Realtek ALC260] Can't enable SPDIF out
Date: Sat, 02 Sep 2006 12:43:42 +0200
Message-ID: <44F9605E.3000404@p54A184AE.dip0.t-ipconnect.de>
References: <200609010118.k811I1KU028677@auster.physics.adelaide.edu.au>
	<44F8767E.4050203@p54A1ACFB.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44F8767E.4050203@p54A1ACFB.dip0.t-ipconnect.de>
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

Hello,

one more information:

if model=auto is used and aplay -D spdif is used, the following devices
are opened:

notebook1:/home/andreas # lsof | grep aplay | grep snd
aplay      7701    andreas  mem       CHR     116,17                56211
/dev/snd/pcmC0D1p
aplay      7701    andreas    3u      CHR      116,0                57283
/dev/snd/controlC0
aplay      7701    andreas    5u      CHR     116,17                56211
/dev/snd/pcmC0D1p



If aplay without any D-option is used, these devices are used (and analog
sound is playing):

notebook1:/home/andreas # lsof | grep aplay | grep snd
aplay      7691    andreas  mem       CHR     116,16                57223
/dev/snd/pcmC0D0p
aplay      7691    andreas    3r      CHR     116,33                57157
/dev/snd/timer
aplay      7691    andreas    5u      CHR     116,16                57223
/dev/snd/pcmC0D0p
aplay      7691    andreas    6u      CHR      116,0                57283
/dev/snd/controlC0


Obviously, another sounddevice is used for S/PDIF. Unfortunately there is
no output at the headphone jack, which is used fot the S/PDIF-out, too.

aplay -l says:

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC260 Analog [ALC260 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC260 Digital [ALC260 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


Kind regards,
Andreas Hartmann

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
