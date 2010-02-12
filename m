From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack Detection ??
Date: Fri, 12 Feb 2010 10:07:34 +0000
Message-ID: <20100212100734.GA3742@sirena.org.uk>
References: <0D4616E6925F9541919B60692F61509E579CAED9@orsmsx502.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E03FF2443A
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 11:07:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <0D4616E6925F9541919B60692F61509E579CAED9@orsmsx502.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Johnson, Charles F" <charles.f.johnson@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 11, 2010 at 03:03:17PM -0800, Johnson, Charles F wrote:

> I'm trying to understand the level of jack detection implemented in ALSA.  
> I admit some amount of ignorance here - is this documented somewhere that I haven't been able to find yet ??

I'm not sure what exactly you're looking for here but the API used for
jack reporting is documented here:

	http://www.kernel.org/pub/linux/kernel/people/tiwai/docs/alsa-driver-api/ch06s02.html

The jack will appear as an input device.  If you're working on an
embedded system then ASoC has a wrapper around this which hooks in to
DAPM and makes it easier to combine multiple jack detection methods into
a single jack (eg, for microphone plus headphone detection on a headset
jack).
