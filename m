From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ymfpci, big-endian, and spdif out
Date: Wed, 8 Jan 2003 12:30:33 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301081229000.531-200000@pnote.perex-int.cz>
References: <20030108053721.GC10119@kalmia.hozed.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-416552815-1042025433=:531"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030108053721.GC10119@kalmia.hozed.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Troy Benjegerdes <hozer@hozed.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323584-416552815-1042025433=:531
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 7 Jan 2003, Troy Benjegerdes wrote:

> On Tue, Jan 07, 2003 at 05:02:53PM +0100, Takashi Iwai wrote:
> > At Thu, 2 Jan 2003 22:22:34 -0600,
> > Troy Benjegerdes wrote:
> > > 
> > > I have a mac G4 (running debian testing), a ymfpci card (MaxiSound
> > > Fortissimo) with optical TOSlink out, and a yamaha HTR-5540 receiver with
> > > digital optical TOSlink input.
> > > 
> > > I'm trying to get xine or some other DVD player to output AC/3 sound to 
> > > the receiver for watching dvd's, and I have a couple of problems.
> > > 
> > > 1) xmms (and xine 2-channel sound) works with OSS emulation, but is static
> > > 	with native ALSA drivers. This seems like some endian problem
> > 
> > then most likely it's a bug of alsa output plugin.
> 
> It seems the latest xmms source uses 'S16_NE' (which is S16_BE on
> big-endian platforms) as the pcm format, which works correctly.
> 
> alsa-tools/acdec/output.c also has a problem.. it uses S16_LE on
> big-endian platforms.
> 
> I am able to successfully open the SPDIF output and output *something*
> with a commandline like:
> 
> ac3dec -D hw:0,0 -C THX.ac3
> 
> However, the hardware decoder (yamaha receiver) is getting garbled data
> and plays what sounds like stacatto static.
> 
> ac3dec -C THX.ac3 gives the following:
> 
> Using PCM device 'iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2'
> ALSA lib pcm_hw.c:292:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
> failed: No such device or address
> PCM hw_params failed: No such device or address
> Output open failed
> 
> Another interesting bit...
> If I change S16_LE to S16_BE in output.c, now it works with regular 2
> channel audio, but anything with the '-C' option gives:
> 
> Using PCM device 'hw:0,0'
> Sample format non availableOutput open failed
> 
> Using PCM device 'iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2'
> Sample format non availableOutput open failed
> 
> 
> Should the alsa drive be able to byteswap SPDIF data??

There were a few bad assumtions in the spdif code. Could you try the 
latest CVS code of ac3dec (or attached patch)?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

--8323584-416552815-1042025433=:531
Content-Type: TEXT/plain; name="out.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0301081230330.531@pnote.perex-int.cz>
Content-Description: 
Content-Disposition: attachment; filename="out.txt"

PyBvdXQudHh0DQpJbmRleDogYWMzc3BkaWYuYw0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KUkNTIGZpbGU6IC9jdnNyb290L2Fsc2EvYWxzYS10b29scy9h
YzNkZWMvYWMzc3BkaWYuYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMw0K
ZGlmZiAtdSAtcjEuMyBhYzNzcGRpZi5jDQotLS0gYWMzc3BkaWYuYwk2IEF1
ZyAyMDAxIDE2OjA4OjAxIC0wMDAwCTEuMw0KKysrIGFjM3NwZGlmLmMJOCBK
YW4gMjAwMyAxMToyODo0OCAtMDAwMA0KQEAgLTE1NCw3ICsxNTQsNyBAQA0K
ICAgICAgICAgZG9uZV9iYW5uZXIgPSAxOw0KICAgICAgIH0NCiAgICAgICAN
Ci0jaWZuZGVmIFdPUkRTX0JJR0VORElBTg0KKyNpZm5kZWYgX2FfYl9jX2Rf
ZV9mIC8qIFdPUkRTX0JJR0VORElBTiAqLw0KICAgICAgIC8vIGV4dHJhY3Rf
YWMzIHNlZW1zIHRvIHdyaXRlIHN3YWJiZWQgZGF0YQ0KICAgICAgIHN3YWIo
JmJ1ZlsxMF0sICZidWZbMTBdLCBzeW5jaW5mby5mcmFtZV9zaXplICogMiAt
IDIpOw0KICNlbmRpZg0KSW5kZXg6IG91dHB1dC5jDQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3QvYWxzYS9hbHNhLXRvb2xz
L2FjM2RlYy9vdXRwdXQuYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTcN
CmRpZmYgLXUgLXIxLjE3IG91dHB1dC5jDQotLS0gb3V0cHV0LmMJMjIgT2N0
IDIwMDIgMTg6MDE6MTYgLTAwMDAJMS4xNw0KKysrIG91dHB1dC5jCTggSmFu
IDIwMDMgMTE6Mjg6NDggLTAwMDANCkBAIC00MSw2ICs0MSw3IEBADQogCWNo
YXIgZGV2c3RyWzEyOF07DQogCXNuZF9wY21faHdfcGFyYW1zX3QgKnBhcmFt
czsNCiAJdW5zaWduZWQgaW50IHJhdGUsIGJ1ZmZlcl90aW1lLCBwZXJpb2Rf
dGltZSwgdG1wOw0KKwlzbmRfcGNtX2Zvcm1hdF90IGZvcm1hdCA9IG91dHB1
dC0+Yml0cyA9PSAxNiA/IFNORF9QQ01fRk9STUFUX1MxNiA6IFNORF9QQ01f
Rk9STUFUX1U4Ow0KIAlpbnQgZXJyLCBzdGVwOw0KIAlzbmRfcGNtX2h3X3Bh
cmFtc19hbGxvY2EoJnBhcmFtcyk7DQogDQpAQCAtNzYsNiArNzcsNyBAQA0K
IAkJCQlzcHJpbnRmKGRldnN0ciwgImllYzk1ODpBRVMwPTB4JXgsQUVTMT0w
eCV4LEFFUzI9MHgleCxBRVMzPTB4JXgiLCBzWzBdLCBzWzFdLCBzWzJdLCBz
WzNdKTsNCiAJCQkJaWYgKG91dF9jb25maWcuY2FyZCkNCiAJCQkJCXNwcmlu
dGYoZGV2c3RyICsgc3RybGVuKGRldnN0ciksICIsQ0FSRD0lcyIsIG91dF9j
b25maWcuY2FyZCk7DQorCQkJCWZvcm1hdCA9IFNORF9QQ01fRk9STUFUX1Mx
Nl9MRTsNCiAJCQl9IGVsc2Ugew0KIAkJCQlpZiAob3V0X2NvbmZpZy5jYXJk
KQ0KIAkJCQkJc3ByaW50ZihkZXZzdHIsICJwbHVnaHc6JXMiLCBvdXRfY29u
ZmlnLmNhcmQpOw0KQEAgLTExNCwyOSArMTE2LDI5IEBADQogCWVyciA9IHNu
ZF9wY21faHdfcGFyYW1zX3NldF9hY2Nlc3MocGNtLCBwYXJhbXMsDQogCQkJ
CQkgICBTTkRfUENNX0FDQ0VTU19SV19JTlRFUkxFQVZFRCk7DQogCWlmIChl
cnIgPCAwKSB7DQotCQlmcHJpbnRmKHN0ZGVyciwgIkFjY2VzcyB0eXBlIG5v
dCBhdmFpbGFibGUiKTsNCisJCWZwcmludGYoc3RkZXJyLCAiQWNjZXNzIHR5
cGUgbm90IGF2YWlsYWJsZVxuIik7DQogCQlnb3RvIF9fY2xvc2U7DQogCX0N
Ci0JZXJyID0gc25kX3BjbV9od19wYXJhbXNfc2V0X2Zvcm1hdChwY20sIHBh
cmFtcywgb3V0cHV0LT5iaXRzID09IDE2ID8gU05EX1BDTV9GT1JNQVRfUzE2
X0xFIDogU05EX1BDTV9GT1JNQVRfVTgpOw0KKwllcnIgPSBzbmRfcGNtX2h3
X3BhcmFtc19zZXRfZm9ybWF0KHBjbSwgcGFyYW1zLCBmb3JtYXQpOw0KIAlp
ZiAoZXJyIDwgMCkgew0KLQkJZnByaW50ZihzdGRlcnIsICJTYW1wbGUgZm9y
bWF0IG5vbiBhdmFpbGFibGUiKTsNCisJCWZwcmludGYoc3RkZXJyLCAiU2Ft
cGxlIGZvcm1hdCBub24gYXZhaWxhYmxlXG4iKTsNCiAJCWdvdG8gX19jbG9z
ZTsNCiAJfQ0KIAllcnIgPSBzbmRfcGNtX2h3X3BhcmFtc19zZXRfY2hhbm5l
bHMocGNtLCBwYXJhbXMsIG91dHB1dC0+Y2hhbm5lbHMpOw0KIAlpZiAoZXJy
IDwgMCkgew0KLQkJZnByaW50ZihzdGRlcnIsICJDaGFubmVscyBjb3VudCBu
b24gYXZhaWxhYmxlIik7DQorCQlmcHJpbnRmKHN0ZGVyciwgIkNoYW5uZWxz
IGNvdW50IG5vbiBhdmFpbGFibGVcbiIpOw0KIAkJZ290byBfX2Nsb3NlOw0K
IAl9DQogCXJhdGUgPSBvdXRwdXQtPnJhdGU7DQogCWVyciA9IHNuZF9wY21f
aHdfcGFyYW1zX3NldF9yYXRlX25lYXIocGNtLCBwYXJhbXMsICZyYXRlLCAw
KTsNCiAJaWYgKGVyciA8IDApIHsNCi0JCWZwcmludGYoc3RkZXJyLCAiUmF0
ZSBub3QgYXZhaWxhYmxlIik7DQorCQlmcHJpbnRmKHN0ZGVyciwgIlJhdGUg
bm90IGF2YWlsYWJsZVxuIik7DQogCQlnb3RvIF9fY2xvc2U7DQogCX0NCiAJ
YnVmZmVyX3RpbWUgPSA1MDAwMDA7DQogCWVyciA9IHNuZF9wY21faHdfcGFy
YW1zX3NldF9idWZmZXJfdGltZV9uZWFyKHBjbSwgcGFyYW1zLCAmYnVmZmVy
X3RpbWUsIDApOw0KIAlpZiAoZXJyIDwgMCkgew0KLQkJZnByaW50ZihzdGRl
cnIsICJCdWZmZXIgdGltZSBub3QgYXZhaWxhYmxlIik7DQorCQlmcHJpbnRm
KHN0ZGVyciwgIkJ1ZmZlciB0aW1lIG5vdCBhdmFpbGFibGVcbiIpOw0KIAkJ
Z290byBfX2Nsb3NlOw0KIAl9DQogCXN0ZXAgPSAyOw0KQEAgLTE0Niw3ICsx
NDgsNyBAQA0KIAkJdG1wID0gcGVyaW9kX3RpbWU7DQogCQllcnIgPSBzbmRf
cGNtX2h3X3BhcmFtc19zZXRfcGVyaW9kX3RpbWVfbmVhcihwY20sIHBhcmFt
cywgJnRtcCwgMCk7DQogCQlpZiAoZXJyIDwgMCkgew0KLQkJCWZwcmludGYo
c3RkZXJyLCAiUGVyaW9kIHRpbWUgbm90IGF2YWlsYWJsZSIpOw0KKwkJCWZw
cmludGYoc3RkZXJyLCAiUGVyaW9kIHRpbWUgbm90IGF2YWlsYWJsZVxuIik7
DQogCQkJZ290byBfX2Nsb3NlOw0KIAkJfQ0KIAkJaWYgKHRtcCA9PSBwZXJp
b2RfdGltZSkgew0K
--8323584-416552815-1042025433=:531--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
