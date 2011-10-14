From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 1/2] ASoC: soc-pcm: Add flag to ignore
 pmdown_time at pcm_close
Date: Fri, 14 Oct 2011 10:38:41 +0100
Message-ID: <20111014093840.GA5448@sirena.org.uk>
References: <1318512215-2331-1-git-send-email-peter.ujfalusi@ti.com>
	<1318512215-2331-2-git-send-email-peter.ujfalusi@ti.com>
	<20111013140003.GM1098@sirena.org.uk> <10992537.0jJ7E3VM1G@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AB43243E2
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 11:38:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <10992537.0jJ7E3VM1G@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: P?ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 12:24:01PM +0300, P?ter Ujfalusi wrote:

> I thought that depending on the environment we might need this or not for the 
> same component, and the best place for this is to be able to define it per dai 
> link.
> However I can move the flag as per codec configuration (within snd_soc_codec 
> struct). Would that be better?

I'd expect that it's likely to follow the device a lot of the time - for
example, in the case that motivated this it seems that every system
using twl6040 is going to need to work around the DC servo issue.
