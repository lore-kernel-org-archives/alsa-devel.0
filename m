From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 0/9] S3C24XX/S3C64XX updates
Date: Wed, 11 Mar 2009 12:47:39 +0000
Message-ID: <20090311124738.GD20230@sirena.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
	<20090304202952.GA10731@sirena.org.uk>
	<s5hvdqofn6a.wl%tiwai@suse.de>
	<20090305103111.GA2416@sirena.org.uk>
	<s5h8wnk45ot.wl%tiwai@suse.de>
	<20090305110259.GC2416@sirena.org.uk>
	<20090311103936.GA18264@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FC7C2435D
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 13:47:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090311103936.GA18264@trinity.fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 10:39:36AM +0000, Ben Dooks wrote:

> At the moment this is still in your for-2.6.30 branch, do I need to look
> at doing anything about it?

I've pushed a revert of the two hunks I mentioned to Takashi already.
If you could comment on the other two hunks I identified and provide a
revert patch for them as well if they're not required that would be
helpful - if they're not essential for this change they should be
submitted separately via the ARM tree.
