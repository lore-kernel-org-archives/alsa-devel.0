From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: Move symmetric rate check
	for	substreams to hw_params
Date: Mon, 7 Mar 2011 12:09:24 +0000
Message-ID: <20110307120924.GC1829@sirena.org.uk>
References: <1299498963-1134-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7209C10382B
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 13:09:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1299498963-1134-1-git-send-email-vaibhav.bedia@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: alsa-devel@alsa-project.org, Afzal Mohammed <afzal@ti.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2011 at 05:26:03PM +0530, Vaibhav Bedia wrote:
> Currently the symmetric rate check is present in the snd_pcm_open() call.
> However this causes snd_pcm_open() to fail for the 2nd substream is the
> 2nd call to snd_pcm_open() is made before the 1st substream has set a non-zero
> rate by calling snd_pcm_hw_params().
> 
> Fix this by moving the call to snd_pcm_apply_symmetry() to soc_pcm_hw_params().

This means that applications won't be constrained by the current
settings so can't automatically choose the required rate.  ALSA is just
fundamentally racy here, if you want to reliably open bidirectional
streams you need to serialise the startup of the two directions.
