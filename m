From: Erik Slagter <erik@slagter.name>
Subject: Hotplug plugin
Date: Mon, 31 Dec 2007 15:18:11 +0100
Message-ID: <4778FA23.8090409@slagter.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3250180584175941080=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eriks.xs4all.nl (eriks.xs4all.nl [83.160.41.216])
	by alsa0.perex.cz (Postfix) with ESMTP id B58A71037F0
	for <alsa-devel@alsa-project.org>; Mon, 31 Dec 2007 15:18:12 +0100 (CET)
Received: from artemis.slagter.name (localhost.localdomain [127.0.0.1])
	by artemis.slagter.name (Postfix) with ESMTP id 0AC311A34008
	for <alsa-devel@alsa-project.org.>;
	Mon, 31 Dec 2007 15:18:12 +0100 (CET)
Received: from [10.8.2.26] (autemslap.sys.pc.wlz.nl [10.8.2.26])
	by artemis.slagter.name (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org.>;
	Mon, 31 Dec 2007 15:18:12 +0100 (CET)
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

This is a cryptographically signed message in MIME format.

--===============3250180584175941080==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms000609080004080900030907"

This is a cryptographically signed message in MIME format.

--------------ms000609080004080900030907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sorry for crossposting, but this is a problem I am not quite sure might
be solved by users or developers. Also I am not too lazy to do a little
development myself, if that appears to be necessary.

This is my setup:

- internal snd-hda soundcard connected to speakers in the bathroom
playing 24x7 music;
- jvc amplifier in living room with integrated USB sound device.

The USB sound device in the amplifier vanishes when the amplifier is
powered down.

So... this is my problem. I want to have 24x7 music on the internal
soundcard and on the amplifier. When the amplifier is switched off, no
audio should be send there (of course) but playback should resume as
soon as the amplifier is switched on and the USB device re-appears.

I created a "tee" construction using asound.conf which adresses both
soundcards, this works. At least... until the amplifer is switched off
and the USB device disappears. Then the sound playing application gets
an error and quits.

I tried these approaches for a solution:

 - pulseaudio, using hal-detection and "combined" device: doesn't work
because a removed device is never reinserted into the combined device;
 - alsa extplug: easy to create, no worries about the "slave" device,
you get it for free, but I abandoned the idea as there is probably no
way to recreate the slave pcm while the "owner" remains active.
 - alsa ioplug, attempt 1: there is probably no way to to address and
recreate the "slave" (which I open myself in the plugin using
snd_pcm_open) in such a way that it is completely transparent to the
application that it is talking to the "slave" (not a "real" alsa slave)
instead of the ioplug plugin
- alsa ioplug, attempt 2: I tried to make the callback functions of the
ioplug call the callbacks of the "slave" directly, but that probably
isn't going to work either (too much callbacks in the pcm struct that
have no equivalent in the ioplug struct)
- alsa ioplug, attempt 3: open and write to the hardware devices
directly. Abonded it as well because this cannot practically be done, as
you'd need parts copies of header files from the kernel and alsalib for
hidden data structures.


Anyone ideas to solve this in a neat way? (preferrably using an alsa
plugin; for the moment I am using a self-made external program that alsa
dumps it sound to (file plugin) and uses two alsa-player processes to
get the audio to the devices)

--------------ms000609080004080900030907
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJUTCC
AwMwggJsoAMCAQICEDGJsD9UPajwBl+GeyaBWA0wDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDkxNzEwMzAwM1oX
DTA4MDkxNjEwMzAwM1owajEQMA4GA1UEBBMHU2xhZ3RlcjEVMBMGA1UEKhMMRXJpayBNYXJ0
aWpuMR0wGwYDVQQDExRFcmlrIE1hcnRpam4gU2xhZ3RlcjEgMB4GCSqGSIb3DQEJARYRZXJp
a0BzbGFndGVyLm5hbWUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC4bkf+nXAx
akUjjwscSMjaKSUFQiJPxTgOUEh+uKVsBVGvY7CB8XcCmU7+oO1s9NaTL7BVy7Lwpj5SJV/B
v8gZWrHwsR3D7U2rcKUW81v7dkTu9GTAUt5Qc8b7+GehjZuZKZPjMdH6vJK9G7YnZu1gG9b0
CoEC4jOdIR4+4di2ZUN9M5JLlVKofOP4fo8MKFny88ThmxHLGzzQGsshfs7wuYB2hivouPCf
kmc+tnTI90mLrV748Yc6M9gq1brUajcy+tL0wdTS0NOJ2FVa/0HFlxaMrt88nko2J7wA+yPM
RY1L+ziU+Qr45JxoCE6pI/6lZNlMtHeYvdveQZs/3n5HAgMBAAGjLjAsMBwGA1UdEQQVMBOB
EWVyaWtAc2xhZ3Rlci5uYW1lMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAZrik
whMvx+aaj7gXQDVuy+zs7eqq1zJilrNS1130Hrq0JeLC6Rnl6a1gE52gap2O6uLyfpdGBmXu
loCzA9OPYKcZT6EtcZKF3+TCP0m9L3G1scQPPrxZt/oA4uZ4MDTvLElPJH2ONOvCoRPrp5aD
YHD5NlsDjs+kG6559873oTwwggMDMIICbKADAgECAhAxibA/VD2o8AZfhnsmgVgNMA0GCSqG
SIb3DQEBBQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAo
UHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QTAeFw0wNzA5MTcxMDMwMDNaFw0wODA5MTYxMDMwMDNaMGoxEDAOBgNVBAQTB1NsYWd0ZXIx
FTATBgNVBCoTDEVyaWsgTWFydGlqbjEdMBsGA1UEAxMURXJpayBNYXJ0aWpuIFNsYWd0ZXIx
IDAeBgkqhkiG9w0BCQEWEWVyaWtAc2xhZ3Rlci5uYW1lMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAuG5H/p1wMWpFI48LHEjI2iklBUIiT8U4DlBIfrilbAVRr2OwgfF3AplO
/qDtbPTWky+wVcuy8KY+UiVfwb/IGVqx8LEdw+1Nq3ClFvNb+3ZE7vRkwFLeUHPG+/hnoY2b
mSmT4zHR+rySvRu2J2btYBvW9AqBAuIznSEePuHYtmVDfTOSS5VSqHzj+H6PDChZ8vPE4ZsR
yxs80BrLIX7O8LmAdoYr6Ljwn5JnPrZ0yPdJi61e+PGHOjPYKtW61Go3MvrS9MHU0tDTidhV
Wv9BxZcWjK7fPJ5KNie8APsjzEWNS/s4lPkK+OScaAhOqSP+pWTZTLR3mL3b3kGbP95+RwID
AQABoy4wLDAcBgNVHREEFTATgRFlcmlrQHNsYWd0ZXIubmFtZTAMBgNVHRMBAf8EAjAAMA0G
CSqGSIb3DQEBBQUAA4GBAGa4pMITL8fmmo+4F0A1bsvs7O3qqtcyYpazUtdd9B66tCXiwukZ
5emtYBOdoGqdjuri8n6XRgZl7paAswPTj2CnGU+hLXGShd/kwj9JvS9xtbHEDz68Wbf6AOLm
eDA07yxJTyR9jjTrwqET66eWg2Bw+TZbA47PpBuueffO96E8MIIDPzCCAqigAwIBAgIBDTAN
BgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTES
MBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UE
CxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0
aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMC
WkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GN
ADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAK
MNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYB
Af8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBl
cnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYD
VQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2as
Zw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSe
JVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHT
HUb/XV9lTzGCA2QwggNgAgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAhAxibA/VD2o8AZfhnsmgVgNMAkGBSsOAwIaBQCgggHDMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA3MTIzMTE0MTgxMVowIwYJKoZI
hvcNAQkEMRYEFJIgbdrdXnRP3Djj/Ss0dVm4M6LaMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZI
hvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3
DQMCAgEoMIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJl
ZW1haWwgSXNzdWluZyBDQQIQMYmwP1Q9qPAGX4Z7JoFYDTCBhwYLKoZIhvcNAQkQAgsxeKB2
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQMYmwP1Q9
qPAGX4Z7JoFYDTANBgkqhkiG9w0BAQEFAASCAQA1PoVbe7wvIJZyPVV9lbvSVhLIjUZikTnp
56YDaHOOsX73zZjYiyE2UdY/gY8tnSBG/CGbP3BAmAA3ADO1hHd+5AdMhkmQCrSqxBqwWeUd
8NUNAKzszmgJb/MLurWWKgJTz7nlJnwhbLpKDOoziLl86rXuG4qzjajVYNWL+B8hvYEywoIo
zN/pp+Yl/AhIGSdLgdg19VMOKjWQS6biMmLN9xtSltZNMqveIvSbP9Co5Sdia4T2hc92xJrq
s4RkbFBh+IPstflLuzW5gGTYRGqCQdZNQy3dzOljNZQUxuvaa0Fh0MvyI+RLa7bbtBxeEPT4
hngyVXqePLXencUUXdcRAAAAAAAA
--------------ms000609080004080900030907--

--===============3250180584175941080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3250180584175941080==--
