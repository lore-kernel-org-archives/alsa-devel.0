From: "Andrey Liakhovets" <liakh@dol.ru>
Subject: Re: [Openchrome-users] via epia boards sound quality
Date: Sun, 20 Aug 2006 12:02:39 +0400
Message-ID: <web-171768144@cgp.dol.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_===171768144====cgp.dol.ru===_"
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

--_===171768144====cgp.dol.ru===_
Content-Type: text/plain; charset="KOI8-R"
Content-Transfer-Encoding: quoted-printable

James Courtier-Dutton wrote:
> Andrey Liakhovets wrote:
>>
>> In short, the attached 1-line patch against alsa 1.0.11 solves the pro=
blem
>>
>> If necessary, I can give more details or upload them on our ftp.
>>
>> Andrey Liakhovets
>
>
> Would you be able to provide 2 things?
>
> 1) Please add a "Signed-off-by:" entry.
> 2) Do you have the VT1616A datasheet?
>
> I can find the VT1616 datasheet online, but not the VT1616A.
>
> James

No, I have only the VT1616 datasheet.

Below I repeat the references, info and patch with my Signed-off-by.

http://wiki.openchrome.org/pipermail/openchrome-users/2006-May/001193.htm=
l
http://wiki.openchrome.org/pipermail/openchrome-users/2006-May/001199.htm=
l
http://wiki.openchrome.org/pipermail/openchrome-users/2006-May/001247.htm=
l
http://wiki.openchrome.org/pipermail/openchrome-users/2006-July/001456.ht=
ml

1) in our lab, we failed in getting bad sound on a running system,
        despite a long and intensive heating;
2) we have succeded in reproducing the problem at the system start (with =
a
        probability of about 2/3) with a pre-cooled sound codec chip;
3) we have succeded in reproducing the problem on the system running Linu=
x
        by cutting analog power supply from the codec, cooling the codec =
and
        reattaching analog power;
4) on wire, the problem looks like undervoltage of codec analog power
        (2V or less instead of 5V): meanwhile the codec tries to consume
        about 200mA (instead of <40mA), and the voltage regulator chip be=
gins
        (from 100mA) reducing the voltage;
5) analysis of the situation with WinXP shows that the WinXP sound driver=
 loading
        brings the codec analog voltage (and sound) to norm, and this sta=
te
        is tolerant to actions described under (3);
6) analysis of the WinXP sound driver loading allowed us to detect that v=
ery bit,
        the set of which normalizes the codec's analog power consumption;
7) a check with Linux has confirmed this.

The attached 1-line patch against alsa 1.0.11 solves the problem
(for our VIA EPIA SP8000).

Signed-off-by: Andrey Liakhovets <liakh@dol.ru>

--_===171768144====cgp.dol.ru===_
Content-Type: application/octet-stream
Content-Disposition: attachment;
	filename="alsa-kernel-1.0.11-rover-ac97-vt1617a.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtTmF1ciBhL3BjaS9hYzk3L2FjOTdfcGF0Y2guYyBiL3BjaS9hYzk3L2FjOTdfcGF0
Y2guYwotLS0gYS9wY2kvYWM5Ny9hYzk3X3BhdGNoLmMJMjAwNi0wNC0xMiAwMDo0Njo0NyAr
MDQwMAorKysgYi9wY2kvYWM5Ny9hYzk3X3BhdGNoLmMJMjAwNi0wNy0yNiAxMDoxNTo1OCAr
MDQwMApAQCAtMjc0Miw2ICsyNzQyLDcgQEAKICAqLwogaW50IHBhdGNoX3Z0MTYxN2Eoc3Ry
dWN0IHNuZF9hYzk3ICogYWM5NykKIHsKKwlzbmRfYWM5N193cml0ZV9jYWNoZShhYzk3LCAw
eDVjLCAweDIwKTsJLyogYnJpbmcgYW5hbG9nIHBvd2VyIGNvbnN1bXB0aW9uIHRvIG5vcm1h
bCwgbGlrZSBXaW5YUCBkcml2ZXIgZm9yIEVQSUEgU1AgKi8KIAlhYzk3LT5leHRfaWQgfD0g
QUM5N19FSV9TUERJRjsJLyogZm9yY2UgdGhlIGRldGVjdGlvbiBvZiBzcGRpZiAqLwogCWFj
OTctPnJhdGVzW0FDOTdfUkFURVNfU1BESUZdID0gU05EUlZfUENNX1JBVEVfNDQxMDAgfCBT
TkRSVl9QQ01fUkFURV80ODAwMDsKIAlyZXR1cm4gMDsK

--_===171768144====cgp.dol.ru===_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--_===171768144====cgp.dol.ru===_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--_===171768144====cgp.dol.ru===_--
