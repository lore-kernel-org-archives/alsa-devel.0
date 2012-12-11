From: Denis Washington <denisw@online.de>
Subject: [PATCH 2/2] Rename internal xonar_u1_* names to just
	xonar_u_*
Date: Tue, 11 Dec 2012 11:39:25 +0100
Message-ID: <50C70D5D.90305@online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3770105266626360758=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186])
 by alsa0.perex.cz (Postfix) with ESMTP id CE33E2602F4
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2012 11:39:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dies ist eine kryptografisch unterzeichnete Nachricht im MIME-Format.

--===============3770105266626360758==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms090807050404070204010904"

Dies ist eine kryptografisch unterzeichnete Nachricht im MIME-Format.

--------------ms090807050404070204010904
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

Now that the code applies both to the U1 and the U3,
xonar_u1 is not a good name anymore.
---
  sound/usb/mixer.h        |  2 +-
  sound/usb/mixer_quirks.c | 24 ++++++++++++------------
  2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index a7f3d45..9e7ec0e 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -22,7 +22,7 @@ struct usb_mixer_interface {
  	u8 rc_buffer[6];

  	u8 audigy2nx_leds[3];
-	u8 xonar_u1_status;
+	u8 xonar_u_status;
  };

  #define MAX_CHANNELS	16	/* max logical channels */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 2223089..de6db70 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -416,23 +416,23 @@ static void snd_audigy2nx_proc_read(struct=20
snd_info_entry *entry,
  	}
  }

-static int snd_xonar_u1_switch_get(struct snd_kcontrol *kcontrol,
+static int snd_xonar_u_switch_get(struct snd_kcontrol *kcontrol,
  				   struct snd_ctl_elem_value *ucontrol)
  {
  	struct usb_mixer_interface *mixer =3D snd_kcontrol_chip(kcontrol);

-	ucontrol->value.integer.value[0] =3D !!(mixer->xonar_u1_status & 0x02);=

+	ucontrol->value.integer.value[0] =3D !!(mixer->xonar_u_status & 0x02);
  	return 0;
  }

-static int snd_xonar_u1_switch_put(struct snd_kcontrol *kcontrol,
+static int snd_xonar_u_switch_put(struct snd_kcontrol *kcontrol,
  				   struct snd_ctl_elem_value *ucontrol)
  {
  	struct usb_mixer_interface *mixer =3D snd_kcontrol_chip(kcontrol);
  	u8 old_status, new_status;
  	int err, changed;

-	old_status =3D mixer->xonar_u1_status;
+	old_status =3D mixer->xonar_u_status;
  	if (ucontrol->value.integer.value[0])
  		new_status =3D old_status | 0x02;
  	else
@@ -449,27 +449,27 @@ static int snd_xonar_u1_switch_put(struct=20
snd_kcontrol *kcontrol,
  	up_read(&mixer->chip->shutdown_rwsem);
  	if (err < 0)
  		return err;
-	mixer->xonar_u1_status =3D new_status;
+	mixer->xonar_u_status =3D new_status;
  	return changed;
  }

-static struct snd_kcontrol_new snd_xonar_u1_output_switch =3D {
+static struct snd_kcontrol_new snd_xonar_u_output_switch =3D {
  	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
  	.name =3D "Digital Playback Switch",
  	.info =3D snd_ctl_boolean_mono_info,
-	.get =3D snd_xonar_u1_switch_get,
-	.put =3D snd_xonar_u1_switch_put,
+	.get =3D snd_xonar_u_switch_get,
+	.put =3D snd_xonar_u_switch_put,
  };

-static int snd_xonar_u1_controls_create(struct usb_mixer_interface *mixe=
r)
+static int snd_xonar_u_controls_create(struct usb_mixer_interface *mixer=
)
  {
  	int err;

  	err =3D snd_ctl_add(mixer->chip->card,
-			  snd_ctl_new1(&snd_xonar_u1_output_switch, mixer));
+			  snd_ctl_new1(&snd_xonar_u_output_switch, mixer));
  	if (err < 0)
  		return err;
-	mixer->xonar_u1_status =3D 0x05;
+	mixer->xonar_u_status =3D 0x05;
  	return 0;
  }

@@ -1110,7 +1110,7 @@ int snd_usb_mixer_apply_create_quirk(struct=20
usb_mixer_interface *mixer)
  	case USB_ID(0x0b05, 0x1739): /* ASUS Xonar U1 */
  	case USB_ID(0x0b05, 0x1743): /* ASUS Xonar U1 (2) */
  	case USB_ID(0x0b05, 0x17a0): /* ASUS Xonar U3 */
-		err =3D snd_xonar_u1_controls_create(mixer);
+		err =3D snd_xonar_u_controls_create(mixer);
  		break;

  	case USB_ID(0x17cc, 0x1011): /* Traktor Audio 6 */
--=20
1.8.0


--------------ms090807050404070204010904
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Kryptografische Unterschrift

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIINSjCC
BjQwggQcoAMCAQICAR4wDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoT
DVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3
MTAyNDIxMDE1NVoXDTE3MTAyNDIxMDE1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENs
aWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMcJg8zOLdgasSmkLhOr
lr6KMoOMpohBllVHrdRvEg/q6r8jR+EK75xCGhR8ToREoqe7zM9/UnC6TS2y9UKTpT1v7RSM
zR0t6ndl0TWBuUr/UXBhPk+Kmy7bI4yW4urC+y7P3/1/X7U8ocb8VpH/Clt+4iq7nirMcNh6
qJR+xjOhV+VHzQMALuGYn5KZmc1NbJQYclsGkDxDz2UbFqE2+6vIZoL+jb9x4Pa5gNf1TwSD
kOkikZB1xtB4ZqtXThaABSONdfmv/Z1pua3FYxnCFmdr/+N2JLKutIxMYqQOJebr/f/h5t95
m4JgrM3Y/w7YX9d7YAL9jvN4SydHsU6n65cCAwEAAaOCAa0wggGpMA8GA1UdEwEB/wQFMAMB
Af8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBRTcu2SnODaywFcfH6WNU7y1LhRgjAfBgNV
HSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRaMFgwJwYIKwYBBQUH
MAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYhaHR0cDovL3d3
dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20v
c2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBAAqD
CH14qywGXLhjjF6uHLkjd02hcdh9hrw+VUsv+q1eeQWB21jWj3kJ96AUlPCoEGZ/ynJNScWy
6QMVQjbbMXltUfO4n4bGGdKo3awPWp61tjAFgraLJgDk+DsSvUD6EowjMTNx25GQgyYJ5RPI
zKKR9tQW8gGK+2+RHxkUCTbYFnL6kl8Ch507rUdPPipJ9CgJFws3kDS3gOS5WFMxcjO5DwKf
KSETEPrHh7p5shuuNktvsv6hxHTLhiMKX893gxdT3XLS9OKmCv87vkINQcNEcIIoFWbP9HOR
z9v3vQwR4e3ksLc2JZOAFK+ssS5XMEoznzpihEP0PLc4dCBYjbvSD7kxgDwZ+Aj8Q9PkbvE9
sIPP7ON0fz095HdThKjiVJe6vofq+n6b1NBc8XdrQvBmunwxD5nvtTW4vtN6VY7mUCmxsCie
uoBJ9OlqmsVWQvifIYf40dJPZkk9YgGTzWLpXDSfLSplbY2LL9C9U0ptvjcDjefLTvqSFc7t
w1sEhF0n/qpA2r0GpvkLRDmcSwVyPvmjFBGqUp/pNy8ZuPGQmHwFi2/14+xeSUDG2bwnsYJQ
G2EdJCB6luQ57GEnTA/yKZSTKI8dDQa8Sd3zfXb19mOgSF0bBdXbuKhEpuP9wirslFe6fQ1t
5j5R0xi72MZ8ikMu1RQZKCyDbMwazlHiMIIHDjCCBfagAwIBAgIDA7lZMA0GCSqGSIb3DQEB
BQUAMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMi
U2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20g
Q2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwHhcNMTIwMjE0MTAwNTA4
WhcNMTMwMjE0MTgzOTI3WjBXMRkwFwYDVQQNExBMNmdGeFExWHdaeXRGN1lxMRkwFwYDVQQD
DBBkZW5pc3dAb25saW5lLmRlMR8wHQYJKoZIhvcNAQkBFhBkZW5pc3dAb25saW5lLmRlMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmAhzvlayB5uCi6VNrgC7OFelwcFCpjY6
1TV+7tW4Ty/UaO3GGGxT9VHvKTwrM26zR2yn0HGGeHPmEAjOYykM7ECdm9ngsEYgHeD6bFoU
nmTe++7hFFYpt45WBvRK3nNXwUWOCsNbdk8xJ3zKYg33dAC1ElgxDa7LVUbsUQs2KZs7POsN
eglKYbwJ+pf7KJDtUi03I+uePDD1tyL4V79kuJuWn+TDCt8aNRPrcnCm0upeo4zKIGbjRyg3
6dt8/f0Z0j0B1tCsxW+tJNYAuNW1wcd+uFtnK7naqE0H0yKWrWMKDoEH1kEBRXmqOyZh0z6A
MckT1d9koDI17rM8EWUsqwIDAQABo4IDqzCCA6cwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBTpR41raZ+/vaajVNrE
9QzD1rGCUDAfBgNVHSMEGDAWgBRTcu2SnODaywFcfH6WNU7y1LhRgjAbBgNVHREEFDASgRBk
ZW5pc3dAb25saW5lLmRlMIICIQYDVR0gBIICGDCCAhQwggIQBgsrBgEEAYG1NwECAjCCAf8w
LgYIKwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYB
BQUHAgEWKGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwgfcGCCsG
AQUFBwICMIHqMCcWIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MAMCAQEagb5U
aGlzIGNlcnRpZmljYXRlIHdhcyBpc3N1ZWQgYWNjb3JkaW5nIHRvIHRoZSBDbGFzcyAxIFZh
bGlkYXRpb24gcmVxdWlyZW1lbnRzIG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3ksIHJlbGlh
bmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBwdXJwb3NlIGluIGNvbXBsaWFuY2Ugb2YgdGhl
IHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMIGcBggrBgEFBQcCAjCBjzAnFiBTdGFydENv
bSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgECGmRMaWFiaWxpdHkgYW5kIHdhcnJhbnRp
ZXMgYXJlIGxpbWl0ZWQhIFNlZSBzZWN0aW9uICJMZWdhbCBhbmQgTGltaXRhdGlvbnMiIG9m
IHRoZSBTdGFydENvbSBDQSBwb2xpY3kuMDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwu
c3RhcnRzc2wuY29tL2NydHUxLWNybC5jcmwwgY4GCCsGAQUFBwEBBIGBMH8wOQYIKwYBBQUH
MAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIvY2xhc3MxL2NsaWVudC9jYTBCBggr
BgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2VydHMvc3ViLmNsYXNzMS5jbGll
bnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tLzANBgkqhkiG
9w0BAQUFAAOCAQEAq7F/lnxjk1g3NoypFR6OPukxeatCRGwayef2zSqZUDD2rR+zImknVpwE
Xu9q17bxfsb/TtP2ZP+eBh+8L8IBml78Twnn7pIUW8MHazbqNOz+bVgyxZRnMjQGKpy+P74T
dIm38z5aqQSL2tOpAQHxA0kBZFMF/5egW92oCkg66MA9zoz2ZVU342/E4Lt/CMYUfHeU4y6Y
4pR/qcMfu2zmeGi6kC/hHKDcB6ZAksl74GxkeGZIDpYbvzD6uvgCIJm/mjFFIJJGLG9MNezG
uWDLLpjsMbShkmJ3DjHMarrrEJzqcY3hwEL5ZkSpCYDs2DJEQGlglOvUeoZ7BnJ10Muj8jGC
A90wggPZAgEBMIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEr
MCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMv
U3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAwO5WTAJ
BgUrDgMCGgUAoIICHTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xMjEyMTExMDM5MjVaMCMGCSqGSIb3DQEJBDEWBBTXhx7wIhKhQnFjynAe37Na/SxUEzBs
BgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEo
MIGlBgkrBgEEAYI3EAQxgZcwgZQwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENv
bSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgw
NgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBD
QQIDA7lZMIGnBgsqhkiG9w0BCRACCzGBl6CBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoT
DVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNp
Z25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUg
Q2xpZW50IENBAgMDuVkwDQYJKoZIhvcNAQEBBQAEggEAPtSilEu/gQAFIYrolOo3zVhrO1qU
Csq0eONL8tw3jtMHnv1uzuYOzZ18/+WzpcdmxMJwFHdrm7dqAiX/kv3gUPXO1nhGVl5o1rxh
o+AnWHEOceE0Zz5SuN8amuoL2yQMgdaDFcF6tXidTxypg6V0Akboa5khpXDLPo1tljTDrzAw
xhxJX1UoH45VncA15sih7hDthfiB5qYABJQ0aYTg//GH1cL1FhxH2jd+xwJRxaidfQiS1fNi
7hZA+35CS2tIxs3VPDvC9h6pwniqyeMCAae9fCyTK2qugbJtNsLZGtZ15UaJ8PHJxcoAyyFR
AvlURhPJvL4rtRhtaETHPm7DsAAAAAAAAA==
--------------ms090807050404070204010904--

--===============3770105266626360758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3770105266626360758==--
