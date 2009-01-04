From: Brian Hinz <bphinz@hotmail.com>
Subject: [patch] nvidia hdmi audio disabled with xorg "useEdid"
	option
Date: Sun, 4 Jan 2009 12:25:25 -0500
Message-ID: <BLU123-W5426084492C7642965031CC8E00@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_77a15ca6-89b7-4c22-8e3b-54ffcdce8b08_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s20.blu0.hotmail.com (blu0-omc3-s20.blu0.hotmail.com
	[65.55.116.95]) by alsa0.perex.cz (Postfix) with ESMTP id 10D511037F1
	for <alsa-devel@alsa-project.org>; Sun,  4 Jan 2009 18:25:26 +0100 (CET)
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

--_77a15ca6-89b7-4c22-8e3b-54ffcdce8b08_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi=2C

Attached is a patch to add the IDs necessary to enable the hdmi out on an A=
sus P5N-EM HDMI motherboard.  On a related note though=2C I'm trying to get=
 this board set up as a mythtv and having some troubles getting both audio =
& video to work properly with my Soyo 32" LCD TV.  This is probably better =
directed to the nvidia forums=2C but since I'm submitting a patch anyway I =
figured I'll put the question out there just in case someone knows...  The =
issue I'm having is that the LCD TV has a huge amount of overscan in all mo=
des=2C unless I direct the nVidia xorg driver to ignore the EDID=2C in whic=
h case the resolution is perfect but then the audio is disabled!  Obviously=
 the EDID provides the TV's audio capabilities to the X driver=2C and so it=
 stands to reason that in discarding this information the audio might not w=
ork=2C but is there any reason to think that this could be corrected in the=
 alsa driver somehow or does the problem lie entirely in the nvidia binary =
X driver?  Any thoughts/suggestions would be appreciated!

Thanks=2C
-brian

--_77a15ca6-89b7-4c22-8e3b-54ffcdce8b08_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch_nvhdmi.0x10de8001.diff"

LS0tIGFsc2EtZHJpdmVyLmJhay9hbHNhLWtlcm5lbC9wY2kvaGRhL3BhdGNoX252aGRtaS5jCTIw
MDgtMTItMTkgMTA6NDQ6NDkuMDAwMDAwMDAwIC0wNTAwCisrKyBhbHNhLWRyaXZlci9hbHNhLWtl
cm5lbC9wY2kvaGRhL3BhdGNoX252aGRtaS5jCTIwMDgtMTItMjIgMTM6MDM6MTQuMDAwMDAwMDAw
IC0wNTAwCkBAIC0xNjIsMTIgKzE2MiwxNCBAQAogCXsgLmlkID0gMHgxMGRlMDAwMiwgLm5hbWUg
PSAiTUNQNzggSERNSSIsIC5wYXRjaCA9IHBhdGNoX252aGRtaSB9LAogCXsgLmlkID0gMHgxMGRl
MDAwNywgLm5hbWUgPSAiTUNQN0EgSERNSSIsIC5wYXRjaCA9IHBhdGNoX252aGRtaSB9LAogCXsg
LmlkID0gMHgxMGRlMDA2NywgLm5hbWUgPSAiTUNQNjcgSERNSSIsIC5wYXRjaCA9IHBhdGNoX252
aGRtaSB9LAorCXsgLmlkID0gMHgxMGRlODAwMSwgLm5hbWUgPSAiTUNQNzMgSERNSSIsIC5wYXRj
aCA9IHBhdGNoX252aGRtaSB9LAogCXt9IC8qIHRlcm1pbmF0b3IgKi8KIH07CiAKIE1PRFVMRV9B
TElBUygic25kLWhkYS1jb2RlYy1pZDoxMGRlMDAwMiIpOwogTU9EVUxFX0FMSUFTKCJzbmQtaGRh
LWNvZGVjLWlkOjEwZGUwMDA3Iik7CiBNT0RVTEVfQUxJQVMoInNuZC1oZGEtY29kZWMtaWQ6MTBk
ZTAwNjciKTsKK01PRFVMRV9BTElBUygic25kLWhkYS1jb2RlYy1pZDoxMGRlODAwMSIpOwogCiBN
T0RVTEVfTElDRU5TRSgiR1BMIik7CiBNT0RVTEVfREVTQ1JJUFRJT04oIk52aWRpYSBIRE1JIEhE
LWF1ZGlvIGNvZGVjIik7Cg==

--_77a15ca6-89b7-4c22-8e3b-54ffcdce8b08_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_77a15ca6-89b7-4c22-8e3b-54ffcdce8b08_--
