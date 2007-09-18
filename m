From: Rene Herman <rene.herman@gmail.com>
Subject: Current ad1848/cs4231 mce_down code
Date: Tue, 18 Sep 2007 02:53:28 +0200
Message-ID: <46EF2188.60704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 702B324351
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 02:54:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Krzysztof Helt <krzysztof.h1@gmail.com>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

By the way, while looking at the current mce_down code:

http://hg.alsa-project.org/alsa-kernel/file/0028e39ead78/isa/ad1848/ad1848_lib.c
http://hg.alsa-project.org/alsa-kernel/file/0028e39ead78/isa/cs423x/cs4231_lib.c

we have the ad1848 loops doing:

end_time = jiffies + msecs_to_jiffies(250);
while (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) {
	spin_unlock_irqrestore(&chip->reg_lock, flags);
(---)
	if (time_after(jiffies, end_time)) {
		snd_printk(KERN_ERR " [ timeout ] ")
		return;
	}
	msleep(1);
	spin_lock_irqsave(&chip->reg_lock, flags);
}

At (---) we are no longer atomic, so imagine being pre-empted there. When we 
get back, we may/will well be past end_time and although by now calibration 
has long finished, we bail out believing we've timed out.

Should it rather be this (probably with a "goto eror" type of setup, but as 
far as the logic is concerned)?

end_time = jiffies + msecs_to_jiffies(250);
while (snd_ad1848_in(chip, AD1848_TEST_INIT) & AD1848_CALIB_IN_PROGRESS) {
	if (time_after(jiffies, end_time)) {
		spin_unlock_irqrestore(&chip->reg_lock, flags);
		snd_printk(KERN_ERR " [ timeout ] ")
		return;
	}
	spin_unlock_irqrestore(&chip->reg_lock, flags);
	msleep(1);
	spin_lock_irqsave(&chip->reg_lock, flags);
}

Moreover, we aren't under lock at all in the cs4231 version (which also 
means that msleep(1) thing is in fact fine there). Can't we do that for 
ad1848 as well?

(but as said, minimal fix for now is the msleep(1) under lock fix in ad1848)

Rene.
