From: "StartCom Ltd." <eddy_nigg@startcom.org>
Subject: Compile error (rc2 driver)
Date: Mon, 24 Oct 2005 22:13:30 +0200
Message-ID: <435D406A.2040001@startcom.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060007000202000204040709"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--------------ms060007000202000204040709
Content-Type: multipart/alternative;
 boundary="------------040102080501070804070603"

This is a multi-part message in MIME format.
--------------040102080501070804070603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

There is a compile error with the rc2 driver....stable release compiles 
OK....are you aware of that? This is one 2.4.xx kernel...

gcc -D__KERNEL__ -DMODULE=1 
-I/usr/src/alsa/alsa-driver-1.0.10rc2/include  
-I/lib/modules/2.4.22-1.SML/build/include -O2 
-mpreferred-stack-boundary=2 -march=i686 -Wdeclaration-after-statement 
-DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs 
-O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc 
-iwithprefix include -DMODVERSIONS -include 
/lib/modules/2.4.22-1.SML/build/include/linux/modversions.h  
-DKBUILD_BASENAME=memory   -c -o memory.o memory.c
In file included from memory.c:2:
../alsa-kernel/core/memory.c:37: syntax error before '*' token
../alsa-kernel/core/memory.c:38: warning: function declaration isn't a 
prototype../alsa-kernel/core/memory.c: In function `copy_to_user_fromio':
../alsa-kernel/core/memory.c:40: `count' undeclared (first use in this 
function)../alsa-kernel/core/memory.c:40: (Each undeclared identifier is 
reported only once
../alsa-kernel/core/memory.c:40: for each function it appears in.)
../alsa-kernel/core/memory.c:40: `dst' undeclared (first use in this 
function)
../alsa-kernel/core/memory.c:40: syntax error before "__force"
../alsa-kernel/core/memory.c:40: syntax error before "__force"
In file included from memory.c:2:
../alsa-kernel/core/memory.c: At top level:
../alsa-kernel/core/memory.c:68: syntax error before '*' token
../alsa-kernel/core/memory.c:69: warning: function declaration isn't a 
prototype../alsa-kernel/core/memory.c: In function `copy_from_user_toio':
../alsa-kernel/core/memory.c:71: `count' undeclared (first use in this 
function)../alsa-kernel/core/memory.c:71: syntax error before "__force"
../alsa-kernel/core/memory.c:71: `src' undeclared (first use in this 
function)
../alsa-kernel/core/memory.c:71: syntax error before "__force"
make[1]: *** [memory.o] Error 1
make[1]: Leaving directory `/usr/src/alsa/alsa-driver-1.0.10rc2/acore'
make: *** [compile] Error 1

-- 
Regards
 
Signer:      Eddy Nigg
Company: StartCom Linux at www.startcom.org <http://www.startcom.org/>
                MediaHost^(TM) at www.mediahost.org 
<http://www.mediahost.org/>
Skype:      startcom <callto://startcom/>
Phone:      +1.213.341.0390
 
Import StartCom Public CA <http://cert.startcom.org/index.php?app=109>

--------------040102080501070804070603
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
There is a compile error with the rc2 driver....stable release compiles
OK....are you aware of that? This is one 2.4.xx kernel...<br>
<br>
gcc -D__KERNEL__ -DMODULE=1
-I/usr/src/alsa/alsa-driver-1.0.10rc2/include&nbsp;
-I/lib/modules/2.4.22-1.SML/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -Wdeclaration-after-statement
-DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs
-O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc
-iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.22-1.SML/build/include/linux/modversions.h&nbsp;
-DKBUILD_BASENAME=memory&nbsp;&nbsp; -c -o memory.o memory.c<br>
In file included from memory.c:2:<br>
../alsa-kernel/core/memory.c:37: syntax error before '*' token<br>
../alsa-kernel/core/memory.c:38: warning: function declaration isn't a
prototype../alsa-kernel/core/memory.c: In function
`copy_to_user_fromio':<br>
../alsa-kernel/core/memory.c:40: `count' undeclared (first use in this
function)../alsa-kernel/core/memory.c:40: (Each undeclared identifier
is reported only once<br>
../alsa-kernel/core/memory.c:40: for each function it appears in.)<br>
../alsa-kernel/core/memory.c:40: `dst' undeclared (first use in this
function)<br>
../alsa-kernel/core/memory.c:40: syntax error before "__force"<br>
../alsa-kernel/core/memory.c:40: syntax error before "__force"<br>
In file included from memory.c:2:<br>
../alsa-kernel/core/memory.c: At top level:<br>
../alsa-kernel/core/memory.c:68: syntax error before '*' token<br>
../alsa-kernel/core/memory.c:69: warning: function declaration isn't a
prototype../alsa-kernel/core/memory.c: In function
`copy_from_user_toio':<br>
../alsa-kernel/core/memory.c:71: `count' undeclared (first use in this
function)../alsa-kernel/core/memory.c:71: syntax error before "__force"<br>
../alsa-kernel/core/memory.c:71: `src' undeclared (first use in this
function)<br>
../alsa-kernel/core/memory.c:71: syntax error before "__force"<br>
make[1]: *** [memory.o] Error 1<br>
make[1]: Leaving directory `/usr/src/alsa/alsa-driver-1.0.10rc2/acore'<br>
make: *** [compile] Error 1<br>
<br>
<div class="moz-signature">-- <br>
<div><font face="Arial" size="2">Regards</font></div>
<div><font face="Arial" size="2">&nbsp;</font></div>
<div><font face="Arial" size="2">Signer:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Eddy Nigg<br>
Company: StartCom Linux at </font><a href="http://www.startcom.org/"><font
 face="Arial" size="2">www.startcom.org</font></a><br>
<font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MediaHost&#8482; at </font><a
 href="http://www.mediahost.org/"><font face="Arial" size="2">www.mediahost.org</font></a><br>
<font face="Arial" size="2">Skype:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="callto://startcom/">startcom</a></font></div>
<div><font face="Arial" size="2">Phone:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.213.341.0390</font></div>
<div><font face="Arial" size="2">&nbsp;</font></div>
<div><font face="Arial" size="2">Import <a
 href="http://cert.startcom.org/index.php?app=109">StartCom Public CA</a>
</font></div>
</div>
</body>
</html>

--------------040102080501070804070603--

--------------ms060007000202000204040709
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJBDCC
BH4wggPnoAMCAQICAiJ4MA0GCSqGSIb3DQEBBQUAMIGwMQswCQYDVQQGEwJJTDEPMA0GA1UE
CBMGSXNyYWVsMQ4wDAYDVQQHEwVFaWxhdDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEaMBgG
A1UECxMRQ0EgQXV0aG9yaXR5IERlcC4xKTAnBgNVBAMTIEZyZWUgU1NMIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJhZG1pbkBzdGFydGNvbS5vcmcwHhcNMDUw
MzE2MjIyNDM3WhcNMDYwMzE2MjIyNDM3WjBsMQswCQYDVQQGEwJJTDESMBAGA1UEChMJRWRk
eSBOaWdnMSIwIAYDVQQDExlTdGFydENvbSBGcmVlIE1haWwgTWVtYmVyMSUwIwYJKoZIhvcN
AQkBFhZlZGR5X25pZ2dAc3RhcnRjb20ub3JnMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKB
gQCdUHQD7owH0ODLZWK7VKuWOVc1mYKmvm8bLMCgl/4uRwLtM9Y/yvdsaxn1W+WHLVmR4N12
Yep4Pi7cYlPLDxafR1gXR21tQ3faDPELe+oHoo1xpaKSX3aS89xFbbPvvdrKUQqDsNHBy9It
Kn9yYMQypPw9ZuvAHYYtFvNLkuRJBwIDAQABo4IB6DCCAeQwDAYDVR0TAQH/BAIwADALBgNV
HQ8EBAMCBPAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBQXUWA0
UvzGaWf6guGRh1qlTcKovzCB3QYDVR0jBIHVMIHSgBQcicOWzL3+MtUNjIExtpidjShkjaGB
tqSBszCBsDELMAkGA1UEBhMCSUwxDzANBgNVBAgTBklzcmFlbDEOMAwGA1UEBxMFRWlsYXQx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xGjAYBgNVBAsTEUNBIEF1dGhvcml0eSBEZXAuMSkw
JwYDVQQDEyBGcmVlIFNTTCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEhMB8GCSqGSIb3DQEJ
ARYSYWRtaW5Ac3RhcnRjb20ub3JnggEAMBEGCWCGSAGG+EIBAQQEAwIFoDAuBglghkgBhvhC
AQ0EIRYfU3RhcnRDb20gRnJlZSBFbWFpbCBDZXJ0aWZpY2F0ZTAxBglghkgBhvhCAQQEJBYi
aHR0cDovL2NlcnQuc3RhcnRjb20ub3JnY2EtY3JsLnBlbTAzBglghkgBhvhCAQMEJhYkaHR0
cDovL2NlcnQuc3RhcnRjb20ub3JnL2NydC1jcmwucGVtMA0GCSqGSIb3DQEBBQUAA4GBAJ3m
1Km1CJNrpxTeeU8KTEuQ7fzy6gTZkgcZPhFqeoFRyjLjwcL8pdWt2Wsl5yp3zk+6WH3rP640
Xm+uDzYcgTb2MmsWzrrGLqn6blbeFVcGXB+OFxfhiQuJ9o19H68WKk9G5TbyZxxscxbzWN3c
HTJjsvzh1vpS2ZBF7fnCfuVoMIIEfjCCA+egAwIBAgICIngwDQYJKoZIhvcNAQEFBQAwgbAx
CzAJBgNVBAYTAklMMQ8wDQYDVQQIEwZJc3JhZWwxDjAMBgNVBAcTBUVpbGF0MRYwFAYDVQQK
Ew1TdGFydENvbSBMdGQuMRowGAYDVQQLExFDQSBBdXRob3JpdHkgRGVwLjEpMCcGA1UEAxMg
RnJlZSBTU0wgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEmFkbWlu
QHN0YXJ0Y29tLm9yZzAeFw0wNTAzMTYyMjI0MzdaFw0wNjAzMTYyMjI0MzdaMGwxCzAJBgNV
BAYTAklMMRIwEAYDVQQKEwlFZGR5IE5pZ2cxIjAgBgNVBAMTGVN0YXJ0Q29tIEZyZWUgTWFp
bCBNZW1iZXIxJTAjBgkqhkiG9w0BCQEWFmVkZHlfbmlnZ0BzdGFydGNvbS5vcmcwgZ8wDQYJ
KoZIhvcNAQEBBQADgY0AMIGJAoGBAJ1QdAPujAfQ4MtlYrtUq5Y5VzWZgqa+bxsswKCX/i5H
Au0z1j/K92xrGfVb5YctWZHg3XZh6ng+LtxiU8sPFp9HWBdHbW1Dd9oM8Qt76geijXGlopJf
dpLz3EVts++92spRCoOw0cHL0i0qf3JgxDKk/D1m68Adhi0W80uS5EkHAgMBAAGjggHoMIIB
5DAMBgNVHRMBAf8EAjAAMAsGA1UdDwQEAwIE8DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYB
BQUHAwQwHQYDVR0OBBYEFBdRYDRS/MZpZ/qC4ZGHWqVNwqi/MIHdBgNVHSMEgdUwgdKAFByJ
w5bMvf4y1Q2MgTG2mJ2NKGSNoYG2pIGzMIGwMQswCQYDVQQGEwJJTDEPMA0GA1UECBMGSXNy
YWVsMQ4wDAYDVQQHEwVFaWxhdDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEaMBgGA1UECxMR
Q0EgQXV0aG9yaXR5IERlcC4xKTAnBgNVBAMTIEZyZWUgU1NMIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJhZG1pbkBzdGFydGNvbS5vcmeCAQAwEQYJYIZIAYb4
QgEBBAQDAgWgMC4GCWCGSAGG+EIBDQQhFh9TdGFydENvbSBGcmVlIEVtYWlsIENlcnRpZmlj
YXRlMDEGCWCGSAGG+EIBBAQkFiJodHRwOi8vY2VydC5zdGFydGNvbS5vcmdjYS1jcmwucGVt
MDMGCWCGSAGG+EIBAwQmFiRodHRwOi8vY2VydC5zdGFydGNvbS5vcmcvY3J0LWNybC5wZW0w
DQYJKoZIhvcNAQEFBQADgYEAnebUqbUIk2unFN55TwpMS5Dt/PLqBNmSBxk+EWp6gVHKMuPB
wvyl1a3ZayXnKnfOT7pYfes/rjReb64PNhyBNvYyaxbOusYuqfpuVt4VVwZcH44XF+GJC4n2
jX0frxYqT0blNvJnHGxzFvNY3dwdMmOy/OHW+lLZkEXt+cJ+5WgxggOrMIIDpwIBATCBtzCB
sDELMAkGA1UEBhMCSUwxDzANBgNVBAgTBklzcmFlbDEOMAwGA1UEBxMFRWlsYXQxFjAUBgNV
BAoTDVN0YXJ0Q29tIEx0ZC4xGjAYBgNVBAsTEUNBIEF1dGhvcml0eSBEZXAuMSkwJwYDVQQD
EyBGcmVlIFNTTCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEhMB8GCSqGSIb3DQEJARYSYWRt
aW5Ac3RhcnRjb20ub3JnAgIieDAJBgUrDgMCGgUAoIICSTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNTEwMjQyMDEzMzBaMCMGCSqGSIb3DQEJBDEWBBQE
ge3chIZI/j+zTZwr9kl+/Ph7wjBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqG
SIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCByAYJ
KwYBBAGCNxAEMYG6MIG3MIGwMQswCQYDVQQGEwJJTDEPMA0GA1UECBMGSXNyYWVsMQ4wDAYD
VQQHEwVFaWxhdDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEaMBgGA1UECxMRQ0EgQXV0aG9y
aXR5IERlcC4xKTAnBgNVBAMTIEZyZWUgU1NMIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSEw
HwYJKoZIhvcNAQkBFhJhZG1pbkBzdGFydGNvbS5vcmcCAiJ4MIHKBgsqhkiG9w0BCRACCzGB
uqCBtzCBsDELMAkGA1UEBhMCSUwxDzANBgNVBAgTBklzcmFlbDEOMAwGA1UEBxMFRWlsYXQx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xGjAYBgNVBAsTEUNBIEF1dGhvcml0eSBEZXAuMSkw
JwYDVQQDEyBGcmVlIFNTTCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEhMB8GCSqGSIb3DQEJ
ARYSYWRtaW5Ac3RhcnRjb20ub3JnAgIieDANBgkqhkiG9w0BAQEFAASBgB1g5H6FBCIHTevy
wNv1V8bUVqeXX8D5Atyqe+5s7QtpqGAck4Xir9gxrDciPdugfSov9mYA0Fvetx+hkLMNY3Wm
OfmHgs1BJ5eM46KElMYgHEiy8lQ5i8v/BOHFpiHfGP6SmQHK90pKp2m8HDHW/eHGVFflMAnT
SFIBiizrarY7AAAAAAAA
--------------ms060007000202000204040709--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
