From: "Michael Bourgeous" <sts.nitrogen@gmail.com>
Subject: Re: [Pkg-alsa-devel] Bug#436502: alsa-tools ->
	usx2yloader
Date: Fri, 14 Sep 2007 16:30:58 -0600
Message-ID: <8e4fc8270709141530y5a3f4efch6517461933702845@mail.gmail.com>
References: <20070911152102.GA17585@frodo.home.lxtec.de>
	<20070912205256.GR4125@frodo.home.lxtec.de>
	<8e4fc8270709130123x39b33a1fkd4dae9d018bb4c65@mail.gmail.com>
	<20070913093252.GA7645@aragorn.home.lxtec.de>
	<8e4fc8270709140145u2dc5a2cbq2f9fba4c77f2c692@mail.gmail.com>
	<b88f52540709140229q73df2dedmf9ba464160456e5b@mail.gmail.com>
	<b88f52540709140232k84a2b50vf0b2efa55996d31b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4520_2945636.1189809058540"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.185])
	by alsa0.perex.cz (Postfix) with ESMTP id BACF72417D
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Sep 2007 00:30:59 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so904606fka
	for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2007 15:30:58 -0700 (PDT)
In-Reply-To: <b88f52540709140232k84a2b50vf0b2efa55996d31b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: j t <mark473@gmail.com>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, pkg-alsa-devel@lists.alioth.debian.org, alsa-devel <alsa-devel@alsa-project.org>, 436502@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

------=_Part_4520_2945636.1189809058540
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 9/14/07, j t <mark473@gmail.com> wrote:
>
> Ooops, sorry - my bad... :-( I included the wrong line. Try this:
>
> ACTION=="add", SUBSYSTEM=="usb_device", SYSFS{idProduct}=="8007",
> SYSFS{idVendor}=="1604", RUN+="/usr/bin/usx2yloader"
>
> That's better :-)

Thanks.  Based on your advice and a little plodding through udev rules
and /lib/udev files, I've come up with a new and improved rule set
that only tries to load the firmware once, and loads it just for the
device being probed.

Mike Bourgeous

------=_Part_4520_2945636.1189809058540
Content-Type: text/plain; name="tascam.rules.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tascam.rules.txt"
X-Attachment-Id: f_f6l9joo2

IyBUYXNjYW0gVVMteDJ5IEZpcm13YXJlIFNjcmlwdCBieSBNaWtlIEJvdXJnZW91cyA8bml0cm9n
ZW4gYXQgdXNlcnMuc291cmNlZm9yZ2UubmV0PgojIEJhc2VkIG9uIGh0dHA6Ly93d3cuYXN0cm8u
Y2FsdGVjaC5lZHUvfm1jcy90YXNjYW1fdXMxMjIvaW5kZXguaHRtbCBhcyB3ZWxsIGFzIGluZm9y
bWF0aW9uCiMgcmVjZWl2ZWQgb24gdGhlIGFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0LgoKCiMjIyBV
Uy00MjggIyMjCiMgTG9hZCBmaXJtd2FyZSAjCkJVUz09InVzYiIsIEFDVElPTj09ImFkZCIsIFNZ
U0ZTe2lkUHJvZHVjdH09PSI4MDAwIiwgU1lTRlN7aWRWZW5kb3J9PT0iMTYwNCIsIFwKCVJVTis9
Ii9iaW4vc2ggLWMgJy9zYmluL2Z4bG9hZCAtRCAlTiAtdiAtcyAvdXNyL3NoYXJlL2Fsc2EvZmly
bXdhcmUvdXN4Mnlsb2FkZXIvdGFzY2FtX2xvYWRlci5paHggLUkgL3Vzci9zaGFyZS9hbHNhL2Zp
cm13YXJlL3VzeDJ5bG9hZGVyL3VzNDI4ZncuaWh4JyIKIyBMb2FkIGZwZ2EgIwpBQ1RJT049PSJh
ZGQiLCBTVUJTWVNURU09PSJ1c2JfZGV2aWNlIiwgU1lTRlN7aWRQcm9kdWN0fT09IjgwMDEiLCBT
WVNGU3tpZFZlbmRvcn09PSIxNjA0IiwgSU1QT1JUe3Byb2dyYW19PSJ1c2JfZGV2aWNlX25hbWUg
LS1leHBvcnQgJWsiLCBcCglSVU4rPSIvYmluL3NoIC1jICdleHBvcnQgX1VTQlBBVEg9L3Byb2Mv
YnVzL3VzYi8kZW52e1VTQl9CVVN9LyRlbnZ7VVNCX0RFVn07IC91c3IvYmluL3VzeDJ5bG9hZGVy
IC11ICQkX1VTQlBBVEg7IC91c3IvYmluL3VzNDI4Y29udHJvbCAtdSAkJF9VU0JQQVRIIC1tIHVz
NDI4ICYnIgoKCiMjIyBVUy0yMjQgIyMjCiMgTG9hZCBmaXJtd2FyZSAjCkJVUz09InVzYiIsIEFD
VElPTj09ImFkZCIsIFNZU0ZTe2lkUHJvZHVjdH09PSI4MDA0IiwgU1lTRlN7aWRWZW5kb3J9PT0i
MTYwNCIsIFwKCVJVTis9Ii9iaW4vc2ggLWMgJy9zYmluL2Z4bG9hZCAtRCAlTiAtdiAtcyAvdXNy
L3NoYXJlL2Fsc2EvZmlybXdhcmUvdXN4Mnlsb2FkZXIvdGFzY2FtX2xvYWRlci5paHggLUkgL3Vz
ci9zaGFyZS9hbHNhL2Zpcm13YXJlL3VzeDJ5bG9hZGVyL3VzMjI0ZncuaWh4JyIKIyBMb2FkIGZw
Z2EgIwpBQ1RJT049PSJhZGQiLCBTVUJTWVNURU09PSJ1c2JfZGV2aWNlIiwgU1lTRlN7aWRQcm9k
dWN0fT09IjgwMDUiLCBTWVNGU3tpZFZlbmRvcn09PSIxNjA0IiwgSU1QT1JUe3Byb2dyYW19PSJ1
c2JfZGV2aWNlX25hbWUgLS1leHBvcnQgJWsiLCBcCglSVU4rPSIvYmluL3NoIC1jICdleHBvcnQg
X1VTQlBBVEg9L3Byb2MvYnVzL3VzYi8kZW52e1VTQl9CVVN9LyRlbnZ7VVNCX0RFVn07IC91c3Iv
YmluL3VzeDJ5bG9hZGVyIC11ICQkX1VTQlBBVEg7IC91c3IvYmluL3VzNDI4Y29udHJvbCAtdSAk
JF9VU0JQQVRIIC1tIHVzMjI0ICYnIgoKCiMjIyBVUy0xMjIgIyMjCiMgTG9hZCBmaXJtd2FyZSAj
CkJVUz09InVzYiIsIEFDVElPTj09ImFkZCIsIFNZU0ZTe2lkUHJvZHVjdH09PSI4MDA2IiwgU1lT
RlN7aWRWZW5kb3J9PT0iMTYwNCIsIFwKCVJVTis9Ii9iaW4vc2ggLWMgJy9zYmluL2Z4bG9hZCAt
RCAlTiAtdiAtcyAvdXNyL3NoYXJlL2Fsc2EvZmlybXdhcmUvdXN4Mnlsb2FkZXIvdGFzY2FtX2xv
YWRlci5paHggLUkgL3Vzci9zaGFyZS9hbHNhL2Zpcm13YXJlL3VzeDJ5bG9hZGVyL3VzMTIyZncu
aWh4JyIKIyBMb2FkIGZwZ2EgIwpBQ1RJT049PSJhZGQiLCBTVUJTWVNURU09PSJ1c2JfZGV2aWNl
IiwgU1lTRlN7aWRQcm9kdWN0fT09IjgwMDciLCBTWVNGU3tpZFZlbmRvcn09PSIxNjA0IiwgSU1Q
T1JUe3Byb2dyYW19PSJ1c2JfZGV2aWNlX25hbWUgLS1leHBvcnQgJWsiLCBcCglSVU4rPSIvYmlu
L3NoIC1jICdleHBvcnQgX1VTQlBBVEg9L3Byb2MvYnVzL3VzYi8kZW52e1VTQl9CVVN9LyRlbnZ7
VVNCX0RFVn07IC91c3IvYmluL3VzeDJ5bG9hZGVyIC11ICQkX1VTQlBBVEgnIgoKCiMgdmltOiBz
eW50YXg9c2gKCg==
------=_Part_4520_2945636.1189809058540
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_4520_2945636.1189809058540--
