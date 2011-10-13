From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 1/2] ASoC: soc-pcm: Add flag to ignore
 pmdown_time at pcm_close
Date: Thu, 13 Oct 2011 15:00:03 +0100
Message-ID: <20111013140003.GM1098@sirena.org.uk>
References: <1318512215-2331-1-git-send-email-peter.ujfalusi@ti.com>
	<1318512215-2331-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 08019247B4
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 16:00:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318512215-2331-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 13, 2011 at 04:23:34PM +0300, Peter Ujfalusi wrote:
> With this flag machine drivers can indicate that it is desired
> to ignore the pmdown_time for DAPM shutdown sequence when
> playback stream is stopped.
> The DAPM sequence will be executed without delay in this case.

Why make this a per-machine control?  This seems like it'd be a property
of the CODEC or possibly other chips rather than a machine specific thing?
