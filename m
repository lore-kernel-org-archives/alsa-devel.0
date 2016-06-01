From: "Maximilian.ammann" <maximilian.ammann@protonmail.com>
Subject: hda-intel: ALC1150 (alc882 patch) produces constant
	noise on line-out port
Date: Wed, 01 Jun 2016 14:23:58 -0400
Message-ID: <yoKfOJh1S4OonX-GbRIW1oPktOpxNEcBF6oFVlgghejI1aKBFg1G7ZKBj5palqjn2_1R4he_tU84DcULd1hJt16YhLDzh-M7vMeZGq-Oj4k=@protonmail.com>
Reply-To: "Maximilian.ammann" <maximilian.ammann@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.protonmail.ch (mail1.protonmail.ch [185.70.40.18])
 by alsa0.perex.cz (Postfix) with ESMTP id B37A82652AC
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 20:23:59 +0200 (CEST)
Received: from mail.protonmail.com (localhost [127.0.0.1])
 by mail1.protonmail.ch (Postfix) with ESMTP id AECFC86400
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 14:23:58 -0400 (EDT)
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

I experienced weird behaviour on my "ASUS MAXIMUS VII RANGER" which has
a realtek soundcard with the ALC1150 codec. The problem is that if the
patch_882 is enabled I get a constant noise on the line-out port.
I started experienced and noticed that when using the generic model the
problem disappeared. Therefore the problem also disappeared when
removing the folowing line in sound/pci/hda/patch_realtek.c:

HDA_CODEC_ENTRY(0x10ec0900, "ALC1150", patch_alc882),

I really would like to know whether this behaviour is expected or how I
(myself) could fix it by creating a patch.

alsa-info.sh output:
Without alc882 patch:
http://www.alsa-project.org/db/?f=3fdf926c64a02273e0e68035eeb94282ca44a
7df
With alc882 patch:
http://www.alsa-project.org/db/?f=336755aab10811bb0af5440dbda7b9cda3d9b
116

Thansk in advance, if possible it would be awesome if you could provide
me some tips since I really would like to fix it myself as my very
first patch.

Max
