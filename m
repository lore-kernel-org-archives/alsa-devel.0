From: Ryan Pavlik <rpav@mephle.com>
Subject: Re: Simple alsa sequencer question
Date: Mon, 27 Oct 2003 16:59:33 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031027165933.2307acfe.rpav@mephle.com>
References: <20031025024106.3aad73cc.rpav@mephle.com>
	<s5hismb6jdu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__27_Oct_2003_16_59_33_-0800_3EdVuCLHKW2Bujkm"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hismb6jdu.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Mon__27_Oct_2003_16_59_33_-0800_3EdVuCLHKW2Bujkm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2003 11:54:21 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 25 Oct 2003 02:41:06 -0700,
> Ryan Pavlik wrote:
<snip>
> > Shouldn't I get numbers in ev->time.time.tv_*?  I'm just getting
> > zeros... what did I miss? ;)
> 
> no, it should be, as long as the event is delivered to these
> subscribers (i.e. setting the destination as SND_SEQ_ADDR_SUBSCRIBERS).
> 
> btw, to update the timestamp of every event to a certain port, you can
> set the timestamp attribute on the port_info, too.

OK, I've attached some code to show what I'm doing exactly.

I'm trying to receive input from an external sequencer that's tagged
with the event arrival time.  The docs indicate this should be no
problem, and I believe I've done what they say, but I'm obviously not
doing something right. :-)

I prefer time in realtime, not midi time, for accuracy and time
calculation reasons, but neither seems to work.

Also, I seem to be getting a lot of type 42 messages (active sense).
Now, only one piece of gear (Roland, go figure ;) generates these, and
the MTP/AV i'm using blocks them (thankfully).  The Roland gear is
off, and the MTP/AV shows no input traffic.  Why am I still getting
these messages...?  (For my ruby lib, i'm filtering them at the moment
since they're the useless, but saving a little CPU would be nice,
too.)

Thanks,

-- 
Ryan Pavlik <rpav@mephle.com>

"I believe in exploiting debts, not having them." - 8BT

--Multipart=_Mon__27_Oct_2003_16_59_33_-0800_3EdVuCLHKW2Bujkm
Content-Type: application/octet-stream;
 name="test.c"
Content-Disposition: attachment;
 filename="test.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPGFsc2EvYXNvdW5kbGliLmg+CgojZGVmaW5lIENMSUVOVCA3MgojZGVmaW5lIFBP
UlQgICAgMAoKdm9pZCBzdWJzY3JpYmVfdG8oc25kX3NlcV90ICpzZXEsIGludCBwb3J0LCBpbnQg
Y2xpZW50LCBpbnQgY19wb3J0KTsKCmludCBtYWluKCkgewogICAgc25kX3NlcV90ICAgICAgICpz
ZXE7CiAgICBpbnQgICAgICAgICAgICAgIHBvcnQ7CiAgICBzbmRfc2VxX2V2ZW50X3QgKmV2OwoK
ICAgIC8qIE9wZW4gdGhlIHNlcXVlbmNlciAqLwogICAgc25kX3NlcV9vcGVuKCZzZXEsICJkZWZh
dWx0IiwgU05EX1NFUV9PUEVOX0lOUFVULCAwKTsKICAgIHNuZF9zZXFfc2V0X2NsaWVudF9uYW1l
KHNlcSwgInRlc3QiKTsKCiAgICAvKiBPdXIgcG9ydCAqLwogICAgcG9ydCA9IHNuZF9zZXFfY3Jl
YXRlX3NpbXBsZV9wb3J0KHNlcSwgInRlc3QgcG9ydCIsCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgU05EX1NFUV9QT1JUX0NBUF9XUklURXxTTkRfU0VRX1BPUlRfQ0FQX1NV
QlNfV1JJVEUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU05EX1NFUV9Q
T1JUX1RZUEVfTUlESV9HRU5FUklDfFNORF9TRVFfUE9SVF9UWVBFX0FQUExJQ0FUSU9OKTsKCgog
ICAgc3Vic2NyaWJlX3RvKHNlcSwgcG9ydCwgQ0xJRU5ULCBQT1JUKTsKCiAgICBmb3IoOzspIHsK
ICAgICAgICBzbmRfc2VxX2V2ZW50X2lucHV0KHNlcSwgJmV2KTsKICAgICAgICBwcmludGYoIlR5
cGU6ICVkIFRpbWU6ICVkICVkXG4iLCBldi0+dHlwZSwgZXYtPnRpbWUudGltZS50dl9zZWMsCiAg
ICAgICAgICAgICAgIGV2LT50aW1lLnRpbWUudHZfbnNlYyk7CiAgICAgICAgLyogVGhpcyBwcmlu
dHMgMCAwIC4uLiB3aGF0IGRvIEkgZG8gdG8gcmVjZWl2ZSB0aW1lPyAqLwogICAgfQp9Cgp2b2lk
IHN1YnNjcmliZV90byhzbmRfc2VxX3QgKnNlcSwgaW50IHBvcnQsIGludCBjbGllbnQsIGludCBj
X3BvcnQpIHsKICAgIHNuZF9zZXFfYWRkcl90IHNlbmRlciwgZGVzdDsKICAgIHNuZF9zZXFfcG9y
dF9zdWJzY3JpYmVfdCAqc3ViczsKICAgIGludCBxdWV1ZTsKICAgIHNuZF9zZXFfZXZlbnRfdCBl
djsKCiAgICBzZW5kZXIuY2xpZW50ID0gY2xpZW50OwogICAgc2VuZGVyLnBvcnQgICA9IGNfcG9y
dDsKICAgIGRlc3QuY2xpZW50ICAgPSBzbmRfc2VxX2NsaWVudF9pZChzZXEpOwogICAgZGVzdC5w
b3J0ICAgICA9IHBvcnQ7CiAgICBxdWV1ZSAgICAgICAgID0gc25kX3NlcV9hbGxvY19xdWV1ZShz
ZXEpOwoKICAgIHNuZF9zZXFfcG9ydF9zdWJzY3JpYmVfYWxsb2NhKCZzdWJzKTsKICAgIHNuZF9z
ZXFfcG9ydF9zdWJzY3JpYmVfc2V0X3NlbmRlcihzdWJzLCAmc2VuZGVyKTsKICAgIHNuZF9zZXFf
cG9ydF9zdWJzY3JpYmVfc2V0X2Rlc3Qoc3VicywgJmRlc3QpOwogICAgc25kX3NlcV9wb3J0X3N1
YnNjcmliZV9zZXRfcXVldWUoc3VicywgcXVldWUpOwogICAgc25kX3NlcV9wb3J0X3N1YnNjcmli
ZV9zZXRfdGltZV91cGRhdGUoc3VicywgMSk7CiAgICBzbmRfc2VxX3BvcnRfc3Vic2NyaWJlX3Nl
dF90aW1lX3JlYWwoc3VicywgMSk7CiAgICBzbmRfc2VxX3N1YnNjcmliZV9wb3J0KHNlcSwgc3Vi
cyk7Cn0K

--Multipart=_Mon__27_Oct_2003_16_59_33_-0800_3EdVuCLHKW2Bujkm--


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
