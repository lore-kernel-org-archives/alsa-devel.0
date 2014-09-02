From: Jean-Francois Moine <moinejf@free.fr>
Subject: ASoC:simple-card: problem with multi-DAIs
Date: Tue, 2 Sep 2014 09:00:05 +0200
Message-ID: <20140902090005.4a2c80b2@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 42F55265841
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 08:58:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

SGkgS3VuaW5vcmksCgpJbiB5b3VyIHBhdGNoCglBU29DOiBzaW1wbGUtY2FyZDogcmVtb3ZlIGRh
aV9saW5rLT5jcHVfZGFpX25hbWUgd2hlbiBEVAoJKGNvbW1pdCAxNzk5NDliYzA0YzcxNTdhNGIy
Mjc5ZjYyYTg0MjYzOGI2MWY3OGY5CgkgaW4gL2tlcm5lbC9naXQvYnJvb25pZS9zb3VuZC5naXQv
KQp5b3UgcmVtb3ZlZCBhbGwgJ2NwdV9kYWlfbmFtZSdzLCBhbmQgdGhpcyBjcmVhdGVzIHByb2Js
ZW1zIGluIG15IHN5c3RlbS4KCkkgaGF2ZSBhbiBhdWRpbyBjb250cm9sbGVyIHdpdGggMiBEQUlz
LiBUaGUgYXVkaW8gc3lzdGVtIGlzIGRlZmluZWQgYXM6CgoJc291bmQgewoJCWNvbXBhdGlibGUg
PSAic2ltcGxlLWF1ZGlvLWNhcmQiOwoJCXNpbXBsZS1hdWRpby1jYXJkLG5hbWUgPSAiQ3Vib3gg
QXVkaW8iOwoKCQlzaW1wbGUtYXVkaW8tY2FyZCxkYWktbGlua0AwIHsJCS8qIEkyUyAtIEhETUkg
Ki8KCQkJZm9ybWF0ID0gImkycyI7CgkJCWNwdSB7CgkJCQlzb3VuZC1kYWkgPSA8JmF1ZGlvMSAw
PjsKCQkJfTsKCQkJY29kZWMgewoJCQkJc291bmQtZGFpID0gPCZoZG1pIDA+OwoJCQl9OwoJCX07
CgoJCXNpbXBsZS1hdWRpby1jYXJkLGRhaS1saW5rQDEgewkJLyogUy9QRElGIC0gSERNSSAqLwoJ
CQljcHUgewoJCQkJc291bmQtZGFpID0gPCZhdWRpbzEgMT47CgkJCX07CgkJCWNvZGVjQDAgewoJ
CQkJc291bmQtZGFpID0gPCZoZG1pIDE+OwoJCQl9OwoJCX07CgkJLi4uCgl9CgpUaGUgJ2NwdV9v
Zl9ub2RlJyBvZiBib3RoIENQVSBEQUlzIGlzIHRoZSBzYW1lICgnYXVkaW8xJyksIGFuZCBvbmx5
IHRoZQpjcHVfZGFpX25hbWUgcGVybWl0cyB0byBrbm93IHRoZSBDUFUgREFJLgoKQnV0LCBhcyB5
b3UgcmVtb3ZlZCBpdCwgYm90aCBEQUkgbGlua3MgYXJlIGJ1aWx0IHdpdGggdGhlIDFzdCBDUFUg
REFJCihJMlMpLCBhbmQgdGhlIHNlY29uZCBsaW5rICh2aWEgUy9QRElGKSBkb2VzIG5vdCB3b3Jr
LgoKLS0gCktlbiBhciBjJ2hlbnRhw7EJfAkgICAgICAqKiBCcmVpemggaGEgTGludXggYXRhdiEg
KioKSmVmCQl8CQlodHRwOi8vbW9pbmVqZi5mcmVlLmZyLwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
