From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: M-Audio FastTrack C400
Date: Fri, 4 May 2012 10:26:26 +0200
Message-ID: <CAFz=ag5iwFf7DtfE8sucZWSNq14DZM7enwER5m_M=9=9Do9J7w@mail.gmail.com>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F911629.5090704@gmail.com>
	<4F920D73.7070309@rauros.net>
	<CAFz=ag4viHQ-K7qbpCk-G+H3Q8GKe=7-anfOeCy3jhUCYUJ5BQ@mail.gmail.com>
	<CACckToUVQu=p0ZSaGw-oRn2ASgfQ_Po2im1ha5-yUVeyt7JUaQ@mail.gmail.com>
	<4F9CB0D7.5060401@rauros.net>
	<CAFz=ag6tVjD6hANk2e6sH8hcrbJi6SdqYJNy2U-nkArBV5DVfQ@mail.gmail.com>
	<4F9D4291.6060803@rauros.net>
	<CAFz=ag5HWp-BW4ZyymR7F60ahtzttyoBk6ZwdSRVKBXepHyn1w@mail.gmail.com>
	<4FA19CAC.7070704@rauros.net>
	<CAFz=ag624FsOhyRSKY=cO5+fZtLhCKMsox4_HhFooor_B5OQ8g@mail.gmail.com>
	<4FA36114.2030305@rauros.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf302d4c5c357bff04bf31ad99
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id D84392460B
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2012 10:26:27 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so2740406yhn.38
	for <alsa-devel@alsa-project.org>; Fri, 04 May 2012 01:26:27 -0700 (PDT)
In-Reply-To: <4FA36114.2030305@rauros.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chris-alsa@rauros.net
Cc: Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--20cf302d4c5c357bff04bf31ad99
Content-Type: text/plain; charset=ISO-8859-1

Hi,

2012/5/4 Chris Cavey <chris-alsa@rauros.net>:
> Attached are logs from win7 vm unplug/replug and my ubuntu 12.04 dev vm with
> alsa mods.

Great!


>
> I've also included a patch of my current set of modifications
>

Thanks.

Could you please try if the attached patch changes anything?

Regards,
Felix

--20cf302d4c5c357bff04bf31ad99
Content-Type: application/octet-stream; name="c400_force_uac1.diff"
Content-Disposition: attachment; filename="c400_force_uac1.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h1szbal03

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9taXhlci5jIGIvc291bmQvdXNiL21peGVyLmMKaW5kZXgg
M2Q3MDI0NS4uNzBkZjJmOSAxMDA2NDQKLS0tIGEvc291bmQvdXNiL21peGVyLmMKKysrIGIvc291
bmQvdXNiL21peGVyLmMKQEAgLTM2OSw3ICszNjksOCBAQCBlcnJvcjoKIAogc3RhdGljIGludCBn
ZXRfY3RsX3ZhbHVlKHN0cnVjdCB1c2JfbWl4ZXJfZWxlbV9pbmZvICpjdmFsLCBpbnQgcmVxdWVz
dCwgaW50IHZhbGlkeCwgaW50ICp2YWx1ZV9yZXQpCiB7Ci0JcmV0dXJuIChjdmFsLT5taXhlci0+
cHJvdG9jb2wgPT0gVUFDX1ZFUlNJT05fMSkgPworCXJldHVybiAoY3ZhbC0+bWl4ZXItPnByb3Rv
Y29sID09IFVBQ19WRVJTSU9OXzEgfHwgCisJCWN2YWwtPm1peGVyLT5jaGlwLT51c2JfaWQgPT0g
VVNCX0lEKDB4MDc2MywgMHgyMDMwKSkgPwogCQlnZXRfY3RsX3ZhbHVlX3YxKGN2YWwsIHJlcXVl
c3QsIHZhbGlkeCwgdmFsdWVfcmV0KSA6CiAJCWdldF9jdGxfdmFsdWVfdjIoY3ZhbCwgcmVxdWVz
dCwgdmFsaWR4LCB2YWx1ZV9yZXQpOwogfQpAQCAtNDE5LDcgKzQyMCw4IEBAIGludCBzbmRfdXNi
X21peGVyX3NldF9jdGxfdmFsdWUoc3RydWN0IHVzYl9taXhlcl9lbGVtX2luZm8gKmN2YWwsCiAJ
dW5zaWduZWQgY2hhciBidWZbMl07CiAJaW50IHZhbF9sZW4sIGVyciwgdGltZW91dCA9IDEwOwog
Ci0JaWYgKGN2YWwtPm1peGVyLT5wcm90b2NvbCA9PSBVQUNfVkVSU0lPTl8xKSB7CisJaWYgKGN2
YWwtPm1peGVyLT5wcm90b2NvbCA9PSBVQUNfVkVSU0lPTl8xIHx8IAorCQljdmFsLT5taXhlci0+
Y2hpcC0+dXNiX2lkID09IFVTQl9JRCgweDA3NjMsIDB4MjAzMCkpIHsKIAkJdmFsX2xlbiA9IGN2
YWwtPnZhbF90eXBlID49IFVTQl9NSVhFUl9TMTYgPyAyIDogMTsKIAl9IGVsc2UgeyAvKiBVQUNf
VkVSU0lPTl8yICovCiAJCS8qIGF1ZGlvIGNsYXNzIHYyIGNvbnRyb2xzIGFyZSBhbHdheXMgMiBi
eXRlcyBpbiBzaXplICovCg==
--20cf302d4c5c357bff04bf31ad99
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf302d4c5c357bff04bf31ad99--
