From: Rick Measham <rick@measham.id.au>
Subject: Re:
 =?iso-8859-7?q?1=2E0=2E16rc1_release_--_error=3A_=A1?=
 =?iso-8859-7?q?system=5Futsname=A2_undeclared?=
Date: Thu, 24 Jan 2008 23:14:46 +1100
Message-ID: <47988136.4030307@measham.id.au>
References: <Pine.LNX.4.61.0801221247570.9698@tm8103.perex-int.cz>	<47964342.1060608@measham.id.au>	<s5htzl5t45y.wl%tiwai@suse.de>
	<s5hsl0pt2uj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8034397488600173683=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from promethium.mailguard.com.au (promethium.mailguard.com.au
	[70.86.21.242]) by alsa0.perex.cz (Postfix) with ESMTP id E5EB6246B8
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 13:14:51 +0100 (CET)
In-Reply-To: <s5hsl0pt2uj.wl%tiwai@suse.de>
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

--===============8034397488600173683==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080409050102020202090604"

This is a cryptographically signed message in MIME format.

--------------ms080409050102020202090604
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> Nevermind, I myself can confirm that it's broken.
> The patch below should fix the problem.

I've grabbed hg and tried to apply the patch, but the line to be patched 
reads:
CFLAGS="$KERNEL_CHECK_CFLAGS"

So I changed it by hand to include the patched version:
CFLAGS="$KERNEL_CHECK_CFLAGS -Werror=implicit-function-declaration"

Which got me past the previous problem. However, hgcompile errors during 
make on alsa-driver/pci/ice1712/prodigy_hifi.o -- which I don't need. So 
once it errored, I ran:

./configure -with-cards=hda-intel --with-sequencer=yes

Which then had no problems with configure; make; make install.

I then ran hgcompile and 'make install' on alsa-lib and alsa-utils.

All fine.

But then when I went to restart alsa all hell broke loose!

# /etc/init.d/alsasound restart
Shutting down sound driver: done
Starting sound driver: snd-hda-intel FATAL: Error inserting snd 
(/lib/modules/2.6.20-16-386/kernel/sound/acore/snd.ko): Unknown symbol 
in module, or unknown parameter (see dmesg)
WARNING: Error running install command for snd
WARNING: Error inserting snd_hwdep 
(/lib/modules/2.6.20-16-386/kernel/sound/acore/snd-hwdep.ko): Unknown 
symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer 
(/lib/modules/2.6.20-16-386/kernel/sound/acore/snd-timer.ko): Unknown 
symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd 
(/lib/modules/2.6.20-16-386/kernel/sound/acore/snd.ko): Unknown symbol 
in module, or unknown parameter (see dmesg)
WARNING: Error running install command for snd
WARNING: Error inserting snd_timer 
(/lib/modules/2.6.20-16-386/kernel/sound/acore/snd-timer.ko): Unknown 
symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_pcm 
(/lib/modules/2.6.20-16-386/kernel/sound/acore/snd-pcm.ko): Unknown 
symbol in module, or unknown parameter (see dmesg)
WARNING: Error running install command for snd_pcm
FATAL: Error inserting snd_hda_intel 
(/lib/modules/2.6.20-16-386/kernel/sound/pci/hda/snd-hda-intel.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)
done


So as it suggested, I checked dmesg:

[96738.292000] snd: Unknown symbol pm_unregister
[96738.300000] snd_hwdep: Unknown symbol snd_info_register
[96738.300000] snd_hwdep: Unknown symbol snd_info_create_module_entry
[96738.300000] snd_hwdep: Unknown symbol snd_info_free_entry
[96738.300000] snd_hwdep: Unknown symbol snd_unregister_oss_device
[96738.300000] snd_hwdep: Unknown symbol snd_verbose_printk
[96738.300000] snd_hwdep: Unknown symbol snd_register_oss_device
[96738.300000] snd_hwdep: Unknown symbol snd_ctl_register_ioctl
[96738.300000] snd_hwdep: Unknown symbol snd_card_file_add
[96738.300000] snd_hwdep: Unknown symbol snd_iprintf
[96738.300000] snd_hwdep: Unknown symbol snd_major
[96738.300000] snd_hwdep: Unknown symbol snd_unregister_device
[96738.300000] snd_hwdep: Unknown symbol snd_device_new
[96738.300000] snd_hwdep: Unknown symbol snd_ctl_unregister_ioctl
[96738.300000] snd_hwdep: Unknown symbol snd_lookup_oss_minor_data
[96738.300000] snd_hwdep: Unknown symbol snd_lookup_minor_data
[96738.300000] snd_hwdep: Unknown symbol snd_card_file_remove
[96738.300000] snd_hwdep: Unknown symbol snd_register_device_for_dev
[96738.304000] snd_timer: Unknown symbol snd_info_register
[96738.304000] snd_timer: Unknown symbol snd_info_create_module_entry
[96738.304000] snd_timer: Unknown symbol snd_info_free_entry
[96738.304000] snd_timer: Unknown symbol snd_verbose_printk
[96738.304000] snd_timer: Unknown symbol snd_iprintf
[96738.304000] snd_timer: Unknown symbol snd_ecards_limit
[96738.304000] snd_timer: Unknown symbol snd_oss_info_register
[96738.304000] snd_timer: Unknown symbol snd_unregister_device
[96738.304000] snd_timer: Unknown symbol snd_device_new
[96738.304000] snd_timer: Unknown symbol snd_register_device_for_dev
[96738.344000] snd: Unknown symbol pm_unregister
[96738.344000] snd_timer: Unknown symbol snd_info_register
[96738.344000] snd_timer: Unknown symbol snd_info_create_module_entry
[96738.344000] snd_timer: Unknown symbol snd_info_free_entry
[96738.344000] snd_timer: Unknown symbol snd_verbose_printk
[96738.344000] snd_timer: Unknown symbol snd_iprintf
[96738.344000] snd_timer: Unknown symbol snd_ecards_limit
[96738.344000] snd_timer: Unknown symbol snd_oss_info_register
[96738.344000] snd_timer: Unknown symbol snd_unregister_device
[96738.344000] snd_timer: Unknown symbol snd_device_new
[96738.344000] snd_timer: Unknown symbol snd_register_device_for_dev
[96738.348000] snd_pcm: Unknown symbol snd_info_register
[96738.348000] snd_pcm: Unknown symbol snd_info_create_module_entry
[96738.348000] snd_pcm: Unknown symbol snd_timer_notify
[96738.348000] snd_pcm: Unknown symbol snd_timer_interrupt
[96738.348000] snd_pcm: Unknown symbol snd_info_free_entry
[96738.348000] snd_pcm: Unknown symbol snd_add_device_sysfs_file
[96738.348000] snd_pcm: Unknown symbol snd_info_get_str
[96738.348000] snd_pcm: Unknown symbol snd_verbose_printk
[96738.348000] snd_pcm: Unknown symbol snd_ctl_register_ioctl
[96738.348000] snd_pcm: Unknown symbol snd_card_file_add
[96738.348000] snd_pcm: Unknown symbol snd_iprintf
[96738.348000] snd_pcm: Unknown symbol snd_major
[96738.348000] snd_pcm: Unknown symbol snd_unregister_device
[96738.348000] snd_pcm: Unknown symbol snd_timer_new
[96738.348000] snd_pcm: Unknown symbol snd_device_new
[96738.348000] snd_pcm: Unknown symbol snd_ctl_unregister_ioctl
[96738.348000] snd_pcm: Unknown symbol snd_lookup_minor_data
[96738.348000] snd_pcm: Unknown symbol snd_info_create_card_entry
[96738.348000] snd_pcm: Unknown symbol snd_power_wait
[96738.348000] snd_pcm: Unknown symbol snd_device_free
[96738.348000] snd_pcm: Unknown symbol snd_card_file_remove
[96738.348000] snd_pcm: Unknown symbol snd_register_device_for_dev
[96738.348000] snd_pcm: Unknown symbol snd_device_register
[96738.348000] snd_pcm: Unknown symbol snd_info_get_line
[96738.356000] snd_hda_intel: Unknown symbol snd_ctl_add
[96738.356000] snd_hda_intel: Unknown symbol snd_pcm_new
[96738.356000] snd_hda_intel: Unknown symbol snd_pcm_limit_hw_rates
[96738.356000] snd_hda_intel: Unknown symbol snd_card_register
[96738.356000] snd_hda_intel: Unknown symbol snd_card_free
[96738.356000] snd_hda_intel: Unknown symbol 
snd_pcm_lib_preallocate_pages_for_all
[96738.356000] snd_hda_intel: Unknown symbol snd_card_proc_new
[96738.356000] snd_hda_intel: Unknown symbol snd_ctl_find_id
[96738.356000] snd_hda_intel: Unknown symbol snd_verbose_printk
[96738.356000] snd_hda_intel: Unknown symbol snd_ctl_new1
[96738.356000] snd_hda_intel: Unknown symbol snd_component_add
[96738.356000] snd_hda_intel: Unknown symbol snd_card_new
[96738.356000] snd_hda_intel: Unknown symbol snd_iprintf
[96738.356000] snd_hda_intel: Unknown symbol snd_pcm_lib_malloc_pages
[96738.356000] snd_hda_intel: Unknown symbol snd_ctl_boolean_mono_info
[96738.356000] snd_hda_intel: Unknown symbol snd_pcm_lib_ioctl
[96738.356000] snd_hda_intel: Unknown symbol snd_pcm_lib_free_pages
[96738.356000] snd_hda_intel: Unknown symbol snd_hwdep_new
[96738.356000] snd_hda_intel: Unknown symbol snd_pcm_set_ops
[96738.356000] snd_hda_intel: Unknown symbol snd_pcm_hw_constraint_list
[96738.356000] snd_hda_intel: Unknown symbol snd_device_new
[96738.356000] snd_hda_intel: Unknown symbol snd_pcm_suspend_all
[96738.356000] snd_hda_intel: Unknown symbol snd_card_disconnect
[96738.356000] snd_hda_intel: Unknown symbol snd_pcm_hw_constraint_integer
[96738.356000] snd_hda_intel: Unknown symbol snd_pci_quirk_lookup
[96738.356000] snd_hda_intel: Unknown symbol snd_pcm_period_elapsed
[96738.356000] snd_hda_intel: Unknown symbol snd_pcm_hw_constraint_step
[96738.356000] snd_hda_intel: Unknown symbol snd_pcm_format_width

So it looks like I've done something fairly wrong somewhere :-D

I had this problem with I only configured for hda-intel with another 
release (I can't remember which) but it went away if I didn't specify 
any parameters to 'configure'.

Unfortunately, I can't do that while 
alsa-driver/pci/ice1712/prodigy_hifi.o is erroring during the make:

   [-- lots snipped --]
   CC [M]  /usr/src/alsa/alsa-driver/pci/ice1712/aureon.o
   CC [M]  /usr/src/alsa/alsa-driver/pci/ice1712/vt1720_mobo.o
   CC [M]  /usr/src/alsa/alsa-driver/pci/ice1712/pontis.o
   CC [M]  /usr/src/alsa/alsa-driver/pci/ice1712/prodigy192.o
make[4]: *** No rule to make target 
`/usr/src/alsa/alsa-driver/pci/ice1712/prodigy_hifi.o', needed by 
`/usr/src/alsa/alsa-driver/pci/ice1712/snd-ice1712.o'.  Stop.
make[3]: *** [/usr/src/alsa/alsa-driver/pci/ice1712] Error 2
make[2]: *** [/usr/src/alsa/alsa-driver/pci] Error 2
make[1]: *** [_module_/usr/src/alsa/alsa-driver] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.20-16-386'
make: *** [compile] Error 2

Any chance of further help? I'm concerned that I might be taking your 
time away from dev work to fix some obscurity ..

Cheers!
Rick Measham

P.S. Would you prefer that I put outputs into a pastebin and just 
include links?

--------------ms080409050102020202090604
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
CSqGSIb3DQEJBTEPFw0wODAxMjQxMjE0NDZaMCMGCSqGSIb3DQEJBDEWBBRG3E2BkDL1puC7
rzV+Q7T5DQMM1DBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIA
gDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBhQYJKwYBBAGCNxAE
MXgwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkg
THRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEHah
vhsVL0qy1CdO97KnttwwgYcGCyqGSIb3DQEJEAILMXigdjBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEHahvhsVL0qy1CdO97KnttwwDQYJKoZIhvcN
AQEBBQAEggEALwzB82QX6OydUCQyFgiayB/SevZC/oLM59QA6gtLDbt4bW4l8zX/sgXIN9zl
XTnCZWIYpPCFTEdhvCYYH2HM1JYFme3ChNsRcPOvXOTfqLaSouOPDsogVeEk62cYvW2OZesv
51fuo8+S0A75XXiEt2UTmF1hHszaYNWJj3TtxyjG6yYDxzdP8ggYJtxmX7h1HvHE+yO73LSj
TGx0j/MhZvAvVwl3jdSdVqLSBM7urF6O/2ZQ8aNRQRvXvEtMNN9DzIacNRbFHv8jevNHmo/e
oFno6hcJK4b/fiMFA75KCXt+vxitGl46f3ZLe7oKSBRbrsNsfZBiS5AA1fsqBC4vaAAAAAAA
AA==
--------------ms080409050102020202090604--

--===============8034397488600173683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8034397488600173683==--
