From: nick83ola <nick83ola@gmail.com>
Subject: Re: Imx6 i2s master driver without i2c
Date: Wed, 11 May 2016 08:25:39 +0200
Message-ID: <CABPh3UNPDS+4H60eeL79etF70O0-Xp2T_oNBkYL2m4g6jpeSWA@mail.gmail.com>
References: <CABPh3UNhKMGUoiDvHn9paXVNvtpwzbzkbCwBhtSCm72jxkh3CA@mail.gmail.com>
 <CABPh3UMMvVKvHL0g52NqP-E8dpxoZHfwgR_t1WY08OFMSYt9tg@mail.gmail.com>
 <CABPh3UMJ4gOtNN3FJg0fF7Mm+Lpw0=jXGk_+ejsHaGLG9UvWAQ@mail.gmail.com>
 <CABPh3UNi79pMZPgJBisaq9Qo847MV-6riCEQ=Akt_RoLdqeVpw@mail.gmail.com>
 <CABPh3UPLR20WbV0NuYLA4RZ7XB-0+RdFrB-SpDLa0T+wOxqQ+g@mail.gmail.com>
 <CAG5mAdzJyTdsBTnz8FZ8Ay278j1bYJHHqkOTGY+_Ck9sSPhQoQ@mail.gmail.com>
 <CABPh3UN1ZoGAVF1y_5vi_DbkARfopbe5tc5SSy0HQbiYe8MERA@mail.gmail.com>
 <CAG5mAdw1erm=4RjMfP-hf1Vkw73KCWSaLbU3DtditMfsFQNRdQ@mail.gmail.com>
 <CABPh3UN2157eMxwr6i8-vPfdyr3L0DOrpVt7ChTUrPTCbCzCBA@mail.gmail.com>
 <CABPh3UNk9xa=K7QiVV3pZba7o287AyOrjufUGd1QWUxnHNHLOg@mail.gmail.com>
 <CAG5mAdyCAgtFBCbAyLVtqtLgOtCgkB9=yV+YEY8a3oeL2yJDHA@mail.gmail.com>
 <CABPh3UPzP1iFYsy_Ni1fcfimnoVDUWfdn8ht5On_mx0xN1w8Mg@mail.gmail.com>
 <CAG5mAdyceKw_H7zNfx-KTSUUMc81UiLu3feLBcB+vjjjpuhetQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 10C3526519F
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 08:25:59 +0200 (CEST)
Received: by mail-lf0-f67.google.com with SMTP id m101so3918066lfi.1
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 23:25:59 -0700 (PDT)
In-Reply-To: <CAG5mAdyceKw_H7zNfx-KTSUUMc81UiLu3feLBcB+vjjjpuhetQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

V2hhdCBJIGRvbid0IHVuZGVyc3RhbmQgaXMgdGhlIHNlcXVlbmNlIG9mIGluaXQuCuKAi29mIHRo
ZSBkcml2ZXIuCkkgdGhpbmsgdGhhdCBJIG5lZWQgdG8gOgppbml0IGRtYSB0byB0cmFuc2ZlciBm
cm9tIHNzaTEgKHdoYXQgZmlsZT8/PykKaW5pdCBzc2kxIHdpdGggYSBjbG9jayBhbmQgYSBtb2Rl
IChpMnMgbWFzdGVyKSAoaSB0aGluayBmc2xfc3NpIG9yIGlteC1zc2kKZmlsZT8/ICkKaW5pdCBh
dWRtdXggdG8gcHV0IHNzaTEgKHBvcnQgMSkgdG8gcG9ydCA0IChpcyBhIGNsb2NrIG5lZWRlZD8p
IChpbXgtYXVkbXV4Cm1vZHVsZT8/KQppbml0IGlvbXV4IHRvIHB1dCBwb3J0NCBvdXRwdXQgb24g
b3V0cHV0IHBpbiAoSSBuZWVkIHRvIHNldCBwaW4gZGlyZWN0aW9uCmFsc28gb3IgaXMgYXV0b21h
dGljPz8/KSAob25seSBpbiBkdHM/IHdoYXQgZnVuY3Rpb24gc2V0IHRoYXQ/KQoKYW5kIHdoZXJl
IHRob3NlIGluaXQgYXJlPyBhbmQgd2hhdCBmaWxlL2Z1bmN0aW9uIGRvZXMgdGhlIGFjdHVhbCBt
ZW1vcnkKdHJhbnNmZXI/CmFuZCAuLi4gbGFzdCBob3cgSSBjYW4gY2hlY2sgc2VwYXJhdGVseSBh
bGwgdGhvc2UgdGhpbmdzPz8KSSBjYW4gaW5pdCBzc2kgZm9yIGV4YW1wbGUgd2l0aG91dCBhdWRp
byBhcyBhICJzZXJpYWwgcG9ydCIgYW5kIHRlc3QgaXQ/Pz8Kb3IgSSBjYW4gSW5pdCB0aGUgb3V0
cHV0IHBvcnQgYXMgZ3BpbyBhbmQgc2V0IHBpbnMgdG8gdGVzdCBpZiBpdHMKaW5pdGlhbGl6YXRl
ZD8/CgpIb3cgSSBjYW4gcmVhZCB0aGUgY3B1IHJlZ2lzdGVyIGJhY2sgZnJvbSBsaW51eCB0byBj
aGVjayB0aGF0IGFyZSBjb3JyZWN0bHkKaW5pdGlhbGl6YXRlZCAoZm9yIGV4YW1wbGUgSSBjYW4g
cmVhZCBpb211eCByZWdpc3RlcnM/Pz8/KQpUaGUgZG9jdW1lbnRhdGlvbi90dXRvcmlhbCBvbiBh
bHNhIGRyaXZlciBhcmUgdmVyeSBzY2Fyc2UsIGFuZCBmcmVlc2NhbGUKY29tbXVuaXR5IGlzIG5v
dCBvZiBoZWxwCgpUaGFua3MgZm9yIHlvdXIgaGVscAoKTmljb2xhCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
