From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: SDP3430: Connect twl4030
	voice	DAI to McBSP3
Date: Mon, 18 May 2009 10:08:50 +0100
Message-ID: <20090518090849.GA1629@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E8125@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 45EC3244F8
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 11:08:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F69E8125@dlee07.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, May 17, 2009 at 08:03:40PM -0500, Lopez Cruz, Misael wrote:
> Connect twl4030 voice DAI to McBSP3 in sdp3430 machine driver.
> Audio and voice DAI init functions are enabling corresponding
> interface by writting directly to AUDIO_IF and VOICE_IF codec
> registers, respectively.

> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>

This looks fine but I'll wait for the corrections Peter requested on the
second patch before applying it - please repost along with those
corrections.  I've applied the first patch, thanks.
