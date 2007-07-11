From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Errors in application building
Date: Wed, 11 Jul 2007 12:30:34 -0500
Message-ID: <61c0054e0707111030x64b905d7jf09768f5834362d9@mail.gmail.com>
References: <61c0054e0707031129t28cc1421sde4d3b4ac4b6428b@mail.gmail.com>
	<61c0054e0707031240y6d60fed3yea2317b8ad888110@mail.gmail.com>
	<75b66ecd0707031247h842da9j97bce3f85cda33b1@mail.gmail.com>
	<61c0054e0707031414r7565c10ax3edab20bd78d4d4c@mail.gmail.com>
	<61c0054e0707051142h46cd5beer29d91e8b6fd4560c@mail.gmail.com>
	<61c0054e0707101219i5e414590r598b45767e7b462d@mail.gmail.com>
	<20070710155712.18ee1c94.AlsaUser@PragmaSoft.com>
	<61c0054e0707101418h461afc13sdc9ec6e9d37a8d07@mail.gmail.com>
	<61c0054e0707110739l29a9f71cmf18354eccb5b9f70@mail.gmail.com>
	<61c0054e0707110749v199c9d89qf18732e3ce999e18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_9234_29662534.1184175034501"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FBD310387C
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 19:30:35 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so163360ugf
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 10:30:34 -0700 (PDT)
In-Reply-To: <61c0054e0707110749v199c9d89qf18732e3ce999e18@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_9234_29662534.1184175034501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello All:

Okay, I have progressed past the segfault issue. Definitely was the lack of
-lpthread in the compile. Now I have the code in place to do a simple
read/write operation to ensure I can make the application capture and play
audio. I copied some example code and am trying to get it to work. I can
scope my pcm interface and it appears to be working, but no audio as of yet.
I am not sure how ALSA is dealing with the audio buffer, so it may be a
fundamental problem with that. It may also be the way I am setting the
parameters. Both arecord and aplay work just fine, so I do not believe it is
a hardware or driver issue.

For clarity, I am using ALSA 1.0.14a with an ARM9 processor using the SoC
driver package and a custom machine/codec driver for an at91sam9260ek dev
board and winbond w6811 codec. It is a simple pcm, mono, 8k codec. My params
are:

Access Type: SND_PCM_ACCESS_RW_INTERLEAVED
Sample Format: SND_PCM_FORMAT_S8
Sample Rate: 8000
Channel Count: 1

My code is attached. Through gdb I get the following:

--snip--
~ $ gdb grh_audio


dlopen failed on 'libthread_db.so.1' - File not found
GDB will not be able to debug pthreads.

GNU gdb 6.4
Copyright 2005 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "arm-linux-uclibc"...
(gdb) break 131
Breakpoint 1 at 0x8f50: file grh_audio0.c, line 131.
(gdb) break 214
Breakpoint 2 at 0x9364: file grh_audio0.c, line 214.
(gdb) display buf
(gdb) start
Breakpoint 3 at 0x8a8c: file grh_audio0.c, line 33.
Starting program: /usr/sbin/grh_audio
main () at grh_audio0.c:33
33      grh_audio0.c: No such file or directory.
        in grh_audio0.c
1: buf = {0 <repeats 512 times>}
(gdb) continue
Continuing.
Press enter to begin recording


Breakpoint 1, grh_capture () at grh_audio0.c:131
131     in grh_audio0.c
1: buf = {-776, -772, -1796, -2056, -1800, -263, -1, -1, -1, -1, -1793, -4,
  -4, -772, -4, -769, -1, -1, -1, -1, -1, -769, -772, -772, -776, -770, -4,
  -770, -1, -1, -1, -1, -1, -1, -1794, -1801, -1801, -1544, -1, -1, -769,
  -257, -1, -1, -1, -4, -1800, -1800, -776, -1, -2, -4, -257, -2, -1, -1,
-1,
  -1, -769, -260, -257, -769, -4, -1, -1, -1, -1, -769, -1, -4, -769, -2,
  -1800, -2057, -1800, -4, -770, -772, -772, -2, -1, -1, -769, -775, -1799,
  -260, -2, -1, -1, -1, -1, -257, -769, -1796, -264, -1, -1, -264, -769,
  -769, -1, -1, -1, -1, -1, -772, -4, -1801, -3080, -1800, -772, -1, -258,
  -769, -4, -776, -769, -1, -1, -770, -772, -1, -1, -1, -769, -1, -1, -1,
-1,
  -1, -1, -260, -2, -1, -1, -258, -2, -260, -1537, -1800, -1544, -772, -769,

  -1, -769, -1540, -769, -2, -1, -1, -769, -260, -260, -1540, -260, -257,
-2,
  -769, -1, -1, -1, -770, -2056, -8, -257, -2, -7, -1, -1, -1, -1, -1, -2,
  -1, -1, -1793, -1796, -1801, -772, -8, -1, -1537, -1799, -775, -1, -1, -1,

  -4, -260, -769, -2, -1, -257, -769, -1, -1, -1, -769, -1793, -775...}
(gdb) continue
Continuing.
Audio Captured. Press enter to playback


Breakpoint 2, grh_playback () at grh_audio0.c:214
214     in grh_audio0.c
1: buf = {-776, -772, -1796, -2056, -1800, -263, -1, -1, -1, -1, -1793, -4,
  -4, -772, -4, -769, -1, -1, -1, -1, -1, -769, -772, -772, -776, -770, -4,
  -770, -1, -1, -1, -1, -1, -1, -1794, -1801, -1801, -1544, -1, -1, -769,
  -257, -1, -1, -1, -4, -1800, -1800, -776, -1, -2, -4, -257, -2, -1, -1,
-1,
  -1, -769, -260, -257, -769, -4, -1, -1, -1, -1, -769, -1, -4, -769, -2,
  -1800, -2057, -1800, -4, -770, -772, -772, -2, -1, -1, -769, -775, -1799,
  -260, -2, -1, -1, -1, -1, -257, -769, -1796, -264, -1, -1, -264, -769,
  -769, -1, -1, -1, -1, -1, -772, -4, -1801, -3080, -1800, -772, -1, -258,
  -769, -4, -776, -769, -1, -1, -770, -772, -1, -1, -1, -769, -1, -1, -1,
-1,
  -1, -1, -260, -2, -1, -1, -258, -2, -260, -1537, -1800, -1544, -772, -769,

  -1, -769, -1540, -769, -2, -1, -1, -769, -260, -260, -1540, -260, -257,
-2,
  -769, -1, -1, -1, -770, -2056, -8, -257, -2, -7, -1, -1, -1, -1, -1, -2,
  -1, -1, -1793, -1796, -1801, -772, -8, -1, -1537, -1799, -775, -1, -1, -1,

  -4, -260, -769, -2, -1, -257, -769, -1, -1, -1, -769, -1793, -775...}
(gdb) quit
The program is running.  Exit anyway? (y or n) y
~ $
--snip--






-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************

------=_Part_9234_29662534.1184175034501
Content-Type: text/x-csrc; name=grh_audio0.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4037olc
Content-Disposition: attachment; filename="grh_audio0.c"

LyogR1JIIEF1ZGlvIFByb2dyYW0KICoKICogQXV0aG9yOiBQYXVsIEthdmFuLCBQcm9qZWN0IEVu
Z2luZWVyCiAqIERhdGU6IEp1bHkgMywgMjAwNwogKi8KCiNpbmNsdWRlIDxzdGRpby5oPgojaW5j
bHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxhbHNhL2Fzb3VuZGxpYi5oPgoKLyoqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioKICogVmFyaWFibGUgYW5kIEZ1bmN0aW9uIERlY2xh
cmF0aW9ucyAKICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCmludCAgICAg
ICAgICAgICBhdWRpb190eXBlOyAgICAgICAgICAgICAgICAgICAgIC8vMCA9IHNsZWVwOyAxID0g
Y2FwdHVyZTsgMiA9IHBsYXliYWNrCmludCAgICAgICAgICAgICBuY2hhbm5lbHMgPSAxOwppbnQg
ICAgICAgICAgICAgYnVmZmVyX3NpemUgPSA1MTI7CnVuc2lnbmVkIGludCAgICBzYW1wbGVfcmF0
ZSA9IDgwMDA7CmludCAgICAgICAgICAgICBiaXRzID0gODsKY2hhciAgICAgICAgICAgKnNuZF9k
ZXZpY2VfaW4gID0gImh3OjAsMCI7CmNoYXIgICAgICAgICAgICpzbmRfZGV2aWNlX291dCA9ICJo
dzowLDAiOwpzaG9ydCAgICAgICAgICAgYnVmWzUxMl07CmludCBncmhfY2FwdHVyZSh2b2lkKTsK
aW50IGdyaF9wbGF5YmFjayh2b2lkKTsKCgovKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKgogKiBNYWluIFByb2dyYW0gU2VjdGlvbgogKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKi8KaW50IG1haW4odm9pZCkKewogIGludCBlcnI7CiAgLy9UZXN0aW5nIHJv
dXRpbmUKICBwcmludGYoIlByZXNzIGVudGVyIHRvIGJlZ2luIHJlY29yZGluZ1xuIik7CiAgZ2V0
Y2hhcigpOwogIGVyciA9IGdyaF9jYXB0dXJlKCk7CiAgcHJpbnRmKCJBdWRpbyBDYXB0dXJlZC4g
UHJlc3MgZW50ZXIgdG8gcGxheWJhY2tcbiIpOwogIHdoaWxlKDEpewogIGdldGNoYXIoKTsKICBl
cnIgPSBncmhfcGxheWJhY2soKTsKICBwcmludGYoIkF1ZGlvIHBsYXliYWNrIGNvbXBsZXRlLiBB
Z2Fpbj9cbiIpO30KICByZXR1cm4gMDsKfQoKCgovKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKgogKiBDYXB0dXJlIEZ1bmN0aW9uOgogKiBUaGlzIGZ1Y3Rp
b24gc2hvdWxkIGNhcHR1cmUgYXVkaW8gZnJvbSB0aGUgUENNIAogKiBhbmQgc3RvcmUgaXQgaW4g
YSBidWZmZXIgZm9yIHRyYW5zbWlzc2lvbgogKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKi8KaW50IGdyaF9jYXB0dXJlKHZvaWQpCnsKICBpbnQgaTsKICBp
bnQgZXJyOwogIHNuZF9wY21fdCAqY2FwdHVyZV9oYW5kbGU7CiAgc25kX3BjbV9od19wYXJhbXNf
dCAqaHdfcGFyYW1zOwoKICAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAg
ICogT3BlbiB0aGUgcGNtIGludGVyZmFjZQogICAqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKiovCiAgaWYgKChlcnIgPSBzbmRfcGNtX29wZW4oJmNhcHR1cmVfaGFuZGxlLCBzbmRf
ZGV2aWNlX2luLCBTTkRfUENNX1NUUkVBTV9DQVBUVVJFLCAwKSkgPCAwKQogIHsKICAgIGZwcmlu
dGYoc3RkZXJyLCAiRmFpbGVkIHRvIG9wZW4gaW5wdXQgYXVkaW8gZGV2aWNlICVzOiAlc1xuIiwg
c25kX2RldmljZV9vdXQsIHNuZF9zdHJlcnJvcihlcnIpKTsKICAgIGV4aXQoMSk7CiAgfQoKICAv
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAgICogQ29uZmlndXJlIHRoZSBk
ZXZpY2VzCiAgICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KICBpZiAoKGVy
ciA9IHNuZF9wY21faHdfcGFyYW1zX21hbGxvYyAoJmh3X3BhcmFtcykpIDwgMCkKICB7CiAgICBm
cHJpbnRmIChzdGRlcnIsICJjYW5ub3QgYWxsb2NhdGUgaGFyZHdhcmUgcGFyYW1ldGVyIHN0cnVj
dHVyZSAoJXMpXG4iLHNuZF9zdHJlcnJvciAoZXJyKSk7CiAgICBleGl0ICgxKTsKICB9CgogIGlm
ICgoZXJyID0gc25kX3BjbV9od19wYXJhbXNfYW55IChjYXB0dXJlX2hhbmRsZSwgaHdfcGFyYW1z
KSkgPCAwKSAKICB7CiAgICBmcHJpbnRmIChzdGRlcnIsICJjYW5ub3QgaW5pdGlhbGl6ZSBoYXJk
d2FyZSBwYXJhbWV0ZXIgc3RydWN0dXJlICglcylcbiIsc25kX3N0cmVycm9yIChlcnIpKTsKICAg
IGV4aXQgKDEpOwogIH0KCQogIGlmICgoZXJyID0gc25kX3BjbV9od19wYXJhbXNfc2V0X2FjY2Vz
cyAoY2FwdHVyZV9oYW5kbGUsIGh3X3BhcmFtcywgU05EX1BDTV9BQ0NFU1NfUldfSU5URVJMRUFW
RUQpKSA8IDApIAogIHsKICAgIGZwcmludGYgKHN0ZGVyciwgImNhbm5vdCBzZXQgYWNjZXNzIHR5
cGUgKCVzKVxuIixzbmRfc3RyZXJyb3IgKGVycikpOwogICAgZXhpdCAoMSk7CiAgfQoKICBpZiAo
KGVyciA9IHNuZF9wY21faHdfcGFyYW1zX3NldF9mb3JtYXQgKGNhcHR1cmVfaGFuZGxlLCBod19w
YXJhbXMsIFNORF9QQ01fRk9STUFUX1M4KSkgPCAwKSB7CiAgICBmcHJpbnRmIChzdGRlcnIsICJj
YW5ub3Qgc2V0IHNhbXBsZSBmb3JtYXQgKCVzKVxuIixzbmRfc3RyZXJyb3IgKGVycikpOwogICAg
ZXhpdCAoMSk7CiAgfQoKICBpZiAoKGVyciA9IHNuZF9wY21faHdfcGFyYW1zX3NldF9yYXRlX25l
YXIgKGNhcHR1cmVfaGFuZGxlLCBod19wYXJhbXMsICZzYW1wbGVfcmF0ZSwgMCkpIDwgMCkgCiAg
ewogICAgZnByaW50ZiAoc3RkZXJyLCAiY2Fubm90IHNldCBzYW1wbGUgcmF0ZSAoJXMpXG4iLHNu
ZF9zdHJlcnJvciAoZXJyKSk7CiAgICBleGl0ICgxKTsKICB9CgkKICBpZiAoKGVyciA9IHNuZF9w
Y21faHdfcGFyYW1zX3NldF9jaGFubmVscyAoY2FwdHVyZV9oYW5kbGUsIGh3X3BhcmFtcywgbmNo
YW5uZWxzKSkgPCAwKSAKICB7CiAgICBmcHJpbnRmIChzdGRlcnIsICJjYW5ub3Qgc2V0IGNoYW5u
ZWwgY291bnQgKCVzKVxuIixzbmRfc3RyZXJyb3IgKGVycikpOwogICAgZXhpdCAoMSk7CiAgfQoK
ICBpZiAoKGVyciA9IHNuZF9wY21faHdfcGFyYW1zIChjYXB0dXJlX2hhbmRsZSwgaHdfcGFyYW1z
KSkgPCAwKSB7CiAgICBmcHJpbnRmIChzdGRlcnIsICJjYW5ub3Qgc2V0IHBhcmFtZXRlcnMgKCVz
KVxuIixzbmRfc3RyZXJyb3IgKGVycikpOwogICAgZXhpdCAoMSk7CiAgfQoKICBzbmRfcGNtX2h3
X3BhcmFtc19mcmVlIChod19wYXJhbXMpOwoKICBpZiAoKGVyciA9IHNuZF9wY21fcHJlcGFyZSAo
Y2FwdHVyZV9oYW5kbGUpKSA8IDApIHsKICAgIGZwcmludGYgKHN0ZGVyciwgImNhbm5vdCBwcmVw
YXJlIGF1ZGlvIGludGVyZmFjZSBmb3IgdXNlICglcylcbiIsc25kX3N0cmVycm9yIChlcnIpKTsK
ICAgIGV4aXQgKDEpOwogIH0KCiAgLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKgogICAqIFBlcmZvcm0gY2FwdHVyZSBhbmQgc3RvcmUgdG8gYnVmZmVyCiAgICoqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KICBmb3IgKGkgPSAwOyBpIDwg
MTAwOyArK2kpIHsKICAgIGlmICgoZXJyID0gc25kX3BjbV9yZWFkaSAoY2FwdHVyZV9oYW5kbGUs
IGJ1ZiwgYnVmZmVyX3NpemUpKSAhPSBidWZmZXJfc2l6ZSkgewogICAgICBmcHJpbnRmIChzdGRl
cnIsICJyZWFkIGZyb20gYXVkaW8gaW50ZXJmYWNlIGZhaWxlZCAoJXMpXG4iLHNuZF9zdHJlcnJv
ciAoZXJyKSk7CiAgICAgIGV4aXQgKDEpOwogICAgfQogIH0KCiAgLyoqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioKICAgKiBDbG9zZSBQQ00gaW50ZXJmYWNlIGFuZCBl
eGl0CiAgICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCiAgc25k
X3BjbV9jbG9zZSAoY2FwdHVyZV9oYW5kbGUpOwogIHJldHVybiAwOwp9CgovKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAqIFBsYXliYWNrIEZ1bmN0aW9u
OgogKiBUaGlzIGZ1bmN0aW9uIHNob3VsZCByZXRyaWV2ZSBhdWRpbyBmcm9tIGEgCiAqIGJ1ZmZl
ciBhbmQgc2VuZCBpdCB0byB0aGUgUENNIGZvciBwbGF5YmFjawogKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwppbnQgZ3JoX3BsYXliYWNrKHZvaWQpCnsK
ICBpbnQgaTsKICBpbnQgZXJyOwogIHNuZF9wY21fdCAqcGxheWJhY2tfaGFuZGxlOwogIHNuZF9w
Y21faHdfcGFyYW1zX3QgKmh3X3BhcmFtczsKCiAgLyoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKgogICAqIE9wZW4gdGhlIHBjbSBpbnRlcmZhY2UKICAgKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqLwogIGlmICgoZXJyID0gc25kX3BjbV9vcGVuKCZwbGF5YmFj
a19oYW5kbGUsIHNuZF9kZXZpY2Vfb3V0LCBTTkRfUENNX1NUUkVBTV9QTEFZQkFDSywgMCkpIDwg
MCkgCiAgewogICAgZnByaW50ZihzdGRlcnIsICJGYWlsZWQgdG8gb3BlbiBvdXRwdXQgYXVkaW8g
ZGV2aWNlICVzOiAlc1xuIiwgc25kX2RldmljZV9pbiwgc25kX3N0cmVycm9yKGVycikpOwogICAg
ZXhpdCgxKTsKICB9CgogIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKICAg
KiBDb25maWd1cmUgdGhlIGRldmljZXMKICAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqLwogIGlmICgoZXJyID0gc25kX3BjbV9od19wYXJhbXNfbWFsbG9jICgmaHdfcGFyYW1z
KSkgPCAwKSB7CiAgICBmcHJpbnRmIChzdGRlcnIsICJjYW5ub3QgYWxsb2NhdGUgaGFyZHdhcmUg
cGFyYW1ldGVyIHN0cnVjdHVyZSAoJXMpXG4iLHNuZF9zdHJlcnJvciAoZXJyKSk7CiAgICBleGl0
ICgxKTsKICB9CgkJCQkgCiAgaWYgKChlcnIgPSBzbmRfcGNtX2h3X3BhcmFtc19hbnkgKHBsYXli
YWNrX2hhbmRsZSwgaHdfcGFyYW1zKSkgPCAwKSB7CiAgICBmcHJpbnRmIChzdGRlcnIsICJjYW5u
b3QgaW5pdGlhbGl6ZSBoYXJkd2FyZSBwYXJhbWV0ZXIgc3RydWN0dXJlICglcylcbiIsc25kX3N0
cmVycm9yIChlcnIpKTsKICAgIGV4aXQgKDEpOwogIH0KCQogIGlmICgoZXJyID0gc25kX3BjbV9o
d19wYXJhbXNfc2V0X2FjY2VzcyAocGxheWJhY2tfaGFuZGxlLCBod19wYXJhbXMsIFNORF9QQ01f
QUNDRVNTX1JXX0lOVEVSTEVBVkVEKSkgPCAwKSB7CiAgICBmcHJpbnRmIChzdGRlcnIsICJjYW5u
b3Qgc2V0IGFjY2VzcyB0eXBlICglcylcbiIsc25kX3N0cmVycm9yIChlcnIpKTsKICAgIGV4aXQg
KDEpOwogIH0KCQogIGlmICgoZXJyID0gc25kX3BjbV9od19wYXJhbXNfc2V0X2Zvcm1hdCAocGxh
eWJhY2tfaGFuZGxlLCBod19wYXJhbXMsIFNORF9QQ01fRk9STUFUX1M4KSkgPCAwKSB7CiAgICBm
cHJpbnRmIChzdGRlcnIsICJjYW5ub3Qgc2V0IHNhbXBsZSBmb3JtYXQgKCVzKVxuIixzbmRfc3Ry
ZXJyb3IgKGVycikpOwogICAgZXhpdCAoMSk7CiAgfQoJCiAgaWYgKChlcnIgPSBzbmRfcGNtX2h3
X3BhcmFtc19zZXRfcmF0ZV9uZWFyIChwbGF5YmFja19oYW5kbGUsIGh3X3BhcmFtcywgJnNhbXBs
ZV9yYXRlLCAwKSkgPCAwKSB7CiAgICBmcHJpbnRmIChzdGRlcnIsICJjYW5ub3Qgc2V0IHNhbXBs
ZSByYXRlICglcylcbiIsc25kX3N0cmVycm9yIChlcnIpKTsKICAgIGV4aXQgKDEpOwogIH0KCQog
IGlmICgoZXJyID0gc25kX3BjbV9od19wYXJhbXNfc2V0X2NoYW5uZWxzIChwbGF5YmFja19oYW5k
bGUsIGh3X3BhcmFtcywgbmNoYW5uZWxzKSkgPCAwKSB7CiAgICBmcHJpbnRmIChzdGRlcnIsICJj
YW5ub3Qgc2V0IGNoYW5uZWwgY291bnQgKCVzKVxuIixzbmRfc3RyZXJyb3IgKGVycikpOwogICAg
ZXhpdCAoMSk7CiAgfQoKICBpZiAoKGVyciA9IHNuZF9wY21faHdfcGFyYW1zIChwbGF5YmFja19o
YW5kbGUsIGh3X3BhcmFtcykpIDwgMCkgewogICAgZnByaW50ZiAoc3RkZXJyLCAiY2Fubm90IHNl
dCBwYXJhbWV0ZXJzICglcylcbiIsc25kX3N0cmVycm9yIChlcnIpKTsKICAgIGV4aXQgKDEpOwog
IH0KCQogIHNuZF9wY21faHdfcGFyYW1zX2ZyZWUgKGh3X3BhcmFtcyk7CgogIGlmICgoZXJyID0g
c25kX3BjbV9wcmVwYXJlIChwbGF5YmFja19oYW5kbGUpKSA8IDApIHsKICAgIGZwcmludGYgKHN0
ZGVyciwgImNhbm5vdCBwcmVwYXJlIGF1ZGlvIGludGVyZmFjZSBmb3IgdXNlICglcylcbiIsc25k
X3N0cmVycm9yIChlcnIpKTsKICAgIGV4aXQgKDEpOwogIH0KCiAgLyoqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKgogICAqIFBsYXliYWNrIGZyb20gYnVmZmVyCiAgICoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KICBmb3IgKGkgPSAwOyBp
IDwgMTAwOyArK2kpIHsKICAgIGlmICgoZXJyID0gc25kX3BjbV93cml0ZWkgKHBsYXliYWNrX2hh
bmRsZSwgYnVmLCBidWZmZXJfc2l6ZSkpICE9IGJ1ZmZlcl9zaXplKSB7CiAgICAgIGZwcmludGYg
KHN0ZGVyciwgIndyaXRlIHRvIGF1ZGlvIGludGVyZmFjZSBmYWlsZWQgKCVzKVxuIixzbmRfc3Ry
ZXJyb3IgKGVycikpOwogICAgICBleGl0ICgxKTsKICAgIH0KICB9CgogIC8qKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAgICogQ2xvc2UgUENNIGludGVyZmFjZSBh
bmQgZXhpdAogICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwog
IHNuZF9wY21fY2xvc2UgKHBsYXliYWNrX2hhbmRsZSk7CiAgcmV0dXJuIDA7Cn0KCg==
------=_Part_9234_29662534.1184175034501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_9234_29662534.1184175034501--
