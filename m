From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
 instead of ad1848 one
Date: Sun, 20 Jul 2008 18:09:14 +0200
Message-ID: <4883632A.8090106@keyaccess.nl>
References: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 598B3243E9
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 18:07:03 +0200 (CEST)
In-Reply-To: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 18-07-08 21:51, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Use the wss detection code and kill the ad1848 library.
> The library is fully assimilated into the new wss library.
> 
> This patch fixes also the issue with AD1848 codec
> MCE timeout - a waiting loop is now 10 times longer.
> 
> I have tested it on following cards:
> Gallant SC-6600 (codec: AD1848, driver: snd-sc6600]
> SoundScape VIVO/90 (codec: AD1845, driver: snd-sscape]
> SG Waverider (codec: CS4231A, driver: Rene Herman's snd-galaxy]

Now that you mention it... I should revive and submit that thing.

> Opti930 (codec: built-in - CS4231 compatible, driver: snd-opti93x]
> Opti931 (codec: built-in - CS4231 compatible, driver: snd-opti93x]
> Gallant SC-70P (chip/codec: CS4237B, driver: snd-cs4236]
> 
> Sound playback and recording works on all these cards.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Just a quick note to say I'm now running this series (and am at the 
moment listening to a snd-cs4236 card) on top of Takashi's sound-2.6 
tree (and including the PNP stuff that's going into 2.6.27 but that's 
unrelated).

For anyone interested, I have placed the complete series as I have it 
here at:

http://members.home.nl/rene.herman/wss/

It's against current ALSA. I'll give this a proper review early this 
coming week. Takashi was away for the week so that should get things 
looked at before he returns.

Thanks!

Rene.
