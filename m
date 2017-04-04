From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: HDA Intel ALC889A optical spdif input on MacBooks
Date: Wed, 5 Apr 2017 00:02:59 +0200
Message-ID: <4D425EDE-3FF5-4895-B469-58977B887FAC@exactcode.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C508266F05
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 00:03:12 +0200 (CEST)
Received: from [90.187.5.221] (helo=exactcode.com)
 by mx.exactcode.de with esmtp (Exim 4.82)
 (envelope-from <rene@exactcode.de>) id 1cvWY5-0002Wn-Iq
 for alsa-devel@alsa-project.org; Tue, 04 Apr 2017 22:03:37 +0000
Received: from [91.64.25.202] (helo=[192.168.0.15])
 by exactcode.com with esmtpsa (TLSv1:AES128-SHA:128) (Exim 4.54)
 id 1cvWXZ-0004y9-3S
 for alsa-devel@alsa-project.org; Tue, 04 Apr 2017 22:03:11 +0000
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

Hi,

recently I wanted to connect my low noise mic pre-amp via optical spdif to =
a spare "10 year=94 old MacBook or MacBookPro.
Those indeed have a optical input in the 3.5mm headphone jack. On macOS thi=
s also works and works as expected.

On Linux, however, no matter what I do I only get zeros when recording the =
-D iec958.

In /proc I see 3 capture sub-devices, where the 2nd is labeled:

# cat /proc/asound/card0/pcm1c/info =

...
id: ALC889A Digital
name: ALC889A Digital
...

The behavior is the same on booth the MacBook as well as the MacBook Pro wi=
th either of those PCI devices:

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definitio=
n Audio Controller (rev 02)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Contr=
oller (rev 03)

I have the feeling there could be some auto sensing be involved, as in the =
macOS system preferences I see the input switching from Mic to Optical Inpu=
t as soon as I plugin in an active fibre.

As I=92m not familiar with this Intel HD stuff, any hint how to start analy=
zing and poking this mystery would be highly appreciated.

Best regards,
	Ren=E9

-- =

 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de
