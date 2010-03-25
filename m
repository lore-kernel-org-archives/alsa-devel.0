From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Problem adding support for digital mixer in codec
Date: Thu, 25 Mar 2010 09:26:43 +0000
Message-ID: <20100325092642.GA28082@sirena.org.uk>
References: <2256F256009DAA4CBE661E9F41EAC84B904BD8A0@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DA9B1038B8
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 10:26:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B904BD8A0@dlee01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 24, 2010 at 09:33:54PM -0500, Candelaria Villarreal, Jorge wrote:

> However, I think ALSA does not support this configuration, as the DAC
> should be the first element in a route. I tried adding the DAC to the
> route first, and connected its output to the mixer inputs, like this:

No, this is actually supported now - to expand on what Liam said in
reply to Peter if you leave the stream NULL in your DAC widgets and
instead use a SND_SOC_DAPM_AIF_IN() to bind to the stream then you can
add any DAPM routing you need between the AIF and the DAC.  The WM8994
driver is one example of doing this, it has digital mixing and routing
support which allows audio paths that never reach a DAC.
