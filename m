From: Martin Josefsson <gandalf@wlug.westbo.se>
Subject: [PATCH] make snd-pcm-oss obey snd_nonblock_open=1
Date: Mon, 18 Mar 2002 23:40:10 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0203182335410.20781-200000@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="801277839-2128212956-1016491210=:20781"
Received: from tux.rsn.bth.se (tux.rsn.bth.se [194.47.143.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA22330
	for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2002 23:40:28 +0100
Received: from localhost (gandalf@localhost [127.0.0.1])
	by tux.rsn.bth.se (8.12.1/8.12.1/Debian -5) with ESMTP id g2IMeAM7020802
	for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2002 23:40:14 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--801277839-2128212956-1016491210=:20781
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

I recently switched from OSS/Free to ALSA and everything but one thing was
working perfectly. I have an old sb16 card and I'm used to the fact that
if /dev/dsp is already used all new attempts to open it should fail
instead of just block until it's availiable. Then I found the 
snd_nonblock_open moduleparameter to snd-pcm-oss but it didn't work when
set to 1 (actually tried with 0 too). Here's a small patch to fix that
problem by making snd-pcm-oss always obey snd_nonblock_open unless the
nonblock parameter is already set to 1. It's just a simple cut-n-paste in
pcm_oss.c

Patch is attached, it works fine here.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

--801277839-2128212956-1016491210=:20781
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="alsa-nonblocking-snd-pcm-oss.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0203182340100.20781@tux.rsn.bth.se>
Content-Description: 
Content-Disposition: attachment; filename="alsa-nonblocking-snd-pcm-oss.patch"

LS0tIGFsc2Eta2VybmVsL2NvcmUvb3NzL3BjbV9vc3MuYy5vcmlnCU1vbiBN
YXIgMTggMjM6MzA6MTUgMjAwMg0KKysrIGFsc2Eta2VybmVsL2NvcmUvb3Nz
L3BjbV9vc3MuYwlNb24gTWFyIDE4IDIzOjMwOjMyIDIwMDINCkBAIC0xNTY3
LDE2ICsxNTY3LDE0IEBADQogCQkJbm9uYmxvY2sgPSAxOw0KIAkJZWxzZSBp
ZiAocHNldHVwLT5ibG9jaykNCiAJCQlub25ibG9jayA9IDA7DQotCQllbHNl
IGlmICghbm9uYmxvY2spDQotCQkJbm9uYmxvY2sgPSBzbmRfbm9uYmxvY2tf
b3BlbjsNCiAJfSBlbHNlIGlmIChjc2V0dXAgJiYgIWNzZXR1cC0+ZGlzYWJs
ZSkgew0KIAkJaWYgKGNzZXR1cC0+bm9uYmxvY2spDQogCQkJbm9uYmxvY2sg
PSAxOw0KIAkJZWxzZSBpZiAoY3NldHVwLT5ibG9jaykNCiAJCQlub25ibG9j
ayA9IDA7DQotCQllbHNlIGlmICghbm9uYmxvY2spDQotCQkJbm9uYmxvY2sg
PSBzbmRfbm9uYmxvY2tfb3BlbjsNCiAJfQ0KKwlpZiAoIW5vbmJsb2NrKQ0K
KwkJbm9uYmxvY2sgPSBzbmRfbm9uYmxvY2tfb3BlbjsNCiANCiAJaW5pdF93
YWl0cXVldWVfZW50cnkoJndhaXQsIGN1cnJlbnQpOw0KIAlhZGRfd2FpdF9x
dWV1ZSgmcGNtLT5vcGVuX3dhaXQsICZ3YWl0KTsNCg==
--801277839-2128212956-1016491210=:20781--

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
