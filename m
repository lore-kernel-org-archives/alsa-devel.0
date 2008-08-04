From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM9712 Not Giving output
Date: Mon, 4 Aug 2008 13:12:21 +0100
Message-ID: <20080804121221.GC2499@sirena.org.uk>
References: <20080801183711.GG11735@sirena.org.uk>
	<619046.61482.qm@web50105.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B8F1D24516
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Aug 2008 14:12:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <619046.61482.qm@web50105.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nitin Mahajan <nitinm76@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 02, 2008 at 02:46:17AM -0700, Nitin Mahajan wrote:

> I checked the mixer configuration.The registers 0x18h and 0x04h were mute at the time of initiating DMA for playback.

> I did set both registers with 0x7fff. From mixer point of view, If I am using an headphone, are these registers enough? I am still not able to hear anything.

Please provide alsactl output as requested - any configuration should be
done via the ALSA mixer rather than register writes.  In the case of
register 0x18 setting 0x7fff will set a gain of -34.5dB on each channel
which may be too low, depending on your input.
