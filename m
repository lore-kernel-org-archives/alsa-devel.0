From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2/4] ASoC: core: Add delay operation
	to	snd_soc_dai_ops
Date: Tue, 2 Mar 2010 13:54:39 +0000
Message-ID: <20100302135439.GH10658@sirena.org.uk>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-3-git-send-email-peter.ujfalusi@nokia.com>
	<20100302134508.GD10658@sirena.org.uk>
	<201003021549.33189.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5456E1038FB
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:54:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201003021549.33189.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 02, 2010 at 03:49:33PM +0200, Peter Ujfalusi wrote:

> Sure, actually I have added this check later, since I had some trouble to make 
> sensible reporting on the capture path.
> But sure, I can remove this check and leave it to the dais to deal with.

Yeah, I'm not convinced it's going to get used for capture but it seems
a little easier to allow it rather than have to transition later.  It's
also consistent with all the other ops.
