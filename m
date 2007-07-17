From: Matthias Dahl <ml_alsa@mortal-soul.de>
Subject: snd-hda-intel,
	AD 1988b: SPDIF output not working correctly,
	volume low for analog output
Date: Tue, 17 Jul 2007 08:32:00 +0200
Message-ID: <200707170832.01976.ml_alsa@mortal-soul.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hJGnGeGxYAQF5Ky"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd15922.kasserver.com (dd15922.kasserver.com [85.13.137.18])
	by alsa0.perex.cz (Postfix) with ESMTP id DC8B8103815
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jul 2007 08:31:58 +0200 (CEST)
Received: from marvin (unknown [88.134.217.56])
	by dd15922.kasserver.com (Postfix) with ESMTP id AD87B1804A300
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jul 2007 08:31:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_hJGnGeGxYAQF5Ky
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone.

I very recently upgraded my system to a Asus Crosshair (AM2, nforce 590 sli) 
board because it seemed just good quality. Unfortunately the AD1988b chip on 
it is causing me some trouble.

1] SPDIF output 

When I use it for dts/dolby passthrough, it works just fine even though from 
time to time spdif just hangs- not during playback but when I start the 
playback. (analog output is unaffected) Meaning that either the player is 
hanging or playback starts but I hear no sound. After that only a reboot 
solves the problem... restarting alsa has not effect.

Also when the passthrough stops or during playback of anything else besides a 
dts/dolby stream, I hear a low pitch beating (usually in combination with a 
very high pitch sound) in the background.

I double checked everything to be sure that my other equipment was fine and 
not the cause of this.

2] analog output

I am unable to get it as loud as with the win drivers without overdriving it. 
The volume is okay... but not on par with the win drivers. That's especially 
true for the SPDIF output. Increasing the SPDIF volume usually results in 
worse audio quality over spdif and increased "noise" (see above).

Like said earlier, I checked with the win drivers, and everything (audio wise) 
works just fine there. So it's not a hardware fault. (relief -g-)

My guess would be that the AD 1988b is quite a bit different to program from 
its 1988 predecessors as it contains dts live and stuff. Just a guess...

I have attached some hopefully useful informations. If you need anything else, 
please let me know. I really need that spdif working, so I am more than 
willing to test just about anything. :-)

Last but not leat, I have tried the latest official alsa drivers as well as a 
mercurial snapshot from yesterday. (which I am currently using) Both show the 
same problems.

Thanks for any help in advance,
matthew.

--Boundary-00=_hJGnGeGxYAQF5Ky
Content-Type: application/x-gzip;
  name="lspci_output.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="lspci_output.gz"

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
6IiA+334fz9zFmG9ZQAA

--Boundary-00=_hJGnGeGxYAQF5Ky
Content-Type: application/x-gzip;
  name="proc_output1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="proc_output1.gz"

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

--Boundary-00=_hJGnGeGxYAQF5Ky
Content-Type: application/x-gzip;
  name="proc_output2.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="proc_output2.gz"

H4sICMhgnEYAA3Byb2Nfb3V0cHV0MgB9ktuOgjAQhu95irnUC0gLHlbuiGz2EN2YmHhjjOlC1UZs
tS1G334H8BhwJyEpw/fP/EwHCMx/ZiIVDK6xCOEzjtwvaXkGbnGGinCgMe4AMAvktOLEJxgg9AF8
gioSwhzIAtkQEiWtVhlmaXitEILhh5zLhGsHaK+kXRSEkIq1sCwDlqdCwT5j51+WbBHqXyD6D+R3
XlZK2N7mmiPTfVnoxgTBg1MrdoVLAkamy03KlqKYk0OIS/CHopgO3k4QXwo1JK72gBbDqFoALfXk
hkeSZWoN9fdGdeB8oNScjeW7yh9+pHgDHj65gVZxLm/EimRr2s4Em7komQzH94plDoXTUTR7rxBa
Idc+ZeqZCOpE8Ex060T3kaANRuizEVo3Qh+MROmR4eqkMBIyP8FU5TKFSCcbYXlS8rEWRxzKjGsj
lATqEY92PGeodnuRoRBz33mGm4frSvqwUhq2XEtcf9/reb7vUTdZGfdIB9Cajidtz/kD2qB/BDcD
AAA=

--Boundary-00=_hJGnGeGxYAQF5Ky
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_hJGnGeGxYAQF5Ky--
