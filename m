From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Conexant CX20582 HDA codec support
Date: Mon, 29 Jun 2009 13:26:26 +0100
Message-ID: <20090629122625.GF11855@sirena.org.uk>
References: <1246277454.2182.6.camel@polyethylene>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 34A99103825
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Jun 2009 14:26:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246277454.2182.6.camel@polyethylene>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Drake <dsd@laptop.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 29, 2009 at 01:10:53PM +0100, Daniel Drake wrote:

> 1. Volume range is ridiculous, you can go all the way down to -74dB
> gain.  Beyond -42dB you can barely hear anything from the speakers, and
> I note that all my other systems only go down as far as -46.5dB.

This is normally just a case of drivers exposing whatever control they
get from the hardware.  Devices will often expose very high degrees of
attenuation since they're doing it anyway in order to implement the mute
functionality.
