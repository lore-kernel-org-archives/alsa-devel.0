From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: twl4030 - Add VDL path support
Date: Tue, 17 Mar 2009 10:42:00 +0000
Message-ID: <20090317104152.GA25698@sirena.org.uk>
References: <49BF5F40.3020000@samsung.com>
	<200903171122.22136.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C8F08103883
	for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2009 11:44:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200903171122.22136.peter.ujfalusi@nokia.com>
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
Cc: '?????????' <kyungmin.park@samsung.com>, alsa-devel@alsa-project.org, ext Joonyoung Shim <jy0922.shim@samsung.com>, ????????? <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 17, 2009 at 11:22:21AM +0200, Peter Ujfalusi wrote:

> Probably than it makes sense to rename the "Earpice Mux" and friends to 
> something like "Earpiece aduio Mux"...
> So we would have two controls per outputs:
> "Earpiece aduio Mux" (Off, DACL1, DACL2, DACR1)
> "Earpiece voice Switch" (on, off)
> and internally we can have "Earpiece output mixer", which mixes them together.

I'd suggest "HiFi" rather than "aduio" - it's all audio, it's the
quality of the audio that's the difference here.  This naming is used
for some other codecs.
