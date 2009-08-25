From: Denis Kup <dener.kup@gmail.com>
Subject: Re: Acer Aspire 7730G support
Date: Tue, 25 Aug 2009 20:11:32 +0400
Message-ID: <376f0d430908250911j232d46abo8c641e7b6b85cffa@mail.gmail.com>
References: <376f0d430906240509w7b8e23d4m92e3fc99fabd528@mail.gmail.com>
	<376f0d430906241052i1e37904bo9c90b98e0dca6077@mail.gmail.com>
	<d54969c50906241339u7a4a41cbvbc66643e794436b9@mail.gmail.com>
	<376f0d430906241436k20912428o3cd8ea5d83b300ce@mail.gmail.com>
	<376f0d430908240610h55c7afb8kb77a4cf2289d53b8@mail.gmail.com>
	<s5h3a7hpcer.wl%tiwai@suse.de>
	<376f0d430908240857k7c03a392x187fdbb9488757d3@mail.gmail.com>
	<s5hzl9o5tyf.wl%tiwai@suse.de>
	<376f0d430908250501rda3b9baud60b3358fea1f6f0@mail.gmail.com>
	<s5hhbvw3wwi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175cf772801e320471f9963d
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id B25A72455F
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 18:11:34 +0200 (CEST)
Received: by fxm3 with SMTP id 3so2295548fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2009 09:11:33 -0700 (PDT)
In-Reply-To: <s5hhbvw3wwi.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
List-Id: alsa-devel@alsa-project.org

--0015175cf772801e320471f9963d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Patch for ALSA driver.
Adds full audio support on Acer Aspire 7730G notebook.

Change log:

1) Added support of internal subwoofer (it sounds!!!)
2) Auto muting front speakers and internal subwoofer on headphones plug.
3) Internal mic works.
4) 3 channel mods (jack maps):
       black  pink         blue
2ch: front   ext mic     line in
4ch: front   ext mic     surround
6ch: front   CLFE        surround
  Can be changed in mixer.
5) Sound can be recorded from:
 Internal mic
 Ext mic
 Cd
 Line in
6) 2 separate capture channels.

Denis Kuplyakov <dener.kup@gmail.com>
25.08.09 16:06:36

--0015175cf772801e320471f9963d
Content-Type: text/plain; charset=US-ASCII; name="patch_acer_7730G_alsa_support.txt"
Content-Disposition: attachment;
	filename="patch_acer_7730G_alsa_support.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fyssibgm0

LS0tIC4vYWxzYS1kcml2ZXIvYWxzYS1rZXJuZWwvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMJMjAw
OS0wOC0yNSAxMDo1MzoxMy4wMDAwMDAwMDAgKzA0MDAKKysrIC4vYWxzYS1kcml2ZXItcGF0Y2hl
ZC9hbHNhLWtlcm5lbC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwkyMDA5LTA4LTI1IDE4OjMwOjQ4
LjAwMDAwMDAwMCArMDQwMApAQCAtMjIwLDYgKzIyMCw3IEBAIGVudW0gewogCUFMQzg4OF9BQ0VS
X0FTUElSRV80OTMwRywKIAlBTEM4ODhfQUNFUl9BU1BJUkVfNjUzMEcsCiAJQUxDODg4X0FDRVJf
QVNQSVJFXzg5MzBHLAorCUFMQzg4OF9BQ0VSX0FTUElSRV83NzMwRywKIAlBTEM4ODNfTUVESU9O
LAogCUFMQzg4M19NRURJT05fTUQyLAogCUFMQzg4M19MQVBUT1BfRUFQRCwKQEAgLTg0NzIsNiAr
ODQ3MywxMyBAQCBzdGF0aWMgc3RydWN0IGhkYV92ZXJiIGFsYzg4M19hY2VyX2VhcGRfCiAJeyB9
CiB9OwogCitzdGF0aWMgc3RydWN0IGhkYV92ZXJiIGFsYzg4OF9hY2VyX2FzcGlyZV83NzMwR192
ZXJic1tdID0geworCXsweDE1LCBBQ19WRVJCX1NFVF9DT05ORUNUX1NFTCwgMHgwMH0sCisJezB4
MTcsIEFDX1ZFUkJfU0VUX0NPTk5FQ1RfU0VMLCAweDAyfSwKKwl7MHgxNSwgQUNfVkVSQl9TRVRf
VU5TT0xJQ0lURURfRU5BQkxFLCBBTEM4ODBfSFBfRVZFTlQgfCBBQ19VU1JTUF9FTn0sCisJeyB9
IC8qIGVuZCAqLworfTsKKwogc3RhdGljIHZvaWQgYWxjODg4XzZzdF9kZWxsX3NldHVwKHN0cnVj
dCBoZGFfY29kZWMgKmNvZGVjKQogewogCXN0cnVjdCBhbGNfc3BlYyAqc3BlYyA9IGNvZGVjLT5z
cGVjOwpAQCAtODYzMyw2ICs4NjQxLDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmFsYzg4Ml9tb2Rl
bHNbQUxDODgyXwogCVtBTEM4ODhfQUNFUl9BU1BJUkVfNDkzMEddCT0gImFjZXItYXNwaXJlLTQ5
MzBnIiwKIAlbQUxDODg4X0FDRVJfQVNQSVJFXzY1MzBHXQk9ICJhY2VyLWFzcGlyZS02NTMwZyIs
CiAJW0FMQzg4OF9BQ0VSX0FTUElSRV84OTMwR10JPSAiYWNlci1hc3BpcmUtODkzMGciLAorCVtB
TEM4ODhfQUNFUl9BU1BJUkVfNzczMEddCT0gImFjZXItYXNwaXJlLTc3MzBnIiwKIAlbQUxDODgz
X01FRElPTl0JCT0gIm1lZGlvbiIsCiAJW0FMQzg4M19NRURJT05fTUQyXQk9ICJtZWRpb24tbWQy
IiwKIAlbQUxDODgzX0xBUFRPUF9FQVBEXQk9ICJsYXB0b3AtZWFwZCIsCkBAIC04Njc5LDYgKzg2
ODgsOCBAQCBzdGF0aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjODgyX2NmZ190CiAJCUFMQzg4
OF9BQ0VSX0FTUElSRV82NTMwRyksCiAJU05EX1BDSV9RVUlSSygweDEwMjUsIDB4MDE2NiwgIkFj
ZXIgQXNwaXJlIDY1MzBHIiwKIAkJQUxDODg4X0FDRVJfQVNQSVJFXzY1MzBHKSwKKwlTTkRfUENJ
X1FVSVJLKDB4MTAyNSwgMHgwMTQyLCAiQWNlciBBc3BpcmUgNzczMEciLAorCQlBTEM4ODhfQUNF
Ul9BU1BJUkVfNzczMEcpLAogCS8qIGRlZmF1bHQgQWNlciAtLSBkaXNhYmxlZCBhcyBpdCBjYXVz
ZXMgbW9yZSBwcm9ibGVtcy4KIAkgKiAgICBtb2RlbD1hdXRvIHNob3VsZCB3b3JrIGZpbmUgbm93
CiAJICovCkBAIC05MTgwLDYgKzkxOTEsMjYgQEAgc3RhdGljIHN0cnVjdCBhbGNfY29uZmlnX3By
ZXNldCBhbGM4ODJfcAogCQkuc2V0dXAgPSBhbGM4ODlfYWNlcl9hc3BpcmVfODkzMGdfc2V0dXAs
CiAJCS5pbml0X2hvb2sgPSBhbGNfYXV0b211dGVfYW1wLAogCX0sCisJW0FMQzg4OF9BQ0VSX0FT
UElSRV83NzMwR10gPSB7CisJCS5taXhlcnMgPSB7IGFsYzg4M18zU1RfNmNoX21peGVyLAorCQkJ
CWFsYzg4M19jaG1vZGVfbWl4ZXIgfSwKKwkJLmluaXRfdmVyYnMgPSB7IGFsYzg4M19pbml0X3Zl
cmJzLCBhbGM4ODBfZ3BpbzFfaW5pdF92ZXJicywKKwkJCQlhbGM4ODhfYWNlcl9hc3BpcmVfNzcz
MEdfdmVyYnMgfSwKKwkJLm51bV9kYWNzID0gQVJSQVlfU0laRShhbGM4ODNfZGFjX25pZHMpLAor
CQkuZGFjX25pZHMgPSBhbGM4ODNfZGFjX25pZHMsCisJCS5udW1fYWRjX25pZHMgPSBBUlJBWV9T
SVpFKGFsYzg4M19hZGNfbmlkc19yZXYpLAorCQkuYWRjX25pZHMgPSBhbGM4ODNfYWRjX25pZHNf
cmV2LAorCQkuY2Fwc3JjX25pZHMgPSBhbGM4ODNfY2Fwc3JjX25pZHNfcmV2LAorCQkuZGlnX291
dF9uaWQgPSBBTEM4ODNfRElHT1VUX05JRCwKKwkJLm51bV9jaGFubmVsX21vZGUgPSBBUlJBWV9T
SVpFKGFsYzg4M18zU1RfNmNoX21vZGVzKSwKKwkJLmNoYW5uZWxfbW9kZSA9IGFsYzg4M18zU1Rf
NmNoX21vZGVzLAorCQkubmVlZF9kYWNfZml4ID0gMSwKKwkJLmNvbnN0X2NoYW5uZWxfY291bnQg
PSA2LAorCQkuaW5wdXRfbXV4ID0gJmFsYzg4M19jYXB0dXJlX3NvdXJjZSwKKwkJLnVuc29sX2V2
ZW50ID0gYWxjX2F1dG9tdXRlX2FtcF91bnNvbF9ldmVudCwKKwkJLnNldHVwID0gYWxjODg4X2Fj
ZXJfYXNwaXJlXzY1MzBnX3NldHVwLAorCQkuaW5pdF9ob29rID0gYWxjX2F1dG9tdXRlX2FtcCwK
Kwl9LAogCVtBTEM4ODNfTUVESU9OXSA9IHsKIAkJLm1peGVycyA9IHsgYWxjODgzX2ZpdmVzdGFj
a19taXhlciwKIAkJCSAgICBhbGM4ODNfY2htb2RlX21peGVyIH0sCg==
--0015175cf772801e320471f9963d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0015175cf772801e320471f9963d--
