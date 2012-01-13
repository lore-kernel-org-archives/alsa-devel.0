From: Ivan Bublikov <ivanbublikov@yahoo.com>
Subject: Re: Hardware-specific IOCTLs
Date: Fri, 13 Jan 2012 14:45:46 -0800 (PST)
Message-ID: <1326494746.63666.YahooMailNeo@web121805.mail.ne1.yahoo.com>
References: <1326471758.45923.YahooMailNeo@web121806.mail.ne1.yahoo.com>
	<4F106A66.4080803@ladisch.de>
Reply-To: Ivan Bublikov <ivanbublikov@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm38-vm1.bullet.mail.ne1.yahoo.com
	(nm38-vm1.bullet.mail.ne1.yahoo.com [98.138.229.145])
	by alsa0.perex.cz (Postfix) with SMTP id 9B9B524402
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 23:45:48 +0100 (CET)
In-Reply-To: <4F106A66.4080803@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> From: Clemens Ladisch <clemens@ladisch.de>
> =

> Ivan Bublikov wrote:
>> As an HDA codec vendor, I want to be able to control some functionality
>> in my codec, that is not present in codecs from other vendors.=A0 [...]
>> I can register an IOCTL handler using snd_ctl_register_ioctl.
> =

> This functions is for ioctl calls on the ctl device, which is global
> for one sound card and is not appropriate if one wants to address
> something like a PCM device or a codec.
> =

> For a HDA codec, use a hwdep device.

OK, I understand I simply need to add a new case in hda_hwdep_ioctl().

>> My difficulty is how to define a code for my IOCTL and avoid
>> a conflict with the common code in the future.
> =

> Pick something not yet allocated in Documentation/ioctl/ioctl-number.txt.

Since half of the=A0lines in it are marked "Conflict!" anyway, should I onl=
y pay attention to not conflict with "sound/*" lines?=A0 And then add a new=
 line for my IOCTLs? And should I put my IOCTL definitions in hda_hwdep.h o=
r create a new file?
