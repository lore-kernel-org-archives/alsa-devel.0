From: Daniel Case <danielcase10@googlemail.com>
Subject: Alsa Problems - O2 Joggler
Date: Thu, 8 Apr 2010 21:23:51 +0100
Message-ID: <y2g2410b0d51004081323y2096cce3x3698bf11749879cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CE9A103979
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 22:24:13 +0200 (CEST)
Received: by wyf19 with SMTP id 19so156102wyf.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Apr 2010 13:24:11 -0700 (PDT)
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

Hi All,
I have an O2 Joggler with the alsa-info output file located here:
http://alsa-project.org/db/?f=4012bb42964e3c87ae7ff4e0561d9ee9d3eb5e2c

The sound does not work unless I remove the following line from
/etc/modprobe.d/alsa-base.conf

    # Power down HDA controllers after 10 idle seconds
   options snd-hda-intel power_save=10 power_save_controller=N

I believe this means that the chipset is not able to wake up from
power saving, and what I get is crackling sound.

What can be done so that this issue is fixed (the device works with
power saving)?

The device came with a special version of Ubuntu Linux 8.04, and the
source code (included Alsa) is available at
http://lists.gpl-violations.org/pipermail/legal/2009-December/001755.html

Thanks!

-- 
~Daniel
