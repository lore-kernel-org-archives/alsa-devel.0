From: wal_teichmann@t-online.de (Wolfgang Teichmann)
Subject: alsa-lib-0.9.0rc4
Date: Wed, 23 Oct 2002 00:35:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB5D296.4020006@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms030604060306040109040407"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--------------ms030604060306040109040407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hallo,

I have problems to compile alsa-lib-0.9.0rc4 (RedHat 8.0)


make[2]: Wechsel in das Verzeichnis Verzeichnis 
/mnt/archiv/AAA/SOUND/ALSA/stable/alsa-lib-0.9.0rc4/src
/bin/sh ../libtool --mode=link gcc  -g -O2 -Wl,--version-script=Versions 
-o libasound.la -rpath /usr/lib -version-info 2:0:0 conf.lo confmisc.lo 
input.lo output.lo async.lo error.lo dlmisc.lo control/libcontrol.la 
mixer/libmixer.la pcm/libpcm.la                       
rawmidi/librawmidi.la timer/libtimer.la               hwdep/libhwdep.la 
seq/libseq.la instr/libinstr.la               compat/libcompat.la -lm 
-ldl -lpthread              
rm -fr .libs/libasound.la .libs/libasound.* .libs/libasound.*
gcc -shared  conf.lo confmisc.lo input.lo output.lo async.lo error.lo 
dlmisc.lo -Wl,--whole-archive control/.libs/libcontrol.al 
mixer/.libs/libmixer.al pcm/.libs/libpcm.al rawmidi/.libs/librawmidi.al 
timer/.libs/libtimer.al hwdep/.libs/libhwdep.al seq/.libs/libseq.al 
instr/.libs/libinstr.al compat/.libs/libcompat.al 
-Wl,--no-whole-archive  -lm -ldl -lpthread -lc  -Wl,-soname 
-Wl,libasound.so.2 -o .libs/libasound.so.2.0.0
/usr/bin/ld: .libs/libasound.so.2.0.0: undefined versioned symbol name 
snd_pcm_hw_params_get_rate_min@ALSA_0.9.0rc4
/usr/bin/ld: failed to set dynamic section sizes: Bad value
collect2: ld returned 1 exit status
make[2]: *** [libasound.la] Fehler 1

Any idea?

-Wolfgang

--------------ms030604060306040109040407
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJZDCC
AxAwggJ5oAMCAQICAwiCPDANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNV
BAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUx
HTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVl
bWFpbCBSU0EgMjAwMC44LjMwMB4XDTAyMTAxODAxMTk1OVoXDTAzMTAxODAxMTk1OVowSzEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEoMCYGCSqGSIb3DQEJARYZd2FsX3Rl
aWNobWFubkB0LW9ubGluZS5kZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK3t
9U/z1sitJNCUAu5FS2TmcSPNb0gVDWjsGFyRTlGj9CPLsrTwKit8pRZmhvdKl1NALv6c1wQj
9duLTW9CzNOqKUtDwO95t13s8bPGjIl6hDssadXu7RT+MVduAtHGNnk4NdIVP6mygFgtsomE
TtJ5o97/loxL+1+FZ8d62PiUP7YyNMMto/zo3SNDSmV+4fsQLQE6C2S9cUukO4vkW8Zk7arf
B86NJ4fBnT1qgUgmcoFh21qnkrDybkpOKdnoMAXiEgmKPNu9TXn61xASxTOSlMO67CXoZV8e
5Jtu0pF7RqoAD90mEpGvSOxyfCQqlfpxawOvyB/7CyJOhG03Ek0CAwEAAaM2MDQwJAYDVR0R
BB0wG4EZd2FsX3RlaWNobWFubkB0LW9ubGluZS5kZTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3
DQEBBAUAA4GBALto5AYCDKxUDHP2QBOhsT08knVjdE6HCKKMM/4nEQZn7Dy5iVDp634APC16
rX8VgZ8uGVMrFvxOByDBpN3zSeyWWYlKga0P3vr0whc1icUq6sPHGbjFx7haLxrHE3wD4kin
XPLQX9p5c0ZKjc3eYvpSm5H1mr/lRMhVtQNdWdXjMIIDEDCCAnmgAwIBAgIDCII8MA0GCSqG
SIb3DQEBBAUAMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYD
VQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUg
U2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAwHhcN
MDIxMDE4MDExOTU5WhcNMDMxMDE4MDExOTU5WjBLMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1h
aWwgTWVtYmVyMSgwJgYJKoZIhvcNAQkBFhl3YWxfdGVpY2htYW5uQHQtb25saW5lLmRlMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAre31T/PWyK0k0JQC7kVLZOZxI81vSBUN
aOwYXJFOUaP0I8uytPAqK3ylFmaG90qXU0Au/pzXBCP124tNb0LM06opS0PA73m3Xezxs8aM
iXqEOyxp1e7tFP4xV24C0cY2eTg10hU/qbKAWC2yiYRO0nmj3v+WjEv7X4Vnx3rY+JQ/tjI0
wy2j/OjdI0NKZX7h+xAtAToLZL1xS6Q7i+RbxmTtqt8Hzo0nh8GdPWqBSCZygWHbWqeSsPJu
Sk4p2egwBeISCYo8271NefrXEBLFM5KUw7rsJehlXx7km27SkXtGqgAP3SYSka9I7HJ8JCqV
+nFrA6/IH/sLIk6EbTcSTQIDAQABozYwNDAkBgNVHREEHTAbgRl3YWxfdGVpY2htYW5uQHQt
b25saW5lLmRlMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAu2jkBgIMrFQMc/ZA
E6GxPTySdWN0TocIoowz/icRBmfsPLmJUOnrfgA8LXqtfxWBny4ZUysW/E4HIMGk3fNJ7JZZ
iUqBrQ/e+vTCFzWJxSrqw8cZuMXHuFovGscTfAPiSKdc8tBf2nlzRkqNzd5i+lKbkfWav+VE
yFW1A11Z1eMwggM4MIICoaADAgECAhBmRXK3zHT1z2N2RYTQLpEBMA0GCSqGSIb3DQEBBAUA
MIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBl
IFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0
aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1h
aWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcN
MDAwODMwMDAwMDAwWhcNMDQwODI3MjM1OTU5WjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgT
DFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAb
BgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFp
bCBSU0EgMjAwMC44LjMwMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDeMzKmY8cJJUU+
0m54J2eBxdqIGYKXDuNEKYpjNSptcDz63K737nRvMLwzkH/5NHGgo22Y8cNPomXbDfpL8dbd
YaX5hc1VmjUanZJ1qCeu2HL5ugL217CR3hzpq+AYA6h8Q0JQUYeDPPA5tJtUihOH/7ObnUlm
AC0JieyUa+mhaQIDAQABo04wTDApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxh
YmVsMS0yOTcwEgYDVR0TAQH/BAgwBgEB/wIBADALBgNVHQ8EBAMCAQYwDQYJKoZIhvcNAQEE
BQADgYEAMbFLR135AXHl9VNsXXnWPZjAJhNigSKnEvgilegbSbcnewQ5uvzm8iTrkfq97A0q
OPdQVahs9w2tTBu8A/S166JHn2yiDFiNMUIJEWywGmnRKxKyQF1q+XnQ6i4l3Yrk/NsNH50C
81rbyjz2ROomaYd/SJ7OpZ/nhNjJYmKtBcYxggMnMIIDIwIBATCBmjCBkjELMAkGA1UEBhMC
WkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQK
EwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJz
b25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwAgMIgjwwCQYFKw4DAhoFAKCCAWEwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDIxMDIyMjIzNTAyWjAjBgkq
hkiG9w0BCQQxFgQUPOFkLlVmMKbl8fLWU9a/Mld4oAkwUgYJKoZIhvcNAQkPMUUwQzAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwga0GCyqGSIb3DQEJEAILMYGdoIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UE
CBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEd
MBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVt
YWlsIFJTQSAyMDAwLjguMzACAwiCPDANBgkqhkiG9w0BAQEFAASCAQA6FgcsbyHtJxr0FSFC
XZA/L5Z92hiRm5pnTr4eLzHYAaI4jrTa34q7Sd2cpqUsV89ks8hDF/KRDU/yMCbLa8nQhb8v
kgtn1oG/CNtFwtFKDvapLooVcG6BcszCcghvt72VpwDwyD4Uf2Da4Q9iNlYOzXtgEyIM5gUk
NPsPog6P+TBTl8GmLuMWo4/cTxZkxMIWP7sSqgFJdAV8yZ+c9MlTtZPoBsIrJ+zKGiNIycrK
EHvwfXhmfv4hfdLqupRns+0yJgy9mVSuIFeN6r4c05OYVrKLWF4AgNIKWrgvdPWW0L8k7W5r
6jXa7TJdVsVUX30U3sezy5Sw2O4HdmhkzqzrAAAAAAAA
--------------ms030604060306040109040407--



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
