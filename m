From: Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Subject: Re: usb audio race at disconnect time
Date: Tue, 16 Oct 2012 18:01:13 +0200
Message-ID: <507D84C9.9070405@parrot.com>
References: <5076E327.5030503@parrot.com>	<s5hvceh9d0v.wl%tiwai@suse.de>	<50783A5B.9090009@parrot.com>	<s5h626eixid.wl%tiwai@suse.de>	<507C4AD4.2090400@parrot.com> <s5hwqyrh8vb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------040907030109060606030001"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hwqyrh8vb.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ALSA devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--------------040907030109060606030001
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Takashi Iwai a écrit :
> At Mon, 15 Oct 2012 19:41:40 +0200,
> Matthieu CASTET wrote:
>> Hi Takashi,
>>
>> But I believe I found other races in the alsa char device handling. With the
>> attached patch, if you disconnect the usb audio device between "msleep o" and
>> "msleep o+", you will free the card resource (snd_card_do_free) and then use it [1].
>>
>> I did in in snd_ctl_open, but the same thing could be done in snd_pcm_open, ...
> 
> OK, we'd need a generic open/close protection.
> For PCM, there is already a fix in my last patchset, so it should
> work, but for other devices, the paths are still uncovered.
> 
I don't think it will work for pcm : the begin of snd_pcm_open is not protected
by any lock even with your patch
In snd_open we release sound_mutex before calling file->f_op->open.

The snd_lookup_minor_data and snd_card_file_add should be protected by a lock.
Attached a patch (pcm.crash) that help to trigger [1].


One idea could be to do the snd_card_file_add in snd_lookup_minor_data : it will
be protected by sound_mutex.

That what rfc attachement does (with debug printk and delay) : it add a
snd_lookup_minor_data2 that do the snd_card_file_add.


Matthieu



[1]

# cat /dev/pcmC0D0c
[  572.187866] msleep o cf1e1200
[  573.534454] usb 1-2: USB disconnect, device number 2
[  573.543670] usb 1-2.1: USB disconnect, device number 3
[  573.561645] usb 1-2.1.2: USB disconnect, device number 4
[  577.337005] msleep o+
[  577.339477] Unable to handle kernel paging request at virtual address 6b6b6d87
[  577.347106] pgd = cccf4000
[  577.349975] [6b6b6d87] *pgd=00000000
[  577.353759] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[  577.359374] Modules linked in:
[  577.362640] CPU: 0    Not tainted  (3.7.0-rc1-00004-gd6355f5-dirty #27)
[  577.369628] PC is at __lock_acquire.clone.19+0x150/0xd40
[  577.375274] LR is at lock_acquire+0x5c/0x70
[  577.379699] pc : [<c0088b10>]    lr : [<c0089cd0>]    psr: 80000093
[  577.379699] sp : cca01c28  ip : 00000001  fp : cca01c84
[  577.391784] r10: c05d5814  r9 : 6b6b6d83  r8 : 00000080
[  577.397308] r7 : cf15f480  r6 : 00000000  r5 : c05b67bc  r4 : cca00000
[  577.404205] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 6b6b6d83
[  577.411102] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  577.418731] Control: 10c5387d  Table: 8ccf4019  DAC: 00000015
[  577.424804] Process cat (pid: 642, stack limit = 0xcca00240)
[  577.430786] Stack: (0xcca01c28 to 0xcca02000)
[  577.435394] 1c20:                   00000001 20000093 000000c4 00000000
c05ae4a8 00000001
[  577.444030] 1c40: 00000000 c05d4b40 00000009 c05ae478 60000013 00000004
cca01ccc 00000000
[  577.452667] 1c60: cca00000 60000013 cf15f480 00000001 00000024 cf7bcd40
cca01cb4 cca01c88
[  577.461334] 1c80: c0089cd0 c00889cc 00000000 00000000 c02eacec 00000000
6b6b6d73 c02eacec
[  577.469970] 1ca0: ccd12f00 6b6b6d73 cca01cdc cca01cb8 c03e5234 c0089c80
00000001 00000000
[  577.478607] 1cc0: c02eacec cf0980a8 6b6b6b6b cf0980a8 cca01cfc cca01ce0
c02eacec c03e51f8
[  577.487243] 1ce0: cf0980a8 ffffffff c05b65d4 cf1e1200 cca01d4c cca01d00
c02fbb84 c02eaca8
[  577.495880] 1d00: 22222222 cf1e1200 00000018 cd9d0120 07400018 c09d9af8
cca01d34 cca01d28
[  577.504547] 1d20: c03e33fc cf0980a8 cd9d0120 cd9d0120 07400018 c09d9af8
00000024 cf7bcd40
[  577.513183] 1d40: cca01d64 cca01d50 c02fbd90 c02fbb20 c0411378 cf0980a8
cca01d8c cca01d68
[  577.521820] 1d60: c02ea810 c02fbd58 cd9d0120 cf0980a8 cf1fb1c0 00000000
c00f505c 00000000
[  577.530456] 1d80: cca01db4 cca01d90 c00f50f4 c02ea774 c00f25cc 00000018
cf0980a8 cd9d0120
[  577.539093] 1da0: cf0980b0 00020001 cca01ddc cca01db8 c00ef404 c00f5068
cca01ea0 cca01f60
[  577.547729] 1dc0: 00000000 00020000 cca01e98 00000000 cca01df4 cca01de0
c00ef4c0 c00ef240
[  577.556365] 1de0: cca01ea0 cca01ee0 cca01e6c cca01df8 c00fe348 c00ef4a4
cca01e6c cca01e08
[  577.565002] 1e00: c00fb704 c00fb4a8 cca01e3c cca01e18 c004b2c8 c007d99c
00000000 cca01ee8
[  577.573638] 1e20: 00000000 00000000 ceb2f178 cf0980a8 cf016e58 ceb2f178
cd9d0120 cf2fa830
[  577.582275] 1e40: 386d45b8 cca01ee0 ceb42bf8 cca01e98 cca01f60 00000000
cca01ea0 cca00000
[  577.590911] 1e60: cca01ed4 cca01e70 c00fec00 c00fdd70 cca01ea0 00000000
00000004 00000000
[  577.599548] 1e80: 000000e5 00000000 cf0980a8 cca01e90 cf016e58 ceb42bf8
cf016e58 ceb40d38
[  577.608215] 1ea0: 00000000 00000000 cca01ee4 cca01f60 00000001 ffffff9c
cf30f000 ffffff9c
[  577.616851] 1ec0: cca00000 00000000 cca01f54 cca01ed8 c00ff0f8 c00fe958
00000041 cf0235e0
[  577.625488] 1ee0: cf016e58 ceb40d38 d24edc20 00000008 ce487d44 cf7b3d90
cf016318 ce8021f8
[  577.634124] 1f00: cd9d0120 00000101 00000004 00000000 00000000 ce487d40
00020000 cf30f000
[  577.642761] 1f20: 00020000 be9ecf92 00000001 ffffff9c cca00000 00000000
cf30f000 00020000
[  577.651397] 1f40: 00000003 00000001 cca01f94 cca01f58 c00f044c c00ff0d0
c0060598 c03e44d0
[  577.660034] 1f60: 00020000 cca00000 00000024 00000100 00000000 00000000
be9ecf92 00000005
[  577.668701] 1f80: c0014808 00000000 cca01fa4 cca01f98 c00f0504 c00f036c
00000000 cca01fa8
[  577.677337] 1fa0: c0014660 c00f04e8 00000000 00000000 be9ecf92 00020000
00000000 000030ec
[  577.685974] 1fc0: 00000000 00000000 be9ecf92 00000005 00000008 00000000
b6f5f000 00000000
[  577.694610] 1fe0: b6e163b0 be9eccd0 0000d898 b6e16400 60000010 be9ecf92
00000000 00000000
[  577.703247] Backtrace:
[  577.705841] [<c00889c0>] (__lock_acquire.clone.19+0x0/0xd40) from
[<c0089cd0>] (lock_acquire+0x5c/0x70)
[  577.715789] [<c0089c74>] (lock_acquire+0x0/0x70) from [<c03e5234>]
(_raw_spin_lock+0x48/0x58)
[  577.724792]  r7:6b6b6d73 r6:ccd12f00 r5:c02eacec r4:6b6b6d73
[  577.730834] [<c03e51ec>] (_raw_spin_lock+0x0/0x58) from [<c02eacec>]
(snd_card_file_add+0x50/0xac)
[  577.740295]  r5:cf0980a8 r4:6b6b6b6b
[  577.744110] [<c02eac9c>] (snd_card_file_add+0x0/0xac) from [<c02fbb84>]
(snd_pcm_open+0x70/0x238)
[  577.753479]  r7:cf1e1200 r6:c05b65d4 r5:ffffffff r4:cf0980a8
[  577.759521] [<c02fbb14>] (snd_pcm_open+0x0/0x238) from [<c02fbd90>]
(snd_pcm_capture_open+0x44/0x48)
[  577.769165] [<c02fbd4c>] (snd_pcm_capture_open+0x0/0x48) from [<c02ea810>]
(snd_open+0xa8/0x1a0)
[  577.778442]  r5:cf0980a8 r4:c0411378
[  577.782257] [<c02ea768>] (snd_open+0x0/0x1a0) from [<c00f50f4>]
(chrdev_open+0x98/0x160)
[  577.790832] [<c00f505c>] (chrdev_open+0x0/0x160) from [<c00ef404>]
(do_dentry_open.clone.16+0x1d0/0x264)
[  577.800842]  r7:00020001 r6:cf0980b0 r5:cd9d0120 r4:cf0980a8
[  577.806884] [<c00ef234>] (do_dentry_open.clone.16+0x0/0x264) from
[<c00ef4c0>] (finish_open+0x28/0x40)
[  577.816711] [<c00ef498>] (finish_open+0x0/0x40) from [<c00fe348>]
(do_last.clone.47+0x5e4/0xbe8)
[  577.825988]  r4:cca01ee0 r3:cca01ea0
[  577.829803] [<c00fdd64>] (do_last.clone.47+0x0/0xbe8) from [<c00fec00>]
(path_openat.clone.48+0x2b4/0x488)
[  577.839996] [<c00fe94c>] (path_openat.clone.48+0x0/0x488) from [<c00ff0f8>]
(do_filp_open+0x34/0x88)
[  577.849670] [<c00ff0c4>] (do_filp_open+0x0/0x88) from [<c00f044c>]
(do_sys_open+0xec/0x17c)
[  577.858489]  r7:00000001 r6:00000003 r5:00020000 r4:cf30f000
[  577.864532] [<c00f0360>] (do_sys_open+0x0/0x17c) from [<c00f0504>]
(sys_open+0x28/0x2c)
[  577.872985] [<c00f04dc>] (sys_open+0x0/0x2c) from [<c0014660>]
(ret_fast_syscall+0x0/0x30)
[  577.881744] Code: ebfeebea e1a00004 ea000038 e0890106 (e5908004)
[  577.888183] ---[ end trace 5c43a835149de569 ]---




--------------040907030109060606030001
Content-Type: text/plain; name="pcm.crash"
Content-Transfer-Encoding: base64
Content-Disposition: inline; filename="pcm.crash"

ZGlmZiAtLWdpdCBhL3NvdW5kL2NvcmUvcGNtX25hdGl2ZS5jIGIvc291bmQvY29yZS9wY21f
bmF0aXZlLmMKaW5kZXggODc1M2M4OS4uMGNiZTQ3MSAxMDA2NDQKLS0tIGEvc291bmQvY29y
ZS9wY21fbmF0aXZlLmMKKysrIGIvc291bmQvY29yZS9wY21fbmF0aXZlLmMKQEAgLTIxMzAs
MTEgKzIxMzAsMTYgQEAgc3RhdGljIGludCBzbmRfcGNtX2NhcHR1cmVfb3BlbihzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKIAlyZXR1cm4gc25kX3BjbV9vcGVu
KGZpbGUsIHBjbSwgU05EUlZfUENNX1NUUkVBTV9DQVBUVVJFKTsKIH0KIAorI2luY2x1ZGUg
PGxpbnV4L2RlbGF5Lmg+CiBzdGF0aWMgaW50IHNuZF9wY21fb3BlbihzdHJ1Y3QgZmlsZSAq
ZmlsZSwgc3RydWN0IHNuZF9wY20gKnBjbSwgaW50IHN0cmVhbSkKIHsKIAlpbnQgZXJyOwog
CXdhaXRfcXVldWVfdCB3YWl0OwogCisJcHJpbnRrKCJtc2xlZXAgbyAlcFxuIiwgcGNtKTsK
KwltZGVsYXkoNTAwMCk7CisJcHJpbnRrKCJtc2xlZXAgbytcbiIpOworCiAJaWYgKHBjbSA9
PSBOVUxMKSB7CiAJCWVyciA9IC1FTk9ERVY7CiAJCWdvdG8gX19lcnJvcjE7Cg==
--------------040907030109060606030001
Content-Type: text/plain; name="rfc"
Content-Transfer-Encoding: base64
Content-Disposition: inline; filename="rfc"

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvc291bmQvY29yZS5oIGIvaW5jbHVkZS9zb3VuZC9jb3Jl
LmgKaW5kZXggYmMwNTY2OC4uOTg2OTA4NyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9zb3VuZC9j
b3JlLmgKKysrIGIvaW5jbHVkZS9zb3VuZC9jb3JlLmgKQEAgLTE4NSw2ICsxODUsNyBAQCBz
dGF0aWMgaW5saW5lIGludCBzbmRfcG93ZXJfd2FpdChzdHJ1Y3Qgc25kX2NhcmQgKmNhcmQs
IHVuc2lnbmVkIGludCBzdGF0ZSkgeyByZQogc3RydWN0IHNuZF9taW5vciB7CiAJaW50IHR5
cGU7CQkJLyogU05EUlZfREVWSUNFX1RZUEVfWFhYICovCiAJaW50IGNhcmQ7CQkJLyogY2Fy
ZCBudW1iZXIgKi8KKwlzdHJ1Y3Qgc25kX2NhcmQgKmNhcmRwOwogCWludCBkZXZpY2U7CQkJ
LyogZGV2aWNlIG51bWJlciAqLwogCWNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgKmZf
b3BzOwkvKiBmaWxlIG9wZXJhdGlvbnMgKi8KIAl2b2lkICpwcml2YXRlX2RhdGE7CQkvKiBw
cml2YXRlIGRhdGEgZm9yIGZfb3BzLT5vcGVuICovCkBAIC0yNDEsNiArMjQyLDcgQEAgc3Rh
dGljIGlubGluZSBpbnQgc25kX3JlZ2lzdGVyX2RldmljZShpbnQgdHlwZSwgc3RydWN0IHNu
ZF9jYXJkICpjYXJkLCBpbnQgZGV2LAogCiBpbnQgc25kX3VucmVnaXN0ZXJfZGV2aWNlKGlu
dCB0eXBlLCBzdHJ1Y3Qgc25kX2NhcmQgKmNhcmQsIGludCBkZXYpOwogdm9pZCAqc25kX2xv
b2t1cF9taW5vcl9kYXRhKHVuc2lnbmVkIGludCBtaW5vciwgaW50IHR5cGUpOwordm9pZCAq
c25kX2xvb2t1cF9taW5vcl9kYXRhMih1bnNpZ25lZCBpbnQgbWlub3IsIGludCB0eXBlLCBz
dHJ1Y3QgZmlsZSAqZmlsZSk7CiBpbnQgc25kX2FkZF9kZXZpY2Vfc3lzZnNfZmlsZShpbnQg
dHlwZSwgc3RydWN0IHNuZF9jYXJkICpjYXJkLCBpbnQgZGV2LAogCQkJICAgICAgc3RydWN0
IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIpOwogCmRpZmYgLS1naXQgYS9zb3VuZC9jb3JlL3Bj
bV9uYXRpdmUuYyBiL3NvdW5kL2NvcmUvcGNtX25hdGl2ZS5jCmluZGV4IDg3NTNjODkuLmMy
NDQ1YzAgMTAwNjQ0Ci0tLSBhL3NvdW5kL2NvcmUvcGNtX25hdGl2ZS5jCisrKyBiL3NvdW5k
L2NvcmUvcGNtX25hdGl2ZS5jCkBAIC0yMTE0LDggKzIxMTQsOCBAQCBzdGF0aWMgaW50IHNu
ZF9wY21fcGxheWJhY2tfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAq
ZmlsZSkKIAlpbnQgZXJyID0gbm9uc2Vla2FibGVfb3Blbihpbm9kZSwgZmlsZSk7CiAJaWYg
KGVyciA8IDApCiAJCXJldHVybiBlcnI7Ci0JcGNtID0gc25kX2xvb2t1cF9taW5vcl9kYXRh
KGltaW5vcihpbm9kZSksCi0JCQkJICAgIFNORFJWX0RFVklDRV9UWVBFX1BDTV9QTEFZQkFD
Syk7CisJcGNtID0gc25kX2xvb2t1cF9taW5vcl9kYXRhMihpbWlub3IoaW5vZGUpLAorCQkJ
CSAgICBTTkRSVl9ERVZJQ0VfVFlQRV9QQ01fUExBWUJBQ0ssIGZpbGUpOwogCXJldHVybiBz
bmRfcGNtX29wZW4oZmlsZSwgcGNtLCBTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLKTsKIH0K
IApAQCAtMjEyNSwyMyArMjEyNSwyNCBAQCBzdGF0aWMgaW50IHNuZF9wY21fY2FwdHVyZV9v
cGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQogCWludCBlcnIg
PSBub25zZWVrYWJsZV9vcGVuKGlub2RlLCBmaWxlKTsKIAlpZiAoZXJyIDwgMCkKIAkJcmV0
dXJuIGVycjsKLQlwY20gPSBzbmRfbG9va3VwX21pbm9yX2RhdGEoaW1pbm9yKGlub2RlKSwK
LQkJCQkgICAgU05EUlZfREVWSUNFX1RZUEVfUENNX0NBUFRVUkUpOworCXBjbSA9IHNuZF9s
b29rdXBfbWlub3JfZGF0YTIoaW1pbm9yKGlub2RlKSwKKwkJCQkgICAgU05EUlZfREVWSUNF
X1RZUEVfUENNX0NBUFRVUkUsIGZpbGUpOwogCXJldHVybiBzbmRfcGNtX29wZW4oZmlsZSwg
cGNtLCBTTkRSVl9QQ01fU1RSRUFNX0NBUFRVUkUpOwogfQogCisjaW5jbHVkZSA8bGludXgv
ZGVsYXkuaD4KIHN0YXRpYyBpbnQgc25kX3BjbV9vcGVuKHN0cnVjdCBmaWxlICpmaWxlLCBz
dHJ1Y3Qgc25kX3BjbSAqcGNtLCBpbnQgc3RyZWFtKQogewogCWludCBlcnI7CiAJd2FpdF9x
dWV1ZV90IHdhaXQ7CiAKKwlwcmludGsoIm1zbGVlcCBvMiAlcFxuIiwgcGNtKTsKKwltZGVs
YXkoNTAwMCk7CisJcHJpbnRrKCJtc2xlZXAgbzIrXG4iKTsKIAlpZiAocGNtID09IE5VTEwp
IHsKIAkJZXJyID0gLUVOT0RFVjsKIAkJZ290byBfX2Vycm9yMTsKIAl9Ci0JZXJyID0gc25k
X2NhcmRfZmlsZV9hZGQocGNtLT5jYXJkLCBmaWxlKTsKLQlpZiAoZXJyIDwgMCkKLQkJZ290
byBfX2Vycm9yMTsKIAlpZiAoIXRyeV9tb2R1bGVfZ2V0KHBjbS0+Y2FyZC0+bW9kdWxlKSkg
ewogCQllcnIgPSAtRUZBVUxUOwogCQlnb3RvIF9fZXJyb3IyOwpkaWZmIC0tZ2l0IGEvc291
bmQvY29yZS9zb3VuZC5jIGIvc291bmQvY29yZS9zb3VuZC5jCmluZGV4IDY0Mzk3NjAuLjVl
YTgwMTAgMTAwNjQ0Ci0tLSBhL3NvdW5kL2NvcmUvc291bmQuYworKysgYi9zb3VuZC9jb3Jl
L3NvdW5kLmMKQEAgLTExOCw2ICsxMTgsMzUgQEAgdm9pZCAqc25kX2xvb2t1cF9taW5vcl9k
YXRhKHVuc2lnbmVkIGludCBtaW5vciwgaW50IHR5cGUpCiAKIEVYUE9SVF9TWU1CT0woc25k
X2xvb2t1cF9taW5vcl9kYXRhKTsKIAorI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+Cit2b2lk
ICpzbmRfbG9va3VwX21pbm9yX2RhdGEyKHVuc2lnbmVkIGludCBtaW5vciwgaW50IHR5cGUs
IHN0cnVjdCBmaWxlICpmaWxlKQoreworCXN0cnVjdCBzbmRfbWlub3IgKm1yZWc7CisJdm9p
ZCAqcHJpdmF0ZV9kYXRhOworCisJaWYgKG1pbm9yID49IEFSUkFZX1NJWkUoc25kX21pbm9y
cykpCisJCXJldHVybiBOVUxMOworCW11dGV4X2xvY2soJnNvdW5kX211dGV4KTsKKwltcmVn
ID0gc25kX21pbm9yc1ttaW5vcl07CisJaWYgKG1yZWcgJiYgbXJlZy0+dHlwZSA9PSB0eXBl
KQorCQlwcml2YXRlX2RhdGEgPSBtcmVnLT5wcml2YXRlX2RhdGE7CisJZWxzZQorCQlwcml2
YXRlX2RhdGEgPSBOVUxMOworCXByaW50aygibXNsZWVwIG8gJXBcbiIsIE5VTEwpOworCW1k
ZWxheSg1MDAwKTsKKwlwcmludGsoIm1zbGVlcCBvK1xuIik7CisKKworCWlmIChwcml2YXRl
X2RhdGEpIHsKKwkJaWYgKHNuZF9jYXJkX2ZpbGVfYWRkKG1yZWctPmNhcmRwLCBmaWxlKSA8
IDApCisJCQlwcml2YXRlX2RhdGEgPSBOVUxMOworCX0KKwltdXRleF91bmxvY2soJnNvdW5k
X211dGV4KTsKKwlyZXR1cm4gcHJpdmF0ZV9kYXRhOworfQorCitFWFBPUlRfU1lNQk9MKHNu
ZF9sb29rdXBfbWlub3JfZGF0YTIpOworCiAjaWZkZWYgQ09ORklHX01PRFVMRVMKIHN0YXRp
YyBzdHJ1Y3Qgc25kX21pbm9yICphdXRvbG9hZF9kZXZpY2UodW5zaWduZWQgaW50IG1pbm9y
KQogewpAQCAtMjcyLDYgKzMwMSw3IEBAIGludCBzbmRfcmVnaXN0ZXJfZGV2aWNlX2Zvcl9k
ZXYoaW50IHR5cGUsIHN0cnVjdCBzbmRfY2FyZCAqY2FyZCwgaW50IGRldiwKIAkJcmV0dXJu
IC1FTk9NRU07CiAJcHJlZy0+dHlwZSA9IHR5cGU7CiAJcHJlZy0+Y2FyZCA9IGNhcmQgPyBj
YXJkLT5udW1iZXIgOiAtMTsKKwlwcmVnLT5jYXJkcCA9IGNhcmQ7CiAJcHJlZy0+ZGV2aWNl
ID0gZGV2OwogCXByZWctPmZfb3BzID0gZl9vcHM7CiAJcHJlZy0+cHJpdmF0ZV9kYXRhID0g
cHJpdmF0ZV9kYXRhOwo=
--------------040907030109060606030001--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
