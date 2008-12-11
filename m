From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: asound.conf
Date: Thu, 11 Dec 2008 14:10:26 +0000
Message-ID: <20081211141026.GE30808@sirena.org.uk>
References: <ef0d8a250812110555r7d9bf0e5m21318ab4e51848c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0741A1037FB
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 15:10:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ef0d8a250812110555r7d9bf0e5m21318ab4e51848c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 11, 2008 at 07:25:07PM +0530, naveen krishna ch wrote:

> Do i need to make a asound.conf file.If so, can any one help
> my with some information (a sample asound.conf) with details
> of the driver in it.

A missing /etc/asound.conf should be fine - ALSA provides defaults for
everything which normally work fine for embedded devices.  Most systems
use alsactl restore to do the initial configuration of the controls at
startup and rely on the default ALSA configuration for everything else.

Some documentation on .asoundrc can be found here:

	http://www.alsa-project.org/main/index.php/Asoundrc

and the examples in /usr/share/alsa/cards are in this format.
