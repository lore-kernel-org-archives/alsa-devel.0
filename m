From: =?utf-8?Q?Sh=C3=A9rab?= <Sebastien.Hinderer@ens-lyon.org>
Subject: snd_pcm_hw_params_get_tick_time
Date: Sat, 11 Oct 2014 19:48:57 +0200
Message-ID: <20141011174857.GA7694@pema>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A1E4260579
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 19:48:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 0764D200D1
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 19:48:58 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Keb-Nw5bFLHB for <alsa-devel@alsa-project.org>;
 Sat, 11 Oct 2014 19:48:57 +0200 (CEST)
Received: from pema.homeunix.org
 (AMontsouris-551-1-36-51.w90-24.abo.wanadoo.fr [90.24.219.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id DA324200D0
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 19:48:57 +0200 (CEST)
Received: from seb by pema.homeunix.org with local (Exim 4.84)
 (envelope-from <Sebastien.Hinderer@ens-lyon.org>) id 1Xd0mn-00020R-9I
 for alsa-devel@alsa-project.org; Sat, 11 Oct 2014 19:48:57 +0200
Content-Disposition: inline
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

SGVsbG8sCgpJJ20gbWFpbnRhaW5nIGEgVFRTIGVuZ2luZSBmb3IgZnJlbmNoIHRoYXQgdXNlCnNu
ZF9wY21faHdfcGFyYW1zX2dldF90aWNrX3RpbWUuIENvbXBpbGluZyB0aGUgY29kZSBwcm9kdWNl
cyBhCmRlcHJlY2F0aW9uIHdhcm5pbmcgZm9yIHRoaXMgZnVuY3Rpb24uIEkgdHJpZWQgdG8gZmln
dXJlIG91dCBob3cgdGhlCmNvZGUgc2hvdWxkIGJlIG1vZGlmaWVkIHRvIG5vdCB1c2UgdGhpcyBm
dW5jdGlvbiBidXQgY2FuJ3QgZmluZCBhIHdheS4KQW55IGhlbHAgd291bGQgYmUgd2FybWx5IGFw
cHJlY2lhdGVkLgoKVGhhbmtzLApTaMOpcmFiLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
