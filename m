From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: usb-midi rc3 patch request
Date: Fri, 16 Aug 2002 12:34:50 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020816103450.18779.qmail@web12203.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1389738481-1029494090=:18531"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--0-1389738481-1029494090=:18531
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

hallo,

the attached patch exports two functions of usb-midi,
so other "device-owning" drivers can use usb-midi's
capabilities.
the patched usb-midi driver is used by the us428
driver through those exported functions. 
we can avoid having different alsa-devices for the
same physical device this way.
plus usb-midi can be used for non standard devices,
which need special initialisations through a special
driver first.
the patched usb-midi drivers should work in all other
cases exactly as before.

patch_usbmidi_rc3.tar.bz2 contains 
file "diffs" :  patch file
file "alsa-kernel/usb/usbmidi.h" : to be added header

best regards,
karsten


__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de
--0-1389738481-1029494090=:18531
Content-Type: application/x-tbz; name="patch_usbmidi_rc3.tar.bz2"
Content-Transfer-Encoding: base64
Content-Description: patch_usbmidi_rc3.tar.bz2
Content-Disposition: attachment; filename="patch_usbmidi_rc3.tar.bz2"

QlpoOTFBWSZTWdyLnR0ADnR/lPiwABB7////f+//7v////oBAAABAAhgCz88
EPcYO5bRsBtt1cd1tIAAAAoEMkQapk9J6Mg1D1NqGmjR6IaGgAAAAA0eoAcN
DRk0aNGmhkZDCAMgBkGmgAAZAyAJQTIphU/UENAGjIAyABoBoAaBoNAACTUS
EmqeEj9UemgQ9EyAwj0DSMjQeo0AA0DR6gcNDRk0aNGmhkZDCAMgBkGmgAAZ
AyAJEggCTAmmmjKDETUD0I9EZAxGQADymnqDyn2o/dvPW+ByWPvohoERahAG
S7Dx2c5+JKSaJ+PxzqY60xF4i42oYQgE1Ik1CSDHxE+chq3dh1hJSOWFVbbw
GBHA8JWSGTndmVVVIjiYtcYKMSgmYIH1/VFoyXRWpo1VSk0iXaXVmKrAxGTF
XdW1arhoLFQTpjKFZePsva6of5zossz2Vl2PXpvTFGoRauuVtlIduqnVxt3j
rNC+Xv7+/xbXEm74+9ena2PhZlsiWe+k2NlzKsjp6HelPcysERENpamBGGE6
X77M1mevwg18Fjey2+8nLNKIzYyY4o5SlJSlBlIjLC19nS7uDttWrO2WDJDr
LOK2RRvkiBTSWQwGNAo+1DU+30EFCZssg0hpZ1/olYg/0cx/hchZCh7lQKSM
ds0TNp4u7s6u7bnCxN29EWlCjtuMwEtSiVFKCrexZBwg6oiwXjOM+IbTqGoX
QsPHP8waAaHO3t2INJ14xiCkBqRDyFuvXTxREN9AwiTGL4pJAtA24JvY5Zop
So8REkgvSORh1aMUEFULLLiCgPuypERMy67HHXkvqMQ2nfuuU3pgsrbp2F8k
Wf4tP2DXpLQYPIxwKXDNhAVKp6TNWWWrWSoVtVWfMtUi2rLCu8iTakXnnl7S
0oVCCZgHfcaw4zItGPH2ucutKxpZhTVoJLGhE6iMrLSNheRKdxGhjjKQxhn3
kA2lyi4uLSPWpzZ3VYQ08g3Hm6cQ/J1rZ6Oxay1IsNpET/nhTjGHvggcbNJN
XAa5g7W3pkqFDslU4Cr5NQ0wJSBQMFIPfxRYmDx5T02Vm/a3nDkdFFMwTNVu
/ky26fivvVHstyl0WaSk51jMrhGzgJZRvAWFRGVQiJdhZeC1Ag7k9b4ghdab
TFCQ0q6s+jty7a1r0UMpztpBFdAIKlR/KZjQ65US7ekWCDBGfNbtdhe9sbCm
wtKkTdIkT2CQfiEw3CWJsPRBmbRiYSgICiq1/xrb8gBI31tsC1O6/nEMb3/R
Yg+8y/4ozeKynu8aA0Gno5LX4gVwebW3eRDbbemReYo0MY1mhDbOaAID4tKr
4KknP59STuySiftyfP6p83JpCwmzf7QdMFHhB0sZBlDrvt/quuYqeBpd5pSn
cpjtRBScUJZUpSGT1u8YagF16vYkZWNJaiUzspupImbMqLlRi5BtJc8L8CYK
Q9e6g9dkId1laj2DdIMiPQuZRiEukpexCEK6g+CWlM+Msq0QtBV0cwxSEhkd
5MGKoS2AsPio00AeLI6yLZkKwBoITNsXmtnwnFlZmeqpyOdW1hVhzAzk1jXF
FNQNc0tlkNXXv6L9DVeeU0ua1zComSMJcoVu+Y1rl+uljS3MzvOiUGhy46wX
0NJc0/SWcRJfYJE1D3ZDg5l/F9O/LJghUTuX397MoDxw7MGuPM6MrGsqmSWv
3Nwjqbi15pgY4bCWTO5CZhHyAUySmj1yS7ukmIf5QR/Km0fxntVCSP3p5jP0
g52LqVOElDhUB8X4YSKmIXioMptFaUz1mBx4YL83u0VlgirCsSG4YSioYEtf
RBZ0SVuaocMUUCRyTMQ02WuVp2Kaot6t2hcGSFnlCpboN4Bgenj4jME0Qw1L
YKrTSDFXOCSSxHHpfauIcRN8kTlolhyFsizECqFJWWdBTTkZgo0FFSxUCLMg
zyM5MZlwLKqCCHiAcFzjlWly9V22WdDJrHAGckOohQxOCAeg8QetEZwTleiR
+ehfamfrgDIIwI5DMEeoIQgMCI/KFDQdFrSLx1u6fDe1caEhC8N4bRQNJGCB
ACKG2E7QCrv0Lwg1lTnuVgsS0/mh7x/SGI1nRMxCjDmSDu6zdEbQmxjEgb2s
0FwbJFPZdYF145CtjBXi1nlIRTWErVAQ7UTkL3Cx+4qWAqkpsYWhNyZCUFmC
ySyCCKIkqoQgyLjQzXQsEvYFTQWDS+Ifzo6wgoLUMI4OA6mHTJMaR/H+k0KR
G+12E9BrSQDPX9J3bTgUQXMAtMbzQEa0jwO59y8YMuUxzg2vkyT4nlCcqRJQ
cQauCUNEBOBexhfQCC4aSTGguQvCYfmKG8ljevW5ssErQvAKIYQZgtd5dUsS
3czzoLA2CGajOfuRMNCXwGNDSNkiDX4QiYGgFyDrReKL0Yl5YX4PUHwm4LQa
e4CBBqaQBuVyUEjI+rIQffXWcRiXywrhjHglVFEWjBo1EhYoAksAv5nWKii0
skHn1tsYXZCNPsiH6iAeha0kA1PgCS3Gs1Ma7EkBI1upaYnBCcBn2nkJny3I
7BkgxCoMkDQBfpJEjuqsTQHf2TkvjKBxCSUy1tbRSNRAYIpzYxkzgR3nkkPp
Ok2hO8Fv2ImmG0ryRoPAFsRhPmC+zxI3BQ+m/IPMEVLmOvIMpISwdQ1aBmKS
gGHsoCqYkzohCcQkjgwS6YbAptRZBC0H/Tb5ZBRJnVcDMxjLaUCxYjEI4kia
QmFAWKgEGoGhrLS7QsVEA2JLyBcNTINxmGIdymDpAIsGg1rp3aTSl1hgs0Zh
mAUN1wVWtLFUkdhg0mrQ7Q2HVqHYXluZsFUW077CVol0pcjIuLwDCbeBiEuf
YuDWRwDqMEtKGXrYg0BElAMmOIIJsHJECgIIeCPurXe4yHtLkIC8wBcukLy0
DFL61Uu2igGbRF4FUKSXA0yQjSZmpEAXoRnVHD3fhQzfbOZCuvIBhIsMiS7B
MLcCtwJVEkK0qKJO5i3/D1bjzRREgi4qGZJFoTg+TeEA14ELiShtEQMxSkok
GBL1GsUYImjy4FhQR8E4JDAyOJu8nCEQGwKRiM5cgCldxrbDK5ZUkoxcCySR
kEgm1cWi6QgCjShVr1lSxLfYWpSDIRk54nChArwsOwLyrQiplbkQBdp1YocQ
juzzSDkkzoDA+f9QtwVDQkEF9xtCQtJcp6hHiLNC5JKC0YDOtwkSEdsGADDt
GhQgZ7/UvPMLrqh0BM9yMj3o6Aj7iWo4iDXxMDuD0QUmIaQB6eWk5gvUiisz
hBCthH1815BnbU0EnQ1QsPChvJOdFWmUnM9TQAn/i7kinChIbkXOjoA=

--0-1389738481-1029494090=:18531--


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
