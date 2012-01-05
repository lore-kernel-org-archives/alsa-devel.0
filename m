From: Joerg-Cyril.Hoehle@t-systems.com
Subject: how to enumerate useful ALSA devices?
Date: Thu, 5 Jan 2012 10:59:01 +0100
Message-ID: <8E4C156DA5797D418DBFADFD8CE655A41782620646@HE113481.emea1.cds.t-internal.com>
References: <20120104194956.GB9868@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tcmail83.telekom.de (tcmail83.telekom.de [62.225.183.131])
	by alsa0.perex.cz (Postfix) with ESMTP id C09282459B
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 10:59:04 +0100 (CET)
In-Reply-To: <20120104194956.GB9868@foghorn.codeweavers.com>
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: aeikum@codeweavers.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Andrew Eikum wrote:
>I tried experimenting with snd_device_name_hint().
>surround40:CARD=3DSB,DEV=3D0
>surround41:CARD=3DSB,DEV=3D0
>surround50:CARD=3DSB,DEV=3D0
>surround51:CARD=3DSB,DEV=3D0
>surround71:CARD=3DSB,DEV=3D0
I'm not sure Wine should enumerate these.  How can it tell the difference
so as to announce the correct channel mapping to applications?
E.g. 41 vs 50, both 5 channels? Ideally, that should be announced as
one device (as it really is), capable of supporting different formats,
with one preferred format (perhaps the one with most channels) that GetMixF=
ormat uses.

OTOH, I find it important that Wine announces a device capable of more
than stereo if there's one in the system.

Regards,
 J=F6rg H=F6hle
