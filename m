From: Martin Kepplinger <martink@posteo.de>
Subject: [BUG] [REGRESSION] [BISECTED] -rc1 breaks audio over
	HDMI for i915
Date: Tue, 9 Feb 2016 07:34:48 +0100
Message-ID: <56B98888.5000702@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7153A261548
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2016 07:36:20 +0100 (CET)
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
 by mout01.posteo.de (Postfix) with ESMTPS id DF80320989
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2016 07:36:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, treding@nvidia.com, david.henningsson@canonical.com, libin.yang@intel.com, han.lu@intel.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The following change:

788d441 ALSA: hda - Use component ops for i915 HDMI/DP audio jack handling

breaks audio over HDMI on my snd_hda_intel laptop. It is the first bad
commit.

This was merged for -rc1 and isn't fixed until now, so I got nervous.
There are
no errors in the log that stand out. I'm no sound or alsa developer, and
just reverting it isn't easy since there is stuff depending on this.

I'm happy to test possible fixes and hope v4.5 not to ship with such a big
regression ;)
