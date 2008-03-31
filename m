From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Any wigets for ADC to DAC ?
Date: Mon, 31 Mar 2008 11:41:04 +0100
Message-ID: <20080331104103.GB11461@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 808B32471D
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Mar 2008 12:41:05 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexandre BOUIN <a.bouin@kerlink.fr>
Cc: 'ALSA-devel' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 31, 2008 at 12:32:21PM +0200, Alexandre BOUIN wrote:

> Will be there a support for a such feature in ASoC v2  ?

Given that more and more codecs support this sort of thing it's likely
that support for digital paths will get implemented at some point.  No
specific ETA for it, though.

Note that if there is no specific reason to use a digital bypass path
(such as filtering that is only supported on the digital path or a
lack of a suitable analogue path) then it is normally more power
efficient to use an analogue bypass path than a digital one.
