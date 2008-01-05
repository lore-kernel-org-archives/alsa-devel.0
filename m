From: "Norayr Chilingaryan" <gnorayr@gmail.com>
Subject: fujitsu siemens amilo la 1703 vt1807 hda intel card
	problem
Date: Sat, 5 Jan 2008 02:48:14 +0100
Message-ID: <f5976be10801041748j5271c4eas8a6b2d2851b4a838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C78C2447F
	for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2008 02:48:16 +0100 (CET)
Received: by hs-out-2122.google.com with SMTP id l65so4851052hsc.0
	for <alsa-devel@alsa-project.org>; Fri, 04 Jan 2008 17:48:15 -0800 (PST)
Content-Disposition: inline
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

Hello
I decided to write here, firtly, because my messages in aksa-user have been
ingored, and secondly, because I understood that my card most probably just
unsupported and I must contact developers.

I have tried to pass options model=fujitsu, because I have a fujitsu
siements notebook etc
I have also tried to pass amny other options in /etc/modules.d/alsa but
withnot effect
I use gentoo, and the only thing I noticed with latest kernels and alsa
drivers 1.0.15 is that I can hear sound through  the headphones, but with
low volume.
It is not possible to get volume higher or speaker to make sounds now.

So, please, this is information about the card

04:01.0 Audio device: VIA Technologies, Inc. VIA High Definition Audio
Controller (rev 10)

kakraphoon ~ # cat /proc/asound/card0/codec#* | grep Codec
Codec: VIA VIA VT1708
Codec: Motorola Si3054


Thank you very much

Norayr
