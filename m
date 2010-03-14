From: Pavel Machek <pavel@ucw.cz>
Subject: 2.6.34-rc1: regression: ^Z no longer stops sound
Date: Sun, 14 Mar 2010 08:58:31 +0100
Message-ID: <20100314075831.GA13457@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (ksp.mff.cuni.cz [195.113.26.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A7FC1037EE
	for <alsa-devel@alsa-project.org>; Sun, 14 Mar 2010 08:58:38 +0100 (CET)
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
To: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: alsa-devel@alsa-project.org

Hi!

In 2.6.33, hitting ^Z stopped mpg123 in a way you'd expect (both on
thinkpad and geode notebook).

On 2.6.34-rc1, hit ^Z and sound starts looping.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
