From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to cross compile the alsa ?
Date: Thu, 29 Mar 2012 12:11:20 +0200
Message-ID: <4F743548.2030500@ladisch.de>
References: <CAC-Zu+6S4WNnqBf1fjbHAQnXwSOEOPQ4UQGBmd15jsZCvL_UHA@mail.gmail.com>
	<CAC-Zu+6Pb9jjT3-9iTwkQtwRpSd+A6-hsdoBTYFB28vATFbsGA@mail.gmail.com>
	<4F718047.2090405@ladisch.de>
	<CAC-Zu+7ZyJuVRriEW84p4K+TpfmcZo1fRXkDCiQ2AK66kp9r3Q@mail.gmail.com>
	<CAC-Zu+4O8uG=hHHrPaO4mKJatpVbHZqVsBi9vyfMAzRTc3DYWQ@mail.gmail.com>
	<CAC-Zu+55WZfGze3Jk0QNimu+S7jWT1_eDbOs+yVeQOC33PEfzQ@mail.gmail.com>
	<4F719DBF.2060507@ladisch.de>
	<CAC-Zu+55ShwctKwN3bH=efTS_kuPTz_mvo2DVqfoXWhCmpmWqQ@mail.gmail.com>
	<4F71A70A.5050200@ladisch.de>
	<CAC-Zu+7Goe2ROEzSNE1CwmQS-i5n=BMTGc1wQk9J4ay3pAUyBQ@mail.gmail.com>
	<4F71B479.5010408@ladisch.de>
	<CAC-Zu+5OYptjci2+tcoKQq8GZo94bEAqQoxqD0zrmqDYCjcfvQ@mail.gmail.com>
	<CAC-Zu+47SrCzFM_bLDYfahJFXRbxwsboy-Cf5ZM42oSoFXjZ=w@mail.gmail.com>
	<CAC-Zu+4WXgJB-7zcgJ2c6k90rEdVWAjXc1dKh+iKwi5VuPQumQ@mail.gmail.com>
	<CAC-Zu+6S49pR0P_s1k8nLdJHE3pnrkWnhk4fqWOTNxHOCFsAtg@mail.gmail.com>
	<4F74073E.5090300@ladisch.de>
	<CAC-Zu+5pyC9=yYH=CsbY5v_3uEoicwuvka3FoC_rfy==Gz+GdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8FDFB10438F
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 12:08:04 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7999120C3E
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 06:08:01 -0400 (EDT)
In-Reply-To: <CAC-Zu+5pyC9=yYH=CsbY5v_3uEoicwuvka3FoC_rfy==Gz+GdA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?D=E1maso_L=F3pez?= <dlopezsk@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

D=E1maso L=F3pez wrote:
> But not affect this warning?

Unless you're trying to use a plugin not in alsa-lib.

> It can affect how can to fix it?

Don't compile statically.

> And you know how I can get the volume that enters the microphone at the t=
ime?

The volume of the mixer control or the volume of the audio signal?


Regards,
Clemens
