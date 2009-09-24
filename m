From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Is there a way to initialize mixer elements?
Date: Thu, 24 Sep 2009 10:17:50 +0300
Message-ID: <4ABB1D1E.1000300@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id B2F6424400
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 09:13:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

Sometimes specific hardwares needs special tweaks (e.g. a mixer element
is muted by default which avoids getting sound from HP, or the master
volume's gain is very low, etc.). Do we have some kind of quirks
(kernel-space/user-space) for that situations?

As a real-world example, I have a user with a VIA VT1708B codec which is
not able to get sound from HP unless he mutes the 'Independent HP' control:

http://www.alsa-project.org/db/?f=4e7672aee15a64f67286a951e75e4168c6cd43d4

Thanks,
Ozan Caglayan
