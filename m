From: Eivind Tagseth <eivindt@multinet.no>
Subject: Re: [Alsa-user] hda-intel on Thinkpad T60p fails to
 load with unable to handle kernel paging request
Date: Thu, 28 Sep 2006 23:15:03 +0200
Message-ID: <20060928211449.GA11276@tagseth-trd.consultit.no>
References: <efaq89$idd$1@sea.gmane.org> <451982DE.90102@multinet.no>
	<s5h7izo2h9r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1645136275=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <s5h7izo2h9r.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1645136275==
Content-type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="oC1+HKm2/end4ao3"
Content-disposition: inline


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Takashi Iwai <tiwai@suse.de> [2006-09-28 16:32:48 +0200]:

> > > Sep 26 09:09:10 [kernel] BUG: unable to handle kernel paging request =
at
> > > virtual address 07400041
> >=20
> > Scratch that, this happened while loading snd-timer, not snd-hda-intel!=
=20
> >   Sorry.
>=20
> Could you elaborate the step how to reproduce it?

Just by insmod-ing.

> > I managed to get around that (either by adding seq-rtctimer-default, or=
=20
> > just by updating and rebuilding), and I can now get sound working again.
>=20
> And what was exaclty the workaround you did?

I'm afraid I did more than one thing:

	o  updated from hg
	o  added seq_rtctimer-default
	o  rebuilt

It may very well have been the rebuilding, I had some problems before
with my kernel version not being detected properly.  After updating,
this was fixed in the configure script.  Maybe that was what fixed it...




Eivind

--oC1+HKm2/end4ao3
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIIlgYJKoZIhvcNAQcCoIIIhzCCCIMCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
BhowggLTMIICPKADAgECAgMP9VkwDQYJKoZIhvcNAQEEBQAwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA1MTIwMTExNDA0MloXDTA2MTIwMTEx
NDA0MlowRTEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEiMCAGCSqGSIb3DQEJ
ARYTZWl2aW5kdEBtdWx0aW5ldC5ubzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AMQ0HB/KSjQPTYc2kqUoHQvuXUtuUmivxZ4sOixOYNdNxqG9piXqUtkKmfHzf/0fHMcb1YaQ
/5kcgrUsBZt6ULILGcCZNsiCziG2NH3qy1vulrTYaw3VNHCdFGCwcg802PCYR+fDWiSDi12j
VO5iWRbJjE71MFYt3joJB/xUyj/t5F8KcVLMw6opFPnxaQmJdUp9WHw+630ExzHYhfCSyLI2
F0a+k9bZVa6wBnJwuBoSBWy/VnyBBFKBc2b2IKMA5Q65D0XkZnutF+ewq9v+wh2c0THkSjp6
I6XavQCaISnN19FBd5zTF4wV5KSHNRpSF/RrPawb8ZMFlw0LRMymsckCAwEAAaMwMC4wHgYD
VR0RBBcwFYETZWl2aW5kdEBtdWx0aW5ldC5ubzAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEB
BAUAA4GBAK7PUtiPkVQqOxum9MzrmMxY5AKli+c3RrkrCdq9tc7rUJo7KUcLN+iCgAb5iy3D
601do0L+5cc6/U0vPvRjc1gNJEegZaXfgcb/CPKPxDkzUZQpOmcxD5qecuSrYyjOIRnefROO
CY8e0Z+BPzyoiAXbKHsTuo1Rxw6nF1PAvhSdMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0B
AQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJ
Q2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlm
aWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29t
MB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMCWkExJTAjBgNV
BAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDE
pjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAKMNcCY1osiRVw
jt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTXp6a7n2XRxSpU
hQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8CAQAwQwYD
VR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFsRnJl
ZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2
YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+wheh
Q5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FX
JY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGC
AkQwggJAAgEBMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5n
IENBAgMP9VkwCQYFKw4DAhoFAKCBsTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjA5MjgyMTE1MDNaMCMGCSqGSIb3DQEJBDEWBBT6PxaZglNwmEsc+pOg
rYDcalcTzjBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAN
BggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASC
AQBK5VNmfyXQwUd85VfsF3aXIey/Iu+hXR+JPef+0LfIwyGBZ70BAj4U3I8AYgqkL8uJ7Jqf
DUMfpw1fD1R1WtaaTmnJSKi6blH6mKp7doYhP6jTY3PxPwoY5Xz89BTPNimRPR46d12a/yKX
x7S8w2baCYHTkmLpBPbjfSNxHukk3KncY0t3D19YFugju+mzQyeWHz/uclFLir/o0AZK9CGs
mwNNeBqInv1NTcG3HRG2PhhliAx3vDMnA5SijVWfjvOzKbQIYfZqJpWpTQWM4hAJx3KEN8lq
T4Tkv6WZQr1yXTA7B3CbYr3jAObFKaBxsnr01uQzhc9rRvfbskaRqbLs

--oC1+HKm2/end4ao3--


--===============1645136275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1645136275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1645136275==--
