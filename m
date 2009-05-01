From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: TWL4030: Add VDL analog bypass
Date: Fri, 1 May 2009 13:10:53 +0100
Message-ID: <20090501121053.GH6975@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705F63E0BA7@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 548D5243F8
	for <alsa-devel@alsa-project.org>;
	Fri,  1 May 2009 14:10:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F63E0BA7@dlee07.ent.ti.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2009 at 09:47:22PM -0500, Lopez Cruz, Misael wrote:
> This patch adds voice downlink analog bypass switch. It follows
> the same approach as in other analog bypass switches.
> DAC switch is moved from 'DAC Voice' to 'Analog Voice Playback Mixer',
> that will also allow voice DAC to be powered in digital voice
> loopback (sidetone).

These both look fine from my point of view but I'd like Peter to ack
them before I apply them - I've not checked that they make sense for the
CODEC.
