From: Dajun Chen <dajun.chen@gmail.com>
Subject: Re: Driver for a codec with built-in DSP for MP3
	playback
Date: Mon, 15 Mar 2010 16:01:34 +0000
Message-ID: <b77ca4471003150901x5957d10bl97cc29ede2d072b0@mail.gmail.com>
References: <b77ca4471003150702q69a99932m36d2e667663749aa@mail.gmail.com>
	<20100315141404.GA13878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id D1444244E7
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 17:01:36 +0100 (CET)
Received: by fxm20 with SMTP id 20so6130430fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 09:01:35 -0700 (PDT)
In-Reply-To: <20100315141404.GA13878@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I mean example code of a driver which works either on PCM and MP3 (or other
compressed) audio stream.

Reagrds

David
On Mon, Mar 15, 2010 at 2:14 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, Mar 15, 2010 at 02:02:39PM +0000, Dajun Chen wrote:
>
> > I am wondering where to find the guidances of developing a device driver
> for
> > a codec device which has a built-in DSP for MP3 (and tracks in other
> format)
> > playback and recording?
>
> OOI which device?
>
> I'm not sure what you mean by guidance here.  The standard thing would
> be to do it as a regular CODEC driver with a custom interface for
> userspace (eg, gstreamer) to talk to.  The best way of handling DAPM
> will depend on implementation but probably representing the output of
> the DSP as an input pin will be easiest.
>
