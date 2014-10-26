From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 00/29 v2] ALSA: Enhancement for existed
 FireWire drivers
Date: Sun, 26 Oct 2014 17:51:54 +0100
Message-ID: <20141026175154.3fb486ed@kant>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EAF72606CC
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 17:51:59 +0100 (CET)
In-Reply-To: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, ffado-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Oct 26 Takashi Sakamoto wrote:
> This patchset is to enable ALSA Dice driver to handle more models, to
> improve ALSA firewire-speakers driver as OXFW driver. This patchset is
> for linux-next branch and all of my work for Linux 3.19.
[...]
> == Updates from my previous post:
> [alsa-devel] [PATCH 00/14] ALSA: Dice enhancement
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/081890.html
>  - Fix typo
>  - Minor code change
> 
> [alsa-devel] [RFC][PATCH 00/15 v4] OXFW driver, a succesor to firewire-speakers
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/076581.html
>  - Support more Mackie (Loud) models by name detection
>  - Fix a bug to handle FireWave
>  - Use AV/C Stream Format Information command to set sampling rate
[...]

I fetched this patch series from https://github.com/takaswie/sound
request_v5 branch, applied it on top of 3.17.1, and reran the tests
snd-oxfw with Lacie FireWire Speakers and Griffin FireWave which I descibed
in "Re: [RFC][PATCH 00/15 v4] OXFW driver, a succesor to firewire-speakers".
I got the same positive results.

Tested-by: Stefan Richter <stefanr@s5r6.in-berlin.de> (Speakers, FireWave)

I am planning to test the snd-dice part of this patch series with a
Focusrite Saffire PRO 24 sometime later this week.  I can test PCM I/O but
am currently not prepared to test MIDI I/O.
-- 
Stefan Richter
-=====-====- =-=- ==-=-
http://arcgraph.de/sr/
