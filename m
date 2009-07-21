From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Two Codecs in the machine driver
Date: Tue, 21 Jul 2009 09:42:01 +0100
Message-ID: <20090721084201.GA13286@sirena.org.uk>
References: <1889FA7136B567478A67D4B0F85B0CCE4891B081@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 580CD24155
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 10:42:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE4891B081@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 20, 2009 at 08:28:46PM -0500, Olaya, Margarita wrote:

> I have a hardware platform which has two codecs and I want to create a
> SoC machine driver to connect them to the processor, but it's not
> clear to me how to do that. Do you have any suggestions? Is there any
> driver that I can see as an example?

That's not entirely possible at the minute due to DAPM using strings to
identify devices.  There is one example of this, though, in the Pandora
which uses a twl4030 together with a simple, no control, DAC.
