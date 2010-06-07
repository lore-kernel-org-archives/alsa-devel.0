From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: External samplerate changes, UAC2 clock topologies
Date: Mon, 7 Jun 2010 10:45:23 +0100
Message-ID: <20100607094522.GA5993@sirena.org.uk>
References: <20100604124635.GL2698@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CE6BE1037EC
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 11:45:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100604124635.GL2698@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 04, 2010 at 02:46:35PM +0200, Daniel Mack wrote:

> Any oppinions? Has this been done before for any other audio hardware
> supported by ALSA?

ASoC has similar clocking schemes supported, though it relies on the
board for a lot of the decision making since there's an element of
policy about the use cases which may need to be handled that ASoC type
systems can be used.  The ideal thing is pretty much what you describe
where the driver handles things as transparently as possible to the
applications.
