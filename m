From: Erik Slagter <erik@slagter.name>
Subject: Re: [alsa-devel] Hotplug plugin
Date: Tue, 01 Jan 2008 19:26:13 +0100
Message-ID: <477A85C5.8010104@slagter.name>
References: <4778FA23.8090409@slagter.name>
	<20071231144225.GB4414@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1530960651=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <20071231144225.GB4414@tango.0pointer.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org., alsa-user@lists.sourceforge.net, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--===============1530960651==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms080009030204060109040108"

This is a cryptographically signed message in MIME format.

--------------ms080009030204060109040108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Lennart Poettering wrote:

>>  - pulseaudio, using hal-detection and "combined" device: doesn't work
>> because a removed device is never reinserted into the combined
>> device;
> 
> Of course it is. Just install PA 0.9.7 or newer.

Nope, really.

The relevant config file sections (using pa 0.9.7):

***

load-module module-hal-detect
load-module module-combine sink_name=all
-> master=alsa_output.pci_8086_27d8_alsa_playback_0
-> slaves=alsa_output.usb_device_8bb_2704_noserial_if0_alsa_playback_0
-> adjust_time=5 resample_method=src-sinc-best-quality

 - or -

load-module module-detect
load-module module-combine sink_name=all master=alsa_output.hw_0
-> slaves=alsa_output.hw_1 adjust_time=10
-> resample_method=src-sinc-best-quality

 - or -

load-module module-alsa-sink device=hw:0 format=s16 rate=44100
-> channels=2 sink_name=alc883 channel_map=left,right
load-module module-alsa-sink device=hw:1 format=s16 rate=44100
-> channels=2 sink_name=jvc channel_map=left,right
load-module module-combine sink_name=all master=alc883 slaves=jvc
-> adjust_time=10 resample_method=src-sinc-best-quality

***

-> is line continuation

These combinations all yield the same result: at startup I have an "all"
sink that combines both devices, and does that pretty well, I must say.
But as soon as the USB device is removed, it is removed from the
combined "all" sink. Then when the USB device is reinserted, it gets
detected (module-hal-detect) or not (module-detect, static config).
Using module-hal-detect the reinserted just sits there, it isn't added
to the combined sink. Using the other methods, it's not even detected
that the USB device is back...

The only solution I can think of, is a udev script that casts some magic
spells towards pulse when the USB device is inserted or removed... But
then I could skip pulse altogether, because mpd has an option to
activate and deactivate selected outputs at runtime, as well.

--------------ms080009030204060109040108
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDEwMTE4MjYxM1owIwYJKoZI
hvcNAQkEMRYEFKICUO0OLY/dX5Onyn+QeKr1ODA6MFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZI
hvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3
DQMCAgEoMIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJl
ZW1haWwgSXNzdWluZyBDQQIQMYmwP1Q9qPAGX4Z7JoFYDTCBhwYLKoZIhvcNAQkQAgsxeKB2
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQMYmwP1Q9
qPAGX4Z7JoFYDTANBgkqhkiG9w0BAQEFAASCAQABmSfh3Q8xsIaD4wax5fp+0Omm3IHUttZG
rjrheAmbBt4ow56dQqieaBtQkw/jDz3EynmQGE/pHA4Tjrl+MPYusT5YkI3tUe8GCvymyM/v
mUk5iLnLGMnf3dZXxsH2XVKK6F7JNekgUwKj9RwyYwGqlOj+Rt7aglBhdTKaxch/q076v/8s
+534s7cyqk0cyJSoGWpU1oYOW62GtVDxu73h8/pilvZMohCLlYMA47MFr/Uu9nGRd3AM2A8D
LouJUUS8dElHsi4kynmnG8GCYSDlbcEVxUL51YM5Ptmk8RDT7pc0asDCsCRBM2hQW+bdXXGv
l+sLlOqQL5HmCyqMGK/CAAAAAAAA
--------------ms080009030204060109040108--


--===============1530960651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1530960651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============1530960651==--
