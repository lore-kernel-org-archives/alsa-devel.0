From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 21 Apr 2008 17:25:15 +0200
Message-ID: <480CB1DB.3010703@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>	<480099C6.3040708@superbug.co.uk>	<20080412133536.GC32491@tango.0pointer.de>	<48010E62.2020404@keyaccess.nl>	<20080414170022.GH22115@tango.0pointer.de>	<480392F3.9030701@keyaccess.nl>	<20080414172839.GA26513@tango.0pointer.de>	<4803C78A.3020109@superbug.co.uk>	<20080420010116.GA22033@tango.0pointer.de>
	<s5hej8zcohq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 451F624433
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 17:25:17 +0200 (CEST)
In-Reply-To: <s5hej8zcohq.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On 21-04-08 15:43, Takashi Iwai wrote:

> Yeah, I'm indeed very fond of automatic volume setup for desktop
> users, too.  I don't know whether it's a role of PA.  Rather I feel
> we'd need to add a feature to alsactl, such as,
> 	% alsactl init
> then it'll either initialize or restore the previous setup.
> 
> So, anyway, what we really need is to gather the data for each
> available device to initialize to the "sane" state...

People were worried about the maintainability of this (proposed as shipped 
/usr/share/cards/<card>.state files) but I feel this shouldn't be too bad 
indeed. I'd suggest "alsactl defaults" to just load those "unmuted card 
defaults" and leave looking for previously saved settings to an init script 
same as now. Distributions then have full freedom.

Is the "id" parameter to modules (and multiple cards with the later ones 
having an id postfix) a problem for finding the right state file to load? 
That is, is it a problem for the current <card>.conf files in there? Not 
sure how that works...

Rene.
