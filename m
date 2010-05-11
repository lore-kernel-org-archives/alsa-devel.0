From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd-hda-intel - wallclk patch
Date: Tue, 11 May 2010 10:44:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005111041380.6856@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.1005101849490.6856@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.1005111028110.6856@eeebox2.perex-int.cz>
	<s5hzl06q1cm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 477FC245C7
	for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 10:44:18 +0200 (CEST)
In-Reply-To: <s5hzl06q1cm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 11 May 2010, Takashi Iwai wrote:

> At Tue, 11 May 2010 10:28:50 +0200 (CEST),
> Jaroslav Kysela wrote:
>>
>> On Mon, 10 May 2010, Jaroslav Kysela wrote:
>>
>>> Hi,
>>>
>>> 	I would like to ask HDA gurus to check this patch (I will include it
>>> to my tree once acked). The patch uses WALLCLK from HDA chips (marked as
>>> required in the HDA specification) to check for bogus - too early - interrups
>>> which confuses the upper PCM layer (sound skipping issues).
>>>
>>> 	More details about patch testing on problematic hardware can be found
>>> at:
>>>
>>> 	https://bugzilla.kernel.org/show_bug.cgi?id=15912
>>
>> No objections received, so I pushed this code to my master/devel branches.
>
> Heh, that was quick, I had no time to review :)
>
> The change looks good to me.  Thanks for your fix (and rebasing).
>
> One thing is that you removed bdl_pos_adj=0 check.  This was there
> explicitly to avoid the delayed irq handling no matter whether the
> value is correct or not.  I guess it's safer to take it back, or
> give any other way for user to avoid the delayed irq handling.

I see. But I need the pos % period_bytes check too. What about this 
change?

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0a6c55b..6674841 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1910,9 +1910,11 @@ static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)

  	if (WARN_ONCE(!azx_dev->period_bytes,
  		      "hda-intel: zero azx_dev->period_bytes"))
-		return 0; /* this shouldn't happen! */
+		/* this shouldn't happen! */
+		return bdl_pos_adj[chip->dev_index] ? 0 : -1;
  	if (pos % azx_dev->period_bytes > azx_dev->period_bytes / 2)
-		return 0; /* NG - it's below the period boundary */
+		/* NG - it's below the period boundary */
+		return bdl_pos_adj[chip->dev_index] ? 0 : -1;
  	azx_dev->start_wallclk = wallclk;
  	return 1; /* OK, it's fine */
  }

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
