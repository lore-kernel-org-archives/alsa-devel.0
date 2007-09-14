From: "Michael Bourgeous" <sts.nitrogen@gmail.com>
Subject: Re: [Pkg-alsa-devel] Bug#436502: alsa-tools ->
	usx2yloader
Date: Fri, 14 Sep 2007 02:45:57 -0600
Message-ID: <8e4fc8270709140145u2dc5a2cbq2f9fba4c77f2c692@mail.gmail.com>
References: <20070911152102.GA17585@frodo.home.lxtec.de>
	<20070912205256.GR4125@frodo.home.lxtec.de>
	<8e4fc8270709130123x39b33a1fkd4dae9d018bb4c65@mail.gmail.com>
	<20070913093252.GA7645@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_773_3329632.1189759557446"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FF3524478
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 10:45:58 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so1055486mue
	for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2007 01:45:57 -0700 (PDT)
In-Reply-To: <20070913093252.GA7645@aragorn.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Bourgeous <sts.nitrogen@gmail.com>, pkg-alsa-devel@lists.alioth.debian.org, alsa-devel <alsa-devel@alsa-project.org>, Karsten Wiese <annabellesgarden@yahoo.de>, 436502@
List-Id: alsa-devel@alsa-project.org

------=_Part_773_3329632.1189759557446
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 9/13/07, Elimar Riesebieter <riesebie@lxtec.de> wrote:
> On Thu, 13 Sep 2007 the mental interface of
> Michael Bourgeous told:
> > A better option might be a patch to us428control to add a daemonize
> > switch (which, of course, could be as simple as fclose()-ing stdin,
> > stdout, and stderr, and dealing with any I/O functions accordingly).
>
> Hmm, from my patch tascam_fw and tascam_fpga are installed to
> /lib/udev. The udev rules are calling these scripts which are almost
> doing what your udev rule is doing manualy, isn't it?
> There is one user [0], who came along with an rule similar to the
> attached which still works. My intention is not do rewrite
> usx2yloaders, but optimize it for distribution.
>
> I don't know whether upstream is active to help? A statement from
> Karsten Wiese would be helpfull at that point ;)
>
> But if your rule works for sure, I can distribute it with your
> allowness. There are still ugly sh -c calls I don't understand yet.
>
> [0] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=361558
>
> Thanks for your competent input ;)
>
> Elimar
>

The sh -c was necessary to keep udev from hanging when loading the
US-224 and US-428 (because of us428control).  I don't remember why I
chose not to use the existing scripts, but one thing I don't like
about those scripts is that they will load the firmware for /all/
Tascam USB devices, not just the one currently being probed by udev.
This could either confuse udev or try to load the firmware multiple
times for each device, possibly resulting in errors.  Unfortunately,
all of the utilities involved (fxload, usx2yloader, us428control)
expect the old hotplug-style device path (/proc/bus/usb/111/222)
instead of the sysfs/udev-style path (what a mess this udev switch
still causes).

I just spent the last three hours trying to fix this problem, and I
can only come to the conclusion that udev is horribly broken.  For
example, my firmware load rule gets called not only when the USB
device comes on, but each time ALSA adds a new device from the usx2y
(i.e. control, mixer, PCM, etc.), resulting in a lot of wasted time,
and many erroneous calls to usx2yloader.  Moreover, the rule gets
called once for every device /removed/, even though it says
ACTION="add".  Finally, it seems that every now and then, udev tries
the whole process over again, even though the firmware is loaded and
us428control is running.  Why do we have to keep breaking things that
work?

At any rate, I've made a slightly improved version of my previous
script, which you may distribute under any free license, if it is
found to be better than the alternatives.

Mike Bourgeous

------=_Part_773_3329632.1189759557446
Content-Type: application/octet-stream; name="55-tascam.rules"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="55-tascam.rules"
X-Attachment-Id: f_f6kfz74v

IyBUYXNjYW0gVVMteDJ5IEZpcm13YXJlIFNjcmlwdCBieSBNaWtlIEJvdXJnZW91cyA8bml0cm9n
ZW4gYXQgdXNlcnMuc291cmNlZm9yZ2UubmV0PgojIEJhc2VkIG9uIGh0dHA6Ly93d3cuYXN0cm8u
Y2FsdGVjaC5lZHUvfm1jcy90YXNjYW1fdXMxMjIvaW5kZXguaHRtbAoKIyBGb3JnZXQgYWJvdXQg
dHJ5aW5nIHRvIGxvYWQgdGhlIGZpcm13YXJlIGZvciBqdXN0IHRoZSBkZXZpY2UgYmVpbmcgcHJv
YmVkLCB1bmxlc3MKIyB5b3Ugd2FudCB0byBzZWUgbmlnaHRtYXJpc2ggc3RhdGVtZW50cyBldmVu
IHdvcnNlIHRoYW4gdGhlIGZvbGxvd2luZyBsaW5lOgojIFJVTis9Ii9iaW4vc2ggLWMgJy9zYmlu
L2Z4bG9hZCAtdnYgLUQgJCQocHJpbnRmIC9kZXYvYnVzL3VzYi8lJTAzZC8lJTAzZCAkJChlY2hv
ICVwIHwgc2VkIC1lIHMvXFteMC05XF1cKlxcXChcWzAtOVxdXCpcXFwpXFwuXFxcKFxbMC05XF1c
KlxcXCkuXCovXFwxXCBcXDIvICkpIC1zIC91c3Ivc2hhcmUvYWxzYS9maXJtd2FyZS91c3gyeWxv
YWRlci90YXNjYW1fbG9hZGVyLmloeCAtSSAvdXNyL3NoYXJlL2Fsc2EvZmlybXdhcmUvdXN4Mnls
b2FkZXIvdXM0Mjhmdy5paHgnIgoKCiMjIyBVUy00MjggIyMjCiMgTG9hZCBmaXJtd2FyZSAjCkJV
Uz09InVzYiIsIEFDVElPTj09ImFkZCIsIFNZU0ZTe2lkUHJvZHVjdH09PSI4MDAwIiwgU1lTRlN7
aWRWZW5kb3J9PT0iMTYwNCIsIFwKCVJVTis9Ii9iaW4vc2ggLWMgJy9zYmluL2Z4bG9hZCAtRCAl
TiAtdnYgLXMgL3Vzci9zaGFyZS9hbHNhL2Zpcm13YXJlL3VzeDJ5bG9hZGVyL3Rhc2NhbV9sb2Fk
ZXIuaWh4IC1JIC91c3Ivc2hhcmUvYWxzYS9maXJtd2FyZS91c3gyeWxvYWRlci91czQyOGZ3Lmlo
eCciCiMgTG9hZCBmcGdhICMKQlVTPT0idXNiIiwgQUNUSU9OPT0iYWRkIiwgU1lTRlN7aWRQcm9k
dWN0fT09IjgwMDEiLCBTWVNGU3tpZFZlbmRvcn09PSIxNjA0IiwgU1VCU1lTVEVNPT0idXNiIiwg
RFJJVkVSPT0ic25kLXVzYi11c3gyeSIgXCAKCVJVTis9Ii9iaW4vc2ggLWMgJy91c3IvYmluL3Vz
eDJ5bG9hZGVyOyAvdXNyL2Jpbi91czQyOGNvbnRyb2wgLW0gdXM0MjggJiciCgojIyMgVVMtMjI0
ICMjIwojIExvYWQgZmlybXdhcmUgIwpCVVM9PSJ1c2IiLCBBQ1RJT049PSJhZGQiLCBTWVNGU3tp
ZFByb2R1Y3R9PT0iODAwNCIsIFNZU0ZTe2lkVmVuZG9yfT09IjE2MDQiLCBcCglSVU4rPSIvYmlu
L3NoIC1jICcvc2Jpbi9meGxvYWQgLUQgJU4gLXZ2IC1zIC91c3Ivc2hhcmUvYWxzYS9maXJtd2Fy
ZS91c3gyeWxvYWRlci90YXNjYW1fbG9hZGVyLmloeCAtSSAvdXNyL3NoYXJlL2Fsc2EvZmlybXdh
cmUvdXN4Mnlsb2FkZXIvdXMyMjRmdy5paHgnIgojIExvYWQgZnBnYSAjCkJVUz09InVzYiIsIEFD
VElPTj09ImFkZCIsIFNZU0ZTe2lkUHJvZHVjdH09PSI4MDA1IiwgU1lTRlN7aWRWZW5kb3J9PT0i
MTYwNCIsIFwKCVJVTis9Ii9iaW4vc2ggLWMgJy91c3IvYmluL3VzeDJ5bG9hZGVyIDsgL3Vzci9i
aW4vdXM0Mjhjb250cm9sIC1tIHVzMjI0ICYnIgoKIyMjIFVTLTEyMiAjIyMKIyBMb2FkIGZpcm13
YXJlICMKQlVTPT0idXNiIiwgQUNUSU9OPT0iYWRkIiwgU1lTRlN7aWRQcm9kdWN0fT09IjgwMDYi
LCBTWVNGU3tpZFZlbmRvcn09PSIxNjA0IiwgXAoJUlVOKz0iL2Jpbi9zaCAtYyAnL3NiaW4vZnhs
b2FkIC1EICVOIC12diAtcyAvdXNyL3NoYXJlL2Fsc2EvZmlybXdhcmUvdXN4Mnlsb2FkZXIvdGFz
Y2FtX2xvYWRlci5paHggLUkgL3Vzci9zaGFyZS9hbHNhL2Zpcm13YXJlL3VzeDJ5bG9hZGVyL3Vz
MTIyZncuaWh4JyIKIyBMb2FkIGZwZ2EgIwpCVVM9PSJ1c2IiLCBBQ1RJT049PSJhZGQiLCBTWVNG
U3tpZFByb2R1Y3R9PT0iODAwNyIsIFNZU0ZTe2lkVmVuZG9yfT09IjE2MDQiLCBcCglSVU4rPSIv
YmluL3NoIC1jICcvdXNyL2Jpbi91c3gyeWxvYWRlciciCgoKCiMgdmltOiBzeW50YXg9c2gKCg==

------=_Part_773_3329632.1189759557446
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_773_3329632.1189759557446--
