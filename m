From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA SOC VI API's for 2 PCM DEVICE ON SAME CARD
Date: Fri, 5 Sep 2008 18:32:48 +0100
Message-ID: <20080905173247.GA31460@sirena.org.uk>
References: <1220597338.25078.15.camel@dinesh.dua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E1D202468E
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 19:32:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220597338.25078.15.camel@dinesh.dua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dinesh <dinesh.dua@coraltele.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 05, 2008 at 12:18:57PM +0530, dinesh wrote:

> Actually i am stuck with a problem i have two register 2 channels of my
> SOC device as 2 different pcm devices on same card.
> But my driver uses ALSA V1 api's and i am not able to find out any
> example code for this using v1 api's.    (SIMILAR TO MPC5200_PSC.C)

> If anyone can help me please.

Several machines have multiple PCMs - the first example that springs to
mind is tosa, see sound/soc/pxa/tosa.c.  Simply register more than one
dai_link in your snd_soc_machine.
