From: German Gomez <gergomez@gmail.com>
Subject: Fwd: HT Omega Claro II support
Date: Sun, 11 Sep 2016 01:10:36 -0700
Message-ID: <423f0e30-28ff-8cbe-a3d0-ed9f9c499f8c@gmail.com>
References: <a4d1eb45-30cf-48d4-cd40-93cd0b8cfdf4@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------19818C908DA1CF85E7121CE9"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id D3A3126674A
 for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2016 10:10:39 +0200 (CEST)
Received: by mail-pf0-f175.google.com with SMTP id g202so42878029pfb.0
 for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2016 01:10:39 -0700 (PDT)
Received: from ?IPv6:2601:641:0:401e:810:afe4:3cc5:7837?
 ([2601:641:0:401e:810:afe4:3cc5:7837])
 by smtp.gmail.com with ESMTPSA id tm1sm16282718pac.23.2016.09.11.01.10.36
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 11 Sep 2016 01:10:37 -0700 (PDT)
In-Reply-To: <a4d1eb45-30cf-48d4-cd40-93cd0b8cfdf4@gmail.com>
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

This is a multi-part message in MIME format.
--------------19818C908DA1CF85E7121CE9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

I've sent this email to Clemens Ladisch, that appears as the developer
of the snd-oxygen driver, but just in case he is not the actual
maintainer of the driver, I'm forwarding it here.

Thanks,

- german


-------- Forwarded Message --------
Subject: 	HT Omega Claro II support
Date: 	Thu, 8 Sep 2016 00:32:36 -0700
From: 	German Gomez <gergomez@gmail.com>
To: 	Clemens Ladisch <clemens@ladisch.de>



Hello,

I've read in the alsa-users mailing-list
(https://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg29284.html)
that there is no support for the HT Omega Claro II card and that you
should have to reverse engineer the windows driver to add it. I have
that soundcard, although I has been able to use the onboard HDA audio
when booting to Linux. But now my onboard audio is not working (it is
dead, not working either under Windows) so I'm trying to make the Claro
II working under Linux. I've contacted the HT Omega support and to my
surprise they actually answered with some useful information. I've
attached the email. The summary is that the Claro II should be exactly
the same as the other cards by HT Omega using the CMI8788 except that
the GPIO for initializing the card is #6.

I have compared specs for both Claro (http://www.htomega.com/claro.html)
and Claro II (http://www.htomega.com/claro2.html), and there are more
differences, the Claro uses AK4396VF and WM8785G chips while the Claro
II uses AK4396VF and CS4362 (+ CS5361 for line input). I've checked the
code under sound/pci/oxygen and it seems that we have support for the
CS4362 for the Xonar D1/DX soundcard. I don't know if having the GPIO
pin for initialization and all the other chips already there is enough
to add support, of course I'm willing to test any patch that you could
provide. I've taken a look at the code, as I'm not bad with C, but audio
driver development is completely outside my skills and domain, so I'm
quite lost, if you don't have time or if it is not trivial to add
support for the Claro II I would understand it, but the card is a really
good one and it is quite easy to find in the US, it would be awesome to
have support for it in ALSA.

Thank you for your time!

- german*
*

--------------19818C908DA1CF85E7121CE9
Content-Type: message/rfc822;
 name="Re: HT Omega Claro II Linux support (German ).eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Re: HT Omega Claro II Linux support (German ).eml"

Delivered-To: gergomez@gmail.com
Received: by 10.202.242.139 with SMTP id q133csp550711oih;
        Wed, 7 Sep 2016 15:48:13 -0700 (PDT)
X-Received: by 10.98.63.193 with SMTP id z62mr37666866pfj.131.1473288493852;
        Wed, 07 Sep 2016 15:48:13 -0700 (PDT)
Return-Path: <laputa@htomega.com>
Received: from hw-fwd1.mailplug.co.kr (hw-fwd.mailplug.co.kr. [121.78.227.188])
        by mx.google.com with ESMTPS id tq7si8852152pab.0.2016.09.07.15.48.12
        for <gergomez@gmail.com>
        (version=TLS1_1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 15:48:13 -0700 (PDT)
Received-SPF: neutral (google.com: 121.78.227.188 is neither permitted nor denied by best guess record for domain of laputa@htomega.com) client-ip=121.78.227.188;
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 121.78.227.188 is neither permitted nor denied by best guess record for domain of laputa@htomega.com) smtp.mailfrom=laputa@htomega.com
Received: (qmail 17298 invoked from network); 8 Sep 2016 07:48:11 +0900
Received: from m188.mailplug.co.kr (121.156.118.88)
	by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
	8 Sep 2016 07:48:11 +0900
Received: (qmail 21483 invoked from network); 8 Sep 2016 07:48:11 +0900
Received: from unknown (HELO HTOMEGAPC) (laputa@htomega.com@1.11.201.123)
	by 0 (qmail 1.03 + mailplug 2.0) with SMTP;
	8 Sep 2016 07:48:11 +0900
From: "Jason-HTOMEGA" <laputa@htomega.com>
To: "'German Gomez'" <gergomez@gmail.com>
References: <b6190feb-2209-653a-2f92-71bd950880d8@gmail.com>
In-Reply-To: <b6190feb-2209-653a-2f92-71bd950880d8@gmail.com>
Subject: RE: HT Omega Claro II Linux support (German )
Date: Wed, 7 Sep 2016 15:48:10 -0700
Message-ID: <000601d20959$e88d0120$b9a70360$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
thread-index: AdIIKIA3vccDmlIqTbS7+alvDioXvwAxsxIA
Content-Language: ko

Dear German Gomez

I'm sorry for this issue.=20

8788 has no official driver for Linux. This is Cmedia policy.  And we =
have no information about driver side.=20
Cmedia doesn't share about driver information with any hardware =
manufactories. =20
Thank you for your understanding. =20

But there is one information. If the other 8788 cards are working =
properly, Claro II isn't different except GPIO initializing. =20
Claro II uses GPIO #6 for initializing.  But we don't know how it is =
working.  I think the developer has some idea.=20

By the way, we still recommend Windows system for using full feature of =
Claro II.=20
Feel free to contact me with any question.

Thank you.
Sincerely,
Jason.
HT OMEGA  =20



-----Original Message-----
From: German Gomez [mailto:gergomez@gmail.com]=20
Sent: Tuesday, September 6, 2016 3:22 AM
To: help@htomega.com
Subject: HT Omega Claro II Linux support

Hello,

I'm trying to use the HT Omega Claro II under Linux (Ubuntu 16.04), but =
I've found that it is one of the few cards from HT Omega that is not =
supported by the Linux Sound System, ALSA =
(http://www.alsa-project.org/main/index.php/Matrix:Vendor-HT_Omega).

According to the developer of the CMI8788 driver it seems that the =
information to support it is not available:

https://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg29284.htm=
l

Is there anyway to provide that information to the developer, so he =
would be able to add support to this awesome card to Linux? As I was =
searching for a solution, I've found that there are many other users =
like me looking for support under Linux.

Thanks!

- german




--------------19818C908DA1CF85E7121CE9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------19818C908DA1CF85E7121CE9--
