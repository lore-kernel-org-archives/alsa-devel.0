From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Mon, 14 Jun 2010 11:30:48 +0800
Message-ID: <AANLkTil4eNjr5GuVw40VESMR5sqwScKr9BNvk4mkyW_9@mail.gmail.com>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id C221D24547
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 05:30:49 +0200 (CEST)
Received: by vws8 with SMTP id 8so101196vws.38
	for <alsa-devel@alsa-project.org>; Sun, 13 Jun 2010 20:30:48 -0700 (PDT)
In-Reply-To: <20100216144047.GB10586@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/2/16 Mark Brown <broonie@opensource.wolfsonmicro.com>

> On Tue, Feb 16, 2010 at 03:32:01PM +0100, Lennart Poettering wrote:
> > On Tue, 16.02.10 09:24, Jaroslav Kysela (perex@perex.cz) wrote:
>
> > > Line: 0dB..47.81dB          # seems correct -47.81dB..0dB
> > > Line Capture: -0.18dB..23.81dB      # seems correct
> > > -17.81dB..6.18dB
>
> > Hmm, how did you choose where to put 0dB?
>
> The Line one looks like someone got attenuation and gain confused, which
> is a fairly common mistake for people to make when copying information
> from one place to another.  Possibly a similar thing going on with the
> Line Capture control, plus a fixed 6dB gain (which may well be a
> separate amp...).
>

Correct me if I am wrong

0dB point is needed when you recording from line-in by connected loopback
cable to line out.

The captured signal is supposed to be the same as the playback signal when
you set both playback volume and capture volume to 0dB ,

if you set playback volume over 0dB , clipping occur in the captured signal
,

if the playback volume is less than 0dB , captured signal will be less than
the playback signal.
