From: "Tatulea, Dragos" <dragos.tatulea@intel.com>
Subject: hda-intel and runtime power-management
Date: Thu, 28 Jul 2011 17:21:06 +0300
Message-ID: <CAJ_JQ2XYhyDasRfq_ksV4P6eOneDN3r8wOsm0NHweB9CnzcRNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id A028210380B
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jul 2011 16:21:11 +0200 (CEST)
Received: by gxk10 with SMTP id 10so3568157gxk.25
	for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2011 07:21:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm in the process of enabling pm runtime pm for the hda_intel driver,
not being sure if this is a sane task :). Noticed that
CONFIG_SND_HDA_POWER_SAVE disables codecs and chip when they are not
in use, but the power gain is not noticeable on my hw. On the other
hand, a full suspend (azx_suspend) does save a few hundred mW's.
I am aware that this is hw specific, but I would like to take
advantage of the full suspend. Suspend/resume latency is below jiffy
resolution.

How about a more aggressive scheme?: allow runtime power management
(with azx_suspend/resume as runtime pm ops) to kick in when all
streams are stopped/suspended/paused. And resume upon stream is
start/resume. I don't have enough context into ALSA & sound drivers so
I need a reality check: is this crazy/stupid?

Thanks,
Dragos
