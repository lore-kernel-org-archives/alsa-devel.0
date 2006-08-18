From: "Andrey Liakhovets" <liakh@dol.ru>
Subject: Re: [Openchrome-users] via epia boards sound quality
Date: Sat, 19 Aug 2006 01:02:09 +0400
Message-ID: <web-171065599@cgp.dol.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_===171065599====cgp.dol.ru===_"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part MIME message

--_===171065599====cgp.dol.ru===_
Content-Type: text/plain; charset="KOI8-R"
Content-Transfer-Encoding: quoted-printable

This letter is continuation of the thread in Openchrome-users:
http://wiki.openchrome.org/pipermail/openchrome-users/2006-May/001193.htm=
l
http://wiki.openchrome.org/pipermail/openchrome-users/2006-May/001199.htm=
l
http://wiki.openchrome.org/pipermail/openchrome-users/2006-May/001247.htm=
l
http://wiki.openchrome.org/pipermail/openchrome-users/2006-July/001456.ht=
ml

I am sorry for continuing this thread but there is good news.

In short, the attached 1-line patch against alsa 1.0.11 solves the proble=
m
(for our VIA EPIA SP8000).

Further details:
1) in our lab, we failed in getting bad sound on a running system,
       despite a long and intensive heating;
2) we have succeded in reproducing the problem at the system start (with =
a
       probability of about 2/3) with a pre-cooled sound codec chip;
3) we have succeded in reproducing the problem on the system running Linu=
x
       by cutting analog power supply from the codec, cooling the codec a=
nd
       reattaching analog power;
4) on wire, the problem looks like undervoltage of codec analog power
       (2V or less instead of 5V): meanwhile the codec tries to consume
       about 200mA (instead of <40mA), and the voltage regulator chip beg=
ins
       (from 100mA) reducing the voltage;
5) analysis of the situation with WinXP shows that the WinXP sound driver=
 loading
       brings the codec analog voltage (and sound) to norm, and this stat=
e
       is tolerant to actions described under (3);
6) analysis of the WinXP sound driver loading allowed us to detect that v=
ery bit,
       the set of which normalizes the codec's analog power consumption;
7) a check with Linux has confirmed this.

If necessary, I can give more details or upload them on our ftp.

Andrey Liakhovets

--_===171065599====cgp.dol.ru===_
Content-Type: application/octet-stream
Content-Disposition: attachment;
	filename="alsa-kernel-1.0.11-rover-ac97-vt1617a.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtTmF1ciBhL3BjaS9hYzk3L2FjOTdfcGF0Y2guYyBiL3BjaS9hYzk3L2FjOTdfcGF0
Y2guYw0KLS0tIGEvcGNpL2FjOTcvYWM5N19wYXRjaC5jCTIwMDYtMDQtMTIgMDA6NDY6NDcg
KzA0MDANCisrKyBiL3BjaS9hYzk3L2FjOTdfcGF0Y2guYwkyMDA2LTA3LTI2IDEwOjE1OjU4
ICswNDAwDQpAQCAtMjc0Miw2ICsyNzQyLDcgQEANCiAgKi8NCiBpbnQgcGF0Y2hfdnQxNjE3
YShzdHJ1Y3Qgc25kX2FjOTcgKiBhYzk3KQ0KIHsNCisJc25kX2FjOTdfd3JpdGVfY2FjaGUo
YWM5NywgMHg1YywgMHgyMCk7CS8qIGJyaW5nIGFuYWxvZyBwb3dlciBjb25zdW1wdGlvbiB0
byBub3JtYWwsIGxpa2UgV2luWFAgZHJpdmVyIGZvciBFUElBIFNQICovDQogCWFjOTctPmV4
dF9pZCB8PSBBQzk3X0VJX1NQRElGOwkvKiBmb3JjZSB0aGUgZGV0ZWN0aW9uIG9mIHNwZGlm
ICovDQogCWFjOTctPnJhdGVzW0FDOTdfUkFURVNfU1BESUZdID0gU05EUlZfUENNX1JBVEVf
NDQxMDAgfCBTTkRSVl9QQ01fUkFURV80ODAwMDsNCiAJcmV0dXJuIDA7DQoNCg0KDQo=

--_===171065599====cgp.dol.ru===_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--_===171065599====cgp.dol.ru===_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--_===171065599====cgp.dol.ru===_--
