From: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH 1/2] sis7019: support the SiS
	7019	Audio	Accelerator
Date: Wed, 28 Nov 2007 08:22:25 -0500
Message-ID: <1196256145.7017.60.camel@obelisk.thedillows.org>
References: <1196234344.7017.31.camel@obelisk.thedillows.org>
	<s5hejeaithq.wl%tiwai@suse.de>
	<1196255015.7017.52.camel@obelisk.thedillows.org>
	<s5h3auqim2i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A01524B59
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 14:22:35 +0100 (CET)
In-Reply-To: <s5h3auqim2i.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-11-28 at 13:36 +0100, Takashi Iwai wrote:
> OK, then it's fine.  But add a proper comment.  Otherwise no one else
> would understand the difference.

I presume the comment /* Must hold the voice_lock on entry */
present in all of the __ functions is insufficient, or we wouldn't be
having this coversation? :)
