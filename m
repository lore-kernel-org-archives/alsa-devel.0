From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ALSA: hdmi: expose ELD control
Date: Tue, 27 Sep 2011 10:48:39 -0500
Message-ID: <3779.17667287893$1317138555@news.gmane.org>
References: <1317077323-3600-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<s5hhb3ye801.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id AE0CE24453
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 17:48:49 +0200 (CEST)
In-Reply-To: <s5hhb3ye801.wl%tiwai@suse.de>
Content-language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for your review Takashi!

> Wouldn't it be better to strip the buffer data and size in the error
> case?  For example, radeon driver gives often size=0.  Then it's
> translated as size=128 for a workaround, then again handled as an
> error by checking the version.

Yes, I wasn't sure what to do here and expected some comments. Should the
strategy be that if there's a single error we discard the entire ELD by
setting the size to zero?
No issues for the other changes. 

> Set the access field to SNDRV_CTL_ELEM_ACCESS_READ.
> Also, unless we implement a notification, better to set
> SNDRV_CTL_ELEM_ACCESS_VOLATILE flag, too.

The intent was to read the ELD after the device is opened, I don't think the
ELD can change during playback, the updates can only happen on a pin-sensing
event. I can't think of a good reason why a notification would be needed?
-Pierre
