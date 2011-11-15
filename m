From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: alc5632: rename volume/switch
 contols for master and speaker volumes.
Date: Tue, 15 Nov 2011 19:25:10 +0000
Message-ID: <20111115192509.GA4223@opensource.wolfsonmicro.com>
References: <1321213993-27920-1-git-send-email-leon@leon.nu>
	<20111114213915.GH6528@opensource.wolfsonmicro.com>
	<CALq1K=+gUXnt0q4TxpUOhZFmdnHd+jdnkMpbj0JpF7_BkpCiDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8FD72437E
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 20:25:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CALq1K=+gUXnt0q4TxpUOhZFmdnHd+jdnkMpbj0JpF7_BkpCiDg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 14, 2011 at 11:50:05PM +0200, Leon Romanovsky wrote:
> On Mon, Nov 14, 2011 at 23:39, Mark Brown

> > This looks really suspicious, why are we renaming the line output as a
> > speaker output? =A0This might be appropriate on your board but if the
> > drivers aren't part of the CODEC it might not be appropriate on another
> > board.

> There are two main reasons:
> 1) We are changing SPK_OUT_VOL which on the schematics marked as a
> speaker, and we want to be as close as possible to the datasheet.
> 2) We are tired to explain to users that the speaker volume controlled
> by "Line Playback Volume" in alsamixer.

The above both sound board specific.  What does the CODEC itself call
these outputs?
