From: "John W. Linville" <linville@tuxdriver.com>
Subject: [patch 2.6.14-rc2 0/3] HD audio realtek codec fixes
Date: Wed, 28 Sep 2005 17:50:52 -0400
Message-ID: <09282005175052.10882__6459.14709098196$1127944714$gmane$org@bilbo.tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5B137163
	for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2005 23:53:57 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: perex@suse.cz, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Some simple fixes in patch_realtek.c.

	-- Fix the "sex" of the ALC260 "Mono Playback Switch"

	-- Fix a type in alc880_test_mixer

	-- Fix the "sex" of the ALC882 "LFE Playback Switch"

The last one is speculative based on the datasheet and experience with
the ALC260.  Anyone with ALC882 hardware is invited to test and
confirm.

Patches to follow...


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
