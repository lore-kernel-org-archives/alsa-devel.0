From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: 2.6.26.[6|7] vs. rt11 vs. alsa (usb) midi
Date: Sat, 25 Oct 2008 19:46:27 -0700
Message-ID: <1224989187.3706.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.stanford.edu (smtp2.Stanford.EDU [171.67.20.25])
	by alsa0.perex.cz (Postfix) with ESMTP id CAAAA24413
	for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2008 03:52:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
List-Id: alsa-devel@alsa-project.org

Hi... anyone out there also having problem with this combination?
   2.6.26.7 or 2.6.26.6 with 2.6.26.6-rt11 and alsa MIDI
It looks to me like alsa midi is broken. 

Probably an interaction with the realtime kernel patch. A Fedora kernel
based on 2.6.26.6 (2.6.26.6-49 on fc8) works fine, a very similarly
patched kernel that includes the realtime patch does not. The
configurations for both are almost the same (today I tried to change
some of the most obvious differences and rebuild, with the same
result). 

No problems with 2.6.24.7-rt21. 

Test: boot, login, plugin an external usb keyboard (Yamaha P250), it is
recognized, use qjackctl alsa patchbay to connect it to kmidimon,
kmidimon sees only _one_ midi message and that's it. Kmidimon can't be
killed after that. 

-- Fernando
