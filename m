From: Eliot Blennerhassett <linux@audioscience.com>
Subject: aplay -l messes up terminal settings.
Date: Wed, 18 Aug 2010 13:48:07 +1200
Message-ID: <4C6B3BD7.2070206@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id C69E6244DF
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 03:48:35 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0L7B00IGYRO7WY20@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 18 Aug 2010 13:48:08 +1200 (NZST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

there is something wrong with the last commit to aplay (at least for me
Gnome terminal 2.29.6).

When I do aplay -l or aplay -L,  my keystrokes are subsequently not
echoed in the terminal.

regards

Eliot

73c79ebf26a51a2d9b582a4cae82867873875743 is the first bad commit
commit 73c79ebf26a51a2d9b582a4cae82867873875743
Author: Jaroslav Kysela <perex@perex.cz>
Date:   Thu Jul 15 13:39:14 2010 +0200

    aplay: fix termio settings - return back old c_flag value on exit

    - symptom - ssh client password authentication does not work with
      the modified terminal settings

    Signed-off-by: Jaroslav Kysela <perex@perex.cz>

:040000 040000 f7624e3b40c38f4bb2ae450b5e94ec938ffddc90
33ffa7e2c1729c6e738db25f68deb843a8a67245 M	aplay

-- 
Eliot Blennerhassett
AudioScience Inc.
