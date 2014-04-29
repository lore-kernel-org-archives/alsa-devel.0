From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/49 v4] Enhancement for support of
	Firewire devices
Date: Tue, 29 Apr 2014 20:21:41 +0900
Message-ID: <535F8B45.9000403@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 2400F265057
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 13:21:46 +0200 (CEST)
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

(Apr 25 2014 22:44), Takashi Sakamoto wrote:
> This 49 patchset is to update previous series:
> [alsa-devel] [PATCH 00/44 v3] Enhancement of support for Firewire devices
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074624.html
>
> 4 patches are newly added:
> [PATCH 09/48] dice/firewire-lib: Keep dualwire mode but obsolete CIP_HI_DUALWIRE
>   - Make firewire-lib simpler.
> [PATCH 10/48] firewire-lib/dice/speakers: Add common PCM constraints for AMDTP streams
>   - To share codes for drivers. Currently no improvement.
> [PATCH 25/48] fireworks/firewire-lib: Add a quirk to reset data block counter at bus reset
> [PATCH 46/48] bebob: Add a quirk of data blocks for MIDI messages for some M-Audio devices
>   - New quirks are identified.

Oops! The count of patch in these descriptions is wrong. The toal number 
of patch is 49. This is due to my forgetting to send [PATCH 01/49] in my 
previous series version 2 and 3. I didn't realize this...

5 patches are newly added:
[PATCH 01/49] firewire-lib: Rename functions, structure, member for AMDTP
  - I forgot to post this patch in series 2 and 3...
[PATCH 10/49] dice/firewire-lib: Keep dualwire mode but obsolete 
CIP_HI_DUALWIRE
  - Make firewire-lib simpler.
[PATCH 11/49] firewire-lib/dice/speakers: Add common PCM constraints for 
AMDTP streams
  - To share codes for drivers. Currently no improvement.
[PATCH 26/49] fireworks/firewire-lib: Add a quirk to reset data block 
counter at bus reset
[PATCH 47/49] bebob: Add a quirk of data blocks for MIDI messages for 
some M-Audio devices
  - New quirks are identified.

> For reviewers, you can see previous series in 'request_v3' branch of my remote repository.
> I hope this will help your work.

The missing patch is already included in this branch. I've just failed 
to generate series of patch when I posted version 2 and 3...

I'm sorry to trouble you.


Takashi Sakamoto
o-takashi@sakamocchi.jp
