From: =?ISO-8859-1?Q?Guillem_Sol=E0?= <garanda@flumotion.com>
Subject: Issue with creative Xfi PCIe ca0110-IBG
Date: Fri, 09 Oct 2009 11:19:04 +0200
Message-ID: <4ACF0008.5010808@flumotion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.fluendo.com (se01.bcn.fluendo.net [195.10.10.21])
	by alsa0.perex.cz (Postfix) with ESMTP id E5D27103933
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 11:23:31 +0200 (CEST)
Received: from mail.fluendo.com (localhost.localdomain [127.0.0.1])
	by mail.fluendo.com (Postfix) with ESMTP id 665D225015E
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 11:21:48 +0200 (CEST)
Received: from [192.168.3.102] (o.bcn.fluendo.net [195.10.10.180])
	by mail.fluendo.com (Postfix) with ESMTP id BB922250178
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 11:20:01 +0200 (CEST)
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

Hi,

I have a Creative XFi PCIe with ca0110-IBG chip. It's primary use is =

audio input for streaming on a brand new Dell server with RHEL. I have =

been testing latest kernel 2.6.31 through it's releases candidates and =

the card stoped working on 2.6.31-rc6, so now I'm stuck at 2.6.31-rc5. =

With rc5 I made a 2 weeks test and it went flawlessly.

There's another guy who referenced this issue on =

http://mailman.alsa-project.org/pipermail/alsa-devel/2009-September/020876.=
html =

and Takashi Iwai said that there is a communication error between the =

codec and the controller.

Any workaround? Is there a bug created related to this issue?

I tried to "extract" the alsa-driver on 2.6.31-rc5 and install it 2.6.31 =

final without success. Also tried to get old snapshots from alsa-driver =

and alsa-kmirror but I cannot compile them. Any place where get some =

info about how to create

my output from alsa-info:

http://www.alsa-project.org/db/?f=3D09087914dfdd85a07dca432cf71a9626b4fc4251

regards,

Guillem Sol=E0
