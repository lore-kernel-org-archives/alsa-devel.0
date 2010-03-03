From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
	FIFO state query
Date: Wed, 3 Mar 2010 12:07:44 +0200
Message-ID: <201003031207.44423.peter.ujfalusi@nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100303090324.83d076b6.jhnikula@gmail.com>
	<201003031202.48598.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 39CA22453A
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 11:08:24 +0100 (CET)
In-Reply-To: <201003031202.48598.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "tiwai@suse.de" <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 03 March 2010 12:02:48 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> Anyhow, I have done few tests (McBSP2):
> printing XBUFFSTAT before trigger:start
> printing XBUFFSTAT right after trigger:start
> printing XBUFFSTAT at the pointer call time
> print at DMA interrupt

In DMA interrupt I only printed out "DMA" and have not printed the XBUFFSTA=
T.
XBUFFSTAT is only printed at the next pointer/delay call.
Probably it would be also good to print at DMA interrupt, if there is a =

demand...

> printing XBUFFSTAT before trigger:stop
> printing XBUFFSTAT right after trigger:stop
> =


-- =

P=E9ter
