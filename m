From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 00/44 v3] Enhancement of support for
 Firewire devices
Date: Thu, 03 Apr 2014 21:17:27 +0200
Message-ID: <533DB3C7.5010507@canonical.com>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D03AF2656B9
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 21:17:33 +0200 (CEST)
In-Reply-To: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On 03/21/2014 12:09 PM, Takashi Sakamoto wrote:
> This series is an update for my previous series:
> [alsa-devel] [GIT PULL][PATCH 00/39 v2] Enhancement of support for Firewire
> devices
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073868.html

Hi,

I've tested Takashi's patches [1] with my one Firewire device (Presonus
FP10) and I've found it to work well, both midi and audio.
In addition, during my testing I've found Takashi Sakamoto to be very
good to work with, and I'm confident he will continue to look after the
driver for some time ahead.

While I haven't looked through the patches in detail - after all, the
firewire stack is not really my point of expertise (yet!) - but from a
pragmatic view, having ALSA kernel support for firewire devices is a
very welcome addition. (Although a late one, considering firewire's
declining popularity.)

While not everything is perfect yet - e g PulseAudio and Audacity are
two applications that would require some coding on either end to
facilitate better integration - no driver is ever perfect, and the
current driver is a big step in the right direction.

To sum up, from my pragmatic view I've found the patch series [1] to be
stable enough to mainline, and I recommend merging this patch series for
the 3.15 kernel merge window.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] Not actually this patch series, but a later version of these
patches, as can be found in Takashi Sakamoto's github tree.
