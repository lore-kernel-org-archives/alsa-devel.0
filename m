From: Janne Himanka <janne.himanka@iki.fi>
Subject: Recent ALSA version needs special configuration for
 Terratec Phase 26 USB
Date: Wed, 17 Oct 2007 09:34:43 +0300
Message-ID: <87d4ve5jwc.fsf@waghdas.discendum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ghadis.discendum.com (ghadis.discendum.com [194.100.45.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 48A352434F
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 08:34:51 +0200 (CEST)
Received: from waghdas.discendum.com (waghdas.discendum.com
	[IPv6:2001:6e8:2001:5:250:daff:fe47:36dc] (may be forged))
	by ghadis.discendum.com (8.14.0/8.13.4) with ESMTP id l9H6YnM0017310
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 09:34:49 +0300 (EEST)
Received: from waghdas.discendum.com (shem@localhost [127.0.0.1])
	by waghdas.discendum.com (8.14.1/8.14.1/Debian-10) with ESMTP id
	l9H6YiQ1014593
	for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2007 09:34:44 +0300
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

Hello,

I run Debian unstable on my Athlon XP1800 machine, and updating
libasound2 package from version 1.0.13-2 to 1.0.14 (and later) made my
Terratec Phase 26 USB soundcard useless. Whenever I tried to play
something, the program would crash with a segmentation fault. When I
downgraded to 1.0.13, everything would work again. 

It took a lot of head scratching and experimentation to find out that
adding 

cards.USB-Audio.pcm.use_dmix."USB2448" no

to my .asoundrc (it is otherwise empty) is needed for it to
work. After adding that, it seems to work as it did before. The string
in hyphens varies according to the mode one selects from the Terratec
front panel. There are four modes with different word length and
bitrates. The Phase 26 is adaptive; it doesn't need converting for a
specific  format. Bitrates from 32 KHz to 96 KHz and word lengths from
16 to 32 bits just work. 

I'm writing you this because a comment in USB-Audio.conf says:

#  If your device requires such a definition to work correctly, please report it
#  to <alsa-devel@alsa-project.org>.

If you need any additional info, I'll be glad to help.


Regards,
Janne Himanka
