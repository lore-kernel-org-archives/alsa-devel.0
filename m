From: "Daniel Vogel" <dvogel@go-engineering.de>
Subject: AD1981B SoundMax
Date: Thu, 23 Apr 2009 10:09:56 +0200
Message-ID: <000001c9c3ea$e3cbaef0$ab630cd0$@de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2045_4576643.1240474204189"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from go-engineering.de (mail.merkur-elektronik.de [89.244.128.23])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B04B10383F
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 10:10:05 +0200 (CEST)
Received: from unknown (HELO ipex-go.ra.go-engineering.de) ([127.0.0.1])
	(envelope-sender <dvogel@go-engineering.de>)
	by localhost.uu.net (qmail-ldap-1.03) with SMTP
	for <alsa-devel@alsa-project.org>; 23 Apr 2009 08:10:04 -0000
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

------=_Part_2045_4576643.1240474204189
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Developers,

sorry if this question is off topic on this list, but I don't know where
else to send the question to.=20

I'm currently developing an audio-application on an ARM board that is
equipped with an AD1981B SoundMax chip. Everything works well except the
build-in equalizer. Since it is impossible to get usable technical
information from Analog-Device my last hope is to find someone on this list
who has some experience with the chip in question.

My problem started with the datasheet not telling the format of the fixed
point numbers for biquad coefficients. It only states that they are 16 bit
numbers with 16 bit resolution...

Then, when I use an estimated value for a0 that is unequal from zero and al=
l
other coefficients are zero, in theory I should hear some sound when I play
a PCM file (44.1kHz / 16Bit) . But there is only silence on the output when
the equalizer is not muted. Is there something else I have to set up to mak=
e
the equalizer output pass through?

Looking forward for answers. ;-)

Thanks in advance!
Daniel




GO Engineering GmbH - Stolzenbergstr. 13/IV - 76532 Baden-Baden
Gesch=E4ftsf=FChrer:
Helmut Gerstner, Dipl.-Ing. (FH)
Ralf W=F6rner, Dipl.-Ing. (FH)
Registergericht: Mannheim HRB 201811
------=_Part_2045_4576643.1240474204189
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_2045_4576643.1240474204189--
