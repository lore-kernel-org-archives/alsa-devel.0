From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC][PATCH 00/15 v4] OXFW driver,
 a succesor to firewire-speakers
Date: Tue, 13 May 2014 19:43:02 +0200
Message-ID: <20140513194302.128783a7@kant>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 62AC72654E2
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 19:43:04 +0200 (CEST)
In-Reply-To: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: fenlason@redhat.com, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On May 13 Takashi Sakamoto wrote:
> If you have Griffin FireWave, I would strongly request to test.
> Please see 'An issue for FireWave' in this message.
[...]

I will try to test your patches with my FireWave sometime soon, but I will
be traveling or at work for the entire rest of this week.

Note, current mainline snd-firewire-speakers does _not_ support FireWave
properly.  On one of the stereo channels, snd-firewire-speakers generates
a high background hiss.  Could be that Jay Fenlason had a solution for
this which hadn't made it into the mainline still.  Was it something
about signedness of the PCM data? 
-- 
Stefan Richter
-=====-====- -=-= -==-=
http://arcgraph.de/sr/
