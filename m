From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: snd-aloop: make preallocated
	buffer	size	configurable
Date: Wed, 21 Sep 2011 08:26:27 -0500
Message-ID: <39174.066638998$1316611608@news.gmane.org>
References: <1316545332-2229-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<s5hzkhygkpe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 636FE103ACC
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 15:26:35 +0200 (CEST)
In-Reply-To: <s5hzkhygkpe.wl%tiwai@suse.de>
Content-Language: en-us
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

> > Default of 2MB of physically-contiguous memory can be
> > too high for embedded solutions, make the size configurable.
> 
> Hm, maybe better to have an option for global limit of preallocation?
> The problem is not necessarily specific to snd-aloop.

Not sure I understand the comment. This code is essentially the same as the
configuration option for HDAudio, and the parameter value defines the amount
of preallocated memory, with a limit to 32MB.
-Pierre
