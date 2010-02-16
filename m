From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Strange behaviour in snd-usb-cayak with Audio4DJ
Date: Tue, 16 Feb 2010 18:17:08 +0100
Message-ID: <20100216171708.GB9007@buzzloop.caiaq.de>
References: <74fd948d1002160835j3df4a44sbfa3d3fdaabfdb60@mail.gmail.com>
	<20100216164443.GY9007@buzzloop.caiaq.de>
	<74fd948d1002160910g12141190k8f8a87b69fda85f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id AEEB4103825
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 18:17:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74fd948d1002160910g12141190k8f8a87b69fda85f1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 16, 2010 at 05:10:37PM +0000, Pedro Ribeiro wrote:
> On 16 February 2010 16:44, Daniel Mack <daniel@caiaq.de> wrote:
> > Could you first try to playback audio without all your quirks using the
> > following commands, please.
> >
> > For channel 1&2: aplay -D plughw:Audio4DJ,0,0 test.wav
> > For channel 3&4: aplay -D plughw:Audio4DJ,0,1 test.wav
> >
> > If that works, we can exclude driver issues. I'm very confident that
> > will work btw, as this is the way I tested the driver.
> >
> > I admittedly have no clue about JACK ;)
> >
> > Daniel
> >
> >
> 
> Thank you for the quick reply!
> 
> it works perfectly! I have no clue why the combined device produces
> such garbage when playing on channels 3 and 4.

Me neither, sorry. Maybe anyone else can help on this.

Daniel
