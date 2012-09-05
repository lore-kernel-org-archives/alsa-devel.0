From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] Channel mapping API (take 2)
Date: Wed, 05 Sep 2012 10:32:24 +0200
Message-ID: <50470E18.5000404@canonical.com>
References: <s5hhard23jb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FFF92652D5
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 10:32:25 +0200 (CEST)
In-Reply-To: <s5hhard23jb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/04/2012 05:47 PM, Takashi Iwai wrote:
>    The phase inverted channel has this bit:
>    #define SNDRV_CHMAP_PHASE_INVERSE	(0x01 << 16)

Hmm. On second thought, as mics are plugged in and unplugged during 
recording, the channel map will change. (E g, changing a digital mic 
with phase inverse, to a stereo line in)

Will we also need a notify callback in alsa-lib to know changes in the 
channel map?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
