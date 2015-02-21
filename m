From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 0/4] ALSA: fireworks/bebob/dice/oxfw:
	fix	kernel oops at unplugging during streaming
Date: Sun, 22 Feb 2015 00:06:32 +0100
Message-ID: <54E90F78.7040803@ladisch.de>
References: <1424530500-9116-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D1C6E2606B6
 for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2015 00:06:48 +0100 (CET)
In-Reply-To: <1424530500-9116-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> With this patchset, each driver keeps a reference to FireWire unit till
> all of ALSA applications close its character devices. This may be against
> IEEE 1394 bus driver developers' expectation to high-level drivers.

The fw_unit reference counting was designed for situations like this.


Regards,
Clemens
