From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 2/2] wss: use stuct snd_wss instead of
 snd_ad1848
Date: Thu, 3 Jul 2008 19:03:30 +0200
Message-ID: <20080703190330.588e604a.krzysztof.h1@poczta.fm>
References: <20080701201411.e7715d83.krzysztof.h1@poczta.fm>
	<s5hprpvs2l6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id D98F62485C
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 18:59:31 +0200 (CEST)
In-Reply-To: <s5hprpvs2l6.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@keyaccess.nl>
List-Id: alsa-devel@alsa-project.org

On Thu, 03 Jul 2008 12:07:33 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 1 Jul 2008 20:14:11 +0200,
> Krzysztof Helt wrote:
> > 
> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > The snd_wss is superset of the snd_ad1848 so kill
> > the latter and replace it with the snd_wss.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > ---
> > Another step toward unification of all WSS compatible
> > chips handling.
> 
> Right, and without the unification, these patches have little merits.
> So far, it's more addition than deletion in total.

Like all my patches, finally somebody has caught this ;-)

Seriously, these patches are just easier part. More renaming
then real changes. Only the last one (use struct snd_wss instead of snd_ad1848)
unify some code.

The next step is to merge the ad1848_lib into the wss_lib. I want to do
this in 3 to 5 steps for easier testing (and review). The problem is 
that temporary steps would require exporting of internal wss_lib functions.
My idea is to do this include in the ad1848_lib.c:
#include "../wss/wss_lib.c" 
then replace ad1848 functions with the wss_lib functions.

As Rene wrote, doing it in steps helps us testing changes on cards we have
for regressions.

BTW. I am on holidays next two weeks so do not expect too much.

Regards,
Krzysztof

----------------------------------------------------------------------
W kosciele tez zdarzaja sie wpadki!
Smieszny filmik >>> http://link.interia.pl/f1e61
