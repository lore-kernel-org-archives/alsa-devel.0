From: krzysztof.h1@poczta.fm
Subject: Re: =?utf-8?q?sscape=3A_general_code_improvements?=
Date: 07 Oct 2009 13:19:25 +0200
Message-ID: <20091007111925.560A1199B1A0@f14.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 00AA62455C
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 13:19:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org



"Takashi Iwai" <tiwai@suse.de> pisze:
> At Tue, 6 Oct 2009 19:34:38 +0200,
> Krzysztof Helt wrote:
> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > General code and coding style improvements.
> > 
> > Add a missing argument for SET_XXX_MIDI_VOL command.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Do you really want to change oss/sscape.c that you wanted to remove?
> 

No, it is a mistake.

> 
> > ---
> > 
> > What is a standard name for switch to select internal or external midi?
> It is very easy to 
> > add such a functionality to the driver.
> 
> What do you mean exactly to switch int/ext midi?
> Usually the driver provides the interfaces for both, and let user choose.
> If they are exclusive, it's checked in the open.
> Or, if preferred, a control element can be used to choose the
> interface...
> 

The driver interface (MPU-401 UART) is only one and there is a command to switch it to the on-board synthetizer or external midi (joysitck port on the card).

Regards,
Krzysztof


---------------------------------------------------------------
Zobacz jak pracuje sie na wysokosciach.
Kliknij >>> http://link.interia.pl/f2384
