From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Fri, 02 Mar 2012 07:26:30 +0100
Message-ID: <4F506816.1050201@canonical.com>
References: <s5hhay89pq0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D9C7103CEE
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 07:26:33 +0100 (CET)
In-Reply-To: <s5hhay89pq0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 03/01/2012 06:48 PM, Takashi Iwai wrote:
> So, a question of "Line Out" to be hyphened or not to be hyphened.
>
> The problem is less serious than Hamlet, and I think we can get rid of
> the redundant hyphen.  Not only because many women dislike hyphened
> names nowadays (as you can find easily in Google),

Yes, it is also inspired by the global individualism movement, clearly 
'Line' and 'Out' do not want to appear to be dependent on each other.

> the naming rule
> with a direction suffix looks more flexible, and I saw that both or
> Mark and David don't matter much (so written in their posts).
>
> The fix patch is below.  David, if you think it's too bad (that makes
> your code too messy), please speak up.  Or, this is utterly broken,
> also let me know.

There is no problem with this change. But is it used for mixer controls 
anywhere, or only jacks? So far I haven't seen a mixer control having 
either 'Line-Out' nor 'Line Out' in it.

A followup, slightly more serious question is 'Line' vs 'Line In'. It 
seems PulseAudio only supports 'Line' today, but adding support is trivial.

>
>
> thanks,
>
> Takashi
>
> ---
> From: Takashi Iwai<tiwai@suse.de>
> Subject: [PATCH] ALSA: hda/realtek - Kill hyphnated names

Nitpick: Missing "e" in "hyphen".

>
> Kill hyphens from "Line-Out" name strings, as suggested by Mark Brown.
>
> Signed-off-by: Takashi Iwai<tiwai@suse.de>
> ---
>   sound/pci/hda/hda_codec.c     |    4 ++--
>   sound/pci/hda/patch_realtek.c |    4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)

I think you should change 'Line-Out' to 'Line Out' on a more global 
basis. A quick grep for 'Line-Out' shows hits (that are not comments) in 
patch_realtek.c, patch_cirrus.c and patch_conexant.c, as well as in 
ac97, aoa and parisc directories. At least the patch_cirrus one should 
be changed IMO.

Also, in the sound/soc there seem to be plenty of hits for 'Line Output' 
which could be changed to 'Line Out', mostly for consistency. Something 
for Mark?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
