From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: SNDRV_PCM_FORMAT_GSM
Date: Thu, 7 May 2009 12:52:44 +0100
Message-ID: <20090507115244.GG27897@sirena.org.uk>
References: <98769532B4BB14429434178695419EAE4AD52C07@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A20B6247B5
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 13:52:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE4AD52C07@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 07, 2009 at 04:51:52PM +0530, Harsha, Priya wrote:

> If I use the format SNDRV_PCM_FORMAT_GSM to identify if the audio
> stream is voice stream or not, would it be appropriate?

The format refers to the way the data is encoded rather than the meaning
of the content - if actual GSM data were being transmitted it'd be
sensible (but note that GSM format is not actually properly handled by
ALSA yet).
