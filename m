From: Fidel Leon <fidelleon@mykolab.com>
Subject: No sound for a rather old laptop (ALC260).
Date: Mon, 05 May 2014 16:34:38 +0200
Message-ID: <4533148.LqRjaVltA6@lillinux.fidelleon.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx03.mykolab.com (mx01.mykolab.com [95.128.36.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B49A2608E8
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 16:34:45 +0200 (CEST)
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

Hello, list.

I own a rather old laptop which features a snd_hda_intel soundcard, with a 
ALC260 chipset.

I know it works when using rather old kernels (Debian 7, for example), and 
when I was using Ubuntu 12.04 I could even download the "driver" from Realtek 
and compile from sources. However, after updating to newer releases (kernels 
3.9 and beyond), I lost the ability to compile the module by hand (VERSION.H 
missing).

For older kernels I could try some "model=xxx" combinations but as far as I 
see from hda_codec.c, ALC260 doesn't feature such parameter anymore (N/A).

When my laptop starts up it make a few clicks and cracks (just when my Fedora 
initializes the module) but no sound afterwards. I have cranked every 
alsamixer slider to maximum but the most I get is a "very far far away sound, 
with a lot of skews and clicks).

I already have an alsa-info.txt file to debug, may I post it here?

Thanks,
-- 
Fidel Leon
fidelleon@mykolab.com
GPG: AD74FB97
"Developers have the attention spans of slightly moronic woodland creatures."
