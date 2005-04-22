From: =?ISO-8859-1?Q?Istv=E1n_V=E1radi?= <ivaradi@gmail.com>
Subject: ALSA on AMD64 with a 32-bit userspace
Date: Fri, 22 Apr 2005 11:04:53 +0200
Message-ID: <dbdd6db90504220204e2f80ac@mail.gmail.com>
Reply-To: =?ISO-8859-1?Q?Istv=E1n_V=E1radi?= <ivaradi@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_349_5011630.1114160693328"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_349_5011630.1114160693328
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I am using ALSA with a 64-bit AMD64 kernel (2.6.11) but with 32-bit
applications. While trying to use Rosegarden4 (with JACK and
Fluidsynth), I encountered some problems:

- some sequencer-related ioctl's did not work correctly because the
kernel member of seq_port_info structure was not initialized. I
attached a patch that initializes this to 0.

- start the playback with snd_pcm_hw_start failed with -EPIPE, because
some pointers were not updated. I attached a patch for alsa-lib 1.0.8,
in which sync_ptr is called before SNDRV_PCM_IOCTL_START. It seems to
solve the problem, though I don't know alsa-lib enough to be sure that
this is the right solution...

With these patches playback works, but JACK always reports xruns,
whereas there aren't any. I discovered that the xruns are detected in
the alsa_driver_wait function in alsa_driver.c (in JACK) returns 0,
because the snd_pcm_avail_update calls in that function return 0.
Putting sync_ptr into snd_pcm_avail_update does not seem to solve the
problem.

JACK works properly when run with a 32-bit kernel or when compiled
into a 64-bit executable.

Could you give me some hints as to what can I try? Or what can I do to
help you debugging this problem? (Please reply to me directly, since I
am not on the list).

Thanks,

Istv=E1n

------=_Part_349_5011630.1114160693328
Content-Type: text/x-patch; name="alsa-ioctl32-2.6.11.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-ioctl32-2.6.11.patch"

LS0tIHNvdW5kL2NvcmUvaW9jdGwzMi9zZXEzMi5jLm9yaWcJMjAwNS0wMy0wMiAwODozODozMy4w
MDAwMDAwMDAgKzAxMDAKKysrIHNvdW5kL2NvcmUvaW9jdGwzMi9zZXEzMi5jCTIwMDUtMDQtMTYg
MTY6Mzk6MDIuMDAwMDAwMDAwICswMjAwCkBAIC01OSw2ICs1OSw3IEBACiAJQ09QWSh3cml0ZV91
c2UpO1wKIAlDT1BZKGZsYWdzKTtcCiAJQ09QWSh0aW1lX3F1ZXVlKTtcCisgICAgICAgIGRzdC0+
a2VybmVsID0gMDtcCiB9CiAKIERFRklORV9BTFNBX0lPQ1RMKHNlcV9wb3J0X2luZm8pOwo=
------=_Part_349_5011630.1114160693328
Content-Type: text/x-patch; name="alsa_pcm_hw.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa_pcm_hw.patch"

LS0tIHNyYy9wY20vcGNtX2h3LmMub3JpZwkyMDA0LTEyLTIxIDE1OjExOjAyLjAwMDAwMDAwMCAr
MDEwMAorKysgc3JjL3BjbS9wY21faHcuYwkyMDA1LTA0LTE2IDE5OjA5OjExLjAwMDAwMDAwMCAr
MDIwMApAQCAtNTQzLDYgKzU0Myw3IEBACiAJYXNzZXJ0KHBjbS0+c3RyZWFtICE9IFNORF9QQ01f
U1RSRUFNX1BMQVlCQUNLIHx8CiAJICAgICAgIHNuZF9wY21fbW1hcF9wbGF5YmFja19od19hdmFp
bChwY20pID4gMCk7CiAjZW5kaWYKKyAgICAgICAgc3luY19wdHIoaHcsIDApOwogCWlmIChpb2N0
bChody0+ZmQsIFNORFJWX1BDTV9JT0NUTF9TVEFSVCkgPCAwKSB7CiAJCWVyciA9IC1lcnJubzsK
IAkJU1lTTVNHKCJTTkRSVl9QQ01fSU9DVExfU1RBUlQgZmFpbGVkIik7Cg==
------=_Part_349_5011630.1114160693328--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
