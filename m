From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Driver for a codec with built-in DSP for
	MP3	playback
Date: Mon, 15 Mar 2010 14:14:05 +0000
Message-ID: <20100315141404.GA13878@sirena.org.uk>
References: <b77ca4471003150702q69a99932m36d2e667663749aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CBEF10382C
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 15:14:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b77ca4471003150702q69a99932m36d2e667663749aa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dajun Chen <dajun.chen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 15, 2010 at 02:02:39PM +0000, Dajun Chen wrote:

> I am wondering where to find the guidances of developing a device driver for
> a codec device which has a built-in DSP for MP3 (and tracks in other format)
> playback and recording?

OOI which device?

I'm not sure what you mean by guidance here.  The standard thing would
be to do it as a regular CODEC driver with a custom interface for
userspace (eg, gstreamer) to talk to.  The best way of handling DAPM
will depend on implementation but probably representing the output of
the DSP as an input pin will be easiest.
