From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA Power management.
Date: Tue, 05 Aug 2008 15:13:36 -0700
Message-ID: <1217974416.11773.127.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 6880124652
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Aug 2008 00:13:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Ok, I've been studying the code for a couple of weeks now, and testing
on a mobile type development platform with a Realtek ALC262, but I have
not been able to get the audio codec to enter low power mode (D3).  I
can see it switch when running that other OS.  When running, the chip
draws ~400mw, but drops to 40mw after switching to low power mode.  How
do I get it to do the same with the current driver?  I'm using the git
tip for alsa, and 2.6.26 final kernel.

I have tried setting the power mode to D3 using the hda-tool from
Takashi, but the codec reverts to D0 (full power) after a second or two,
even though there is nothing touching the audio in my test environment.

-- 
Tobin Davis 


The beauty of a pun is in the "Oy!" of the beholder.
