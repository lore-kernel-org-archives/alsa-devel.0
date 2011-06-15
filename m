From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Powersave doesn't work for snd_hda_intel with
	3.0.0-rc2
Date: Wed, 15 Jun 2011 06:08:18 +0000
Message-ID: <20110615060818.GA21679@localhost.ucw.cz>
References: <20110609085616.GA4207@tiehlicka.suse.cz>
	<20110609090607.GB4207@tiehlicka.suse.cz>
	<s5hei33xsxn.wl%tiwai@suse.de>
	<20110609092826.GC4207@tiehlicka.suse.cz>
	<s5haadrxrsm.wl%tiwai@suse.de>
	<20110609111401.GA3994@tiehlicka.suse.cz>
	<s5htybyw52q.wl%tiwai@suse.de>
	<20110610075640.GA4832@tiehlicka.suse.cz>
	<s5hhb7yw16i.wl%tiwai@suse.de>
	<20110610083956.GE4832@tiehlicka.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (ksp.mff.cuni.cz [195.113.26.206])
	by alsa0.perex.cz (Postfix) with ESMTP id BB73C24696
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 08:08:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110610083956.GE4832@tiehlicka.suse.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michal Hocko <mhocko@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri 2011-06-10 10:39:56, Michal Hocko wrote:
> [changed subject]
> 
> As a summary:
> I am loosing sound after powe_save timeout expires if there is no device
> activity. The only way how to get sound back is to unload the module and
> load it again.

Hmm, today my x60 with 3.0-rc was strangely quiet. Coincidence?
     	      	       pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
