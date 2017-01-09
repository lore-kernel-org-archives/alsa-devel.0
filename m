From: Gustavo Duarte <gus.duarte@gmail.com>
Subject: Input sound doesn't work without power
Date: Mon, 9 Jan 2017 14:02:21 -0300
Message-ID: <CACV5_BVmyUNMa_z3=xYFmgYr=nRd_TUx4Pkr0Ytz_L+B+mG9yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id D60B126687D
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 18:02:24 +0100 (CET)
Received: by mail-wm0-f47.google.com with SMTP id c206so40128206wme.0
 for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2017 09:02:24 -0800 (PST)
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

Hi all,

We are facing a problem with audio intput (mic), on a laptop with sound
device ALC283.

When the laptop boots connected to power line, all works fine.

When the laptop boots without power line connection, sound input doesn't
work. No audio can be recorder, using arecord or qarecord.

I got the output of "arecord -l" comand in each case. Follwoing are the
results.

With power line connection:

**** Lista de CAPTURE dispositivos hardware ****
tarjeta 0: PCH [HDA Intel PCH], dispositivo 0: ALC283 Analog [ALC283 Analog]
  Subdispositivos: 1/1
  Subdispositivo #0: subdevice #0



Without power line connection:

**** Lista de CAPTURE dispositivos hardware ****
tarjeta 0: PCH [HDA Intel PCH], dispositivo 0: ALC283 Analog [ALC283 Analog]
  Subdispositivos: 0/1
  Subdispositivo #0: subdevice #0


As yo can see, the difference is on, Subdispositivos :1/1 (with power line)
and Subdispositivos: 0/1 without power line.

Anybody can help me resolve this ?
Do you need some additional info ?

Thanks advance.
