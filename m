From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Triple implementation of WM8766 and quadruple
 WM8776!
Date: Tue, 13 Mar 2012 21:31:50 +0000
Message-ID: <20120313213150.GA16460@sirena.org.uk>
References: <201203122241.12234.linux@rainbow-software.org>
	<4F5F1776.4020904@ladisch.de> <4F5F1905.7040609@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 574831041B3
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 22:31:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F5F1905.7040609@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: Ondrej Zary <linux@rainbow-software.org>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 13, 2012 at 10:53:09AM +0100, Pavel Hofman wrote:

> How about a solution similar to AKM codecs in i2c/other? Several ice1724
> cards make use of those modules, easy to support and re-use. IMO cleaner
> approach than duplicating ICE1724 to the ASoC framework.

Those drivers should also be using ASoC - they're there only because
they predate having a framework for this stuff.  As Clemens said we
shouldn't be duplicating the ICE1724 code, we should be moving it.
