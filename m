From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: hda-intel and runtime power-management
Date: Mon, 15 Aug 2011 16:04:46 -0500
Message-ID: <33775.6910747432$1313442318@news.gmane.org>
References: <CAJ_JQ2XYhyDasRfq_ksV4P6eOneDN3r8wOsm0NHweB9CnzcRNA@mail.gmail.com>	<s5hipqm8opv.wl%tiwai@suse.de>	<CAJ_JQ2XH09hXhkvhyomAP+OdvXsvZ1zf1f3zK_P=HL4J6GhJwA@mail.gmail.com>	<s5hipq99mvp.wl%tiwai@suse.de>	<CAJ_JQ2WVmCOwAonHLp2Hsn9dOm5YLpdg2aspr2kbUvBnzpJ4PQ@mail.gmail.com>	<s5hei0wa0w8.wl%tiwai@suse.de>	<CAJ_JQ2VWb2ANvz6HFvZBfdzchi6EM1MNuRMZ3K8HEppVAOVuVg@mail.gmail.com>	<s5h8vr09sir.wl%tiwai@suse.de>
	<CAJ_JQ2UgBiw8W8iSWc8rWevDXhzN3aUGvLYAEau=qOnb8t6NoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id D38432435B
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 23:04:52 +0200 (CEST)
In-Reply-To: <CAJ_JQ2UgBiw8W8iSWc8rWevDXhzN3aUGvLYAEau=qOnb8t6NoA@mail.gmail.com>
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
To: "'Tatulea, Dragos'" <dragos.tatulea@intel.com>, 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Another approach would be to set the stream to mute when paused and let
> the codec do the amp power check which will power it down if needed.
> What do you think?

PulseAudio and other equivalent layers don't pause the output. They close
the ALSA sink after a timeout and reopen it when the sink/Hal state change.
You may want to avoid working your tail off with a seemingly smart way of
using the paused state, if in the end it's not that useful...
My 2 cents,
-Pierre
