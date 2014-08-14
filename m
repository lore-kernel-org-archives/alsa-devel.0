From: =?iso-8859-1?Q?Carpon_fr=E9d=E9ric?= <frederic.carpon@yahoo.fr>
Subject: A Minimal Playback Program does't work on my system
Date: Thu, 14 Aug 2014 17:42:03 +0100
Message-ID: <1408034523.99775.YahooMailNeo@web171303.mail.ir2.yahoo.com>
Reply-To: =?iso-8859-1?Q?Carpon_fr=E9d=E9ric?= <frederic.carpon@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm27-vm7.bullet.mail.ir2.yahoo.com
 (nm27-vm7.bullet.mail.ir2.yahoo.com [212.82.97.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 42E6E261737
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 18:42:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I am new=A0

System : Raspberry
Linux: ArchLinuxArm

I would like to run this exemple of=A0A Minimal Playback Program from here =
:=A0Howto use the ALSA API
from the page=A0Tutorials for application developers=A0but there is a bug :
i have done
> pacman -sy
> pacman -s alsa-utils
=A0to install the last alas-utils
done gcc exemple.c -lasound (warning comes)
and ./a.out my_file.wav=A0
and the result is :
"AlSA lib pcm.2239:(and_pcm_open_noupdate) Unknown PCM=A0my_file.wav=A0"
cannot open audio device=A0my_file.wav (No such file or directory)


Can you help me please ?
