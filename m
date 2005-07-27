From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] WM97xx AC97 codec controls
Date: Wed, 27 Jul 2005 12:09:58 +0100
Message-ID: <1122462598.3135.24.camel@localhost.localdomain>
References: <1121769565.6237.32.camel@cearnarfon>
	 <m28y02o6vm.fsf@vador.mandriva.com> <1121855229.14604.44.camel@cearnarfon>
	 <s5hd5p4lfyj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5p4lfyj.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thierry Vignaud <tvignaud@mandriva.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-07-27 at 12:07 +0200, Takashi Iwai wrote:

> I found that the control names you added don't follow always the
> standard rule.  Namely,
> 
> - "XXX Vol" should be "XXX Volume"
> - "XXX Mute" should be "XXX Switch" in the inversed way
>   (unless it becomes confusing)
> 
> Using "Volume" or "Switch" suffix is important because the mixer
> abstraction layer detects the type of the control from such a name 
> suffix.
> 
> Could you fix these?

np.

I've just had a look the list of control types (in hcontrol.c) and I
think I've got a couple of types in the patch that are missing:-

  o ALC/NG - Automatic Level Control and Noise Gate controls. ALC
attack, decay and hold are measured in time instead of volume. 
  o ZC - Zero Cross controls (becoming more popular in codecs)

I could add "ALC", "NG", "ZC" and "Time" (or similar) to hcontrol.c, but
I'm not sure if it requires more than just adding strings.

Liam
 



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
