From: Rick Measham <rick@measham.id.au>
Subject: Re:
 =?iso-8859-1?q?1=2E0=2E16rc1_release_--_error=3A_=27?=
 =?iso-8859-1?q?system=5Futsname=27_undeclared?=
Date: Fri, 25 Jan 2008 08:12:06 +1100
Message-ID: <4798FF26.40803@measham.id.au>
References: <Pine.LNX.4.61.0801221247570.9698@tm8103.perex-int.cz>	<47964342.1060608@measham.id.au>	<s5htzl5t45y.wl%tiwai@suse.de>	<s5hsl0pt2uj.wl%tiwai@suse.de>	<47988136.4030307@measham.id.au>
	<s5hd4rr4ar8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0244260494022358901=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from argentum.mailguard.com.au (argentum.mailguard.com.au
	[69.16.232.177]) by alsa0.perex.cz (Postfix) with ESMTP id A78A124411
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 22:12:11 +0100 (CET)
In-Reply-To: <s5hd4rr4ar8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--===============0244260494022358901==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070609050605090505050107"

This is a cryptographically signed message in MIME format.

--------------ms070609050605090505050107
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> It is surely on the current HG repo.  You must be using an older
> repo.  Try hg.alsa-project.org instead of hg-mirror.

That fixed it. I grabbed the latest alsa-driver and it didn't need the 
patch. It all built just fine and installed without errors.

However it didn't fix the speakers so I'm no further ahead that 0.15 or 
0.14 (input and output jacks work, but the internal speakers don't)

dmesg tells me there are zero speaker_outs. So I figure it didn't 
auto-detect them, and there are no pins specified for this exact setup.

# dmesg
[128924.764000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, 
low) -> IRQ 21
[128924.764000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[128924.796000] ALSA /usr/src/alsa/alsa-driver/pci/hda/hda_codec.c:2855: 
autoconfig: line_outs=4 (0xd/0xc/0xf/0xb/0x0)
[128924.796000] ALSA /usr/src/alsa/alsa-driver/pci/hda/hda_codec.c:2859: 
    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[128924.796000] ALSA /usr/src/alsa/alsa-driver/pci/hda/hda_codec.c:2863: 
    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
[128924.796000] ALSA /usr/src/alsa/alsa-driver/pci/hda/hda_codec.c:2871: 
    inputs: mic=0xe, fmic=0x10, line=0x0, fline=0x0, cd=0x0, aux=0x0
[128924.796000] ALSA 
/usr/src/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:2172: 
dac_nids=4 (0x2/0x3/0x5/0x4/0x0)

My full setup (as output by alsa-info.sh) can be seen at 
http://pastebin.ca/871257

If there isn't an 'obvious' fix, I'm most happy to spend the time doing 
whatever to get it working if you can point me in the right direction.

Cheers!
Rick Measham

--------------ms070609050605090505050107
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJBzCC
At4wggJHoAMCAQICEHahvhsVL0qy1CdO97KnttwwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDYyODA2NTAwMloX
DTA4MDYyNzA2NTAwMlowRDEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEhMB8G
CSqGSIb3DQEJARYScmlja0BtZWFzaGFtLmlkLmF1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAwOurNHlazx8aZRpMSGQuUrzu2po3XFqj66HXP8etW37JWRM2lCn750qtJgi7
P4KZAc9Rsfqg+E4hqPVaO7P6gxCAO8Hx5PpTBVj/1ggSRZHpqG1Yf1wpiCktk3Ixk2iQC5DO
oTJqhJwiv2AVzE2tV+71ikGB0fFljlSIjD0Y1m/lMLoUwazamlnyTFIbXNiKLIIE5OGgO2Pi
d+idUA4oHN0IdS6j2h9R3tzH8mKC/ZRdftQ5uHSmGlQDeuP3nrqbKe7iynnptpOn9jsMUYh+
PtYRXeVZpontx/21IRpP7NQ0taSbdXX83FJ7ExAe6/hBiNcd9mLpGq3vs66CpngTqwIDAQAB
oy8wLTAdBgNVHREEFjAUgRJyaWNrQG1lYXNoYW0uaWQuYXUwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQUFAAOBgQABki3vumGUdihXJrv6N5tGVUiMNp2s8nCSCvI21pYo/nN+UY6Vp8Va
PEI9lRnfry/L8muvvnf6k5pk5izxBrICa234iMDV4nJsfMcKfeFMOaoxTuwKSyb0h/wUJYUo
I9rdUo6gAHiLqjx3mqZq3nrk9xC8s3PYMnmkUgxzuK1dcjCCAt4wggJHoAMCAQICEHahvhsV
L0qy1CdO97KnttwwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDYyODA2NTAwMloXDTA4MDYyNzA2NTAwMlowRDEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEhMB8GCSqGSIb3DQEJARYScmlja0Bt
ZWFzaGFtLmlkLmF1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwOurNHlazx8a
ZRpMSGQuUrzu2po3XFqj66HXP8etW37JWRM2lCn750qtJgi7P4KZAc9Rsfqg+E4hqPVaO7P6
gxCAO8Hx5PpTBVj/1ggSRZHpqG1Yf1wpiCktk3Ixk2iQC5DOoTJqhJwiv2AVzE2tV+71ikGB
0fFljlSIjD0Y1m/lMLoUwazamlnyTFIbXNiKLIIE5OGgO2Pid+idUA4oHN0IdS6j2h9R3tzH
8mKC/ZRdftQ5uHSmGlQDeuP3nrqbKe7iynnptpOn9jsMUYh+PtYRXeVZpontx/21IRpP7NQ0
taSbdXX83FJ7ExAe6/hBiNcd9mLpGq3vs66CpngTqwIDAQABoy8wLTAdBgNVHREEFjAUgRJy
aWNrQG1lYXNoYW0uaWQuYXUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQUFAAOBgQABki3v
umGUdihXJrv6N5tGVUiMNp2s8nCSCvI21pYo/nN+UY6Vp8VaPEI9lRnfry/L8muvvnf6k5pk
5izxBrICa234iMDV4nJsfMcKfeFMOaoxTuwKSyb0h/wUJYUoI9rdUo6gAHiLqjx3mqZq3nrk
9xC8s3PYMnmkUgxzuK1dcjCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJ
BgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEa
MBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2Vy
dmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcw
MDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUg
Q29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1h
aWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065ypla
HmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FW
y688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEE
QB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2
oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3Js
MAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0x
MzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYf
qi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9l
X5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8xggNkMIIDYAIBATB2
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQdqG+GxUv
SrLUJ073sqe23DAJBgUrDgMCGgUAoIIBwzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0wODAxMjQyMTEyMDZaMCMGCSqGSIb3DQEJBDEWBBS4CTRwtxiJqqF+
7cY0AAeIuv5OqTBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIA
gDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBhQYJKwYBBAGCNxAE
MXgwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkg
THRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEHah
vhsVL0qy1CdO97KnttwwgYcGCyqGSIb3DQEJEAILMXigdjBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEHahvhsVL0qy1CdO97KnttwwDQYJKoZIhvcN
AQEBBQAEggEAeLWXWpMpy6KOVr5WtfZKoWj4Xk57rjoyX3AruwQmGVU3VIeBQoFR4R3jEJck
0QXhc+7gAjRx654KA4E52SXxTGaRchp4KS6Pt/Pf+i/yC4d/7sdnh2SGMV9i39lY8oeW8lfp
vV8HHax71ZEn4ISpdB8eGhFdGup0r/QViZzZwbW34FdZ6HfhKVEsj8NEfFpeLVzVYZZamJaK
67lrwAALl1gp5fnfyF6EO2uI6QPYQYwdK8RY8+hlnkBLd7xcg65feOW0UrRiyNbPIbV1rUp4
uhKAOfaDRYjCo/QbqgeoxLeyjq44QSRqMxe9elTea4CwfaB4oXRpLxgMAhlVQ3acGAAAAAAA
AA==
--------------ms070609050605090505050107--

--===============0244260494022358901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0244260494022358901==--
