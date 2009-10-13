From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - try2] ASoC: Codec driver for
	Texas	Instruments tlv320dac33 codec
Date: Tue, 13 Oct 2009 13:54:12 +0100
Message-ID: <20091013125411.GC1230@sirena.org.uk>
References: <1255435391-18160-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255437698.30157.289.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E65371038B5
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 14:54:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1255437698.30157.289.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2009 at 03:41:38PM +0300, Eero Nurkkala wrote:

> Mark, aren't all codec bits updated within the snd_soc_update_bits() by
> DAPM? It always takes the io_mutex. Does it make sense if we proposed a

No, actually DAPM is bypassing that (which is probably a bug anyway but
the holding of the CODEC lock helps a lot there).  Note also that
io_mutex is only held for bitwise updates.

> new item to struct snd_soc_codec, something like io_mutex? then 
> snd_soc_update_bits() would check the presence of this codec->io_mutex,
> and if it was present, it would only use that instead of io_mutex.
> Just an idea... (I'd help here, no need for double locking like now)

Much less convoluted would just be to move io_mutex into the CODEC
unconditionally.  However, note that snd_soc_write() doesn't take the
lock - it's currently only used for read/modify/write cycles.
