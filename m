From: "Brian Hinz" <bphinz@hotmail.com>
Subject: Re: stac9200 speaker/hp not detected
Date: Wed, 04 Jul 2007 05:25:39 -0400
Message-ID: <BAY105-F311989668A164940507D43C8030@phx.gbl>
References: <s5h7ipga7a7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc2-s22.bay0.hotmail.com (bay0-omc2-s22.bay0.hotmail.com
	[65.54.246.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 8355810383D
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 11:25:42 +0200 (CEST)
In-Reply-To: <s5h7ipga7a7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Sorry, I recompiled the driver from the hg sources and hadn't re-run 
alsamixer to unmute.  It still doesn't work though - any suggestions?

Thanks,
-brian


>From: Takashi Iwai <tiwai@suse.de>
>To: "Brian Hinz" <bphinz@hotmail.com>
>CC: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] stac9200 speaker/hp not detected
>Date: Wed, 04 Jul 2007 10:43:12 +0200
>
>At Tue, 03 Jul 2007 23:08:42 -0400,
>Brian Hinz wrote:
> >
> > This laptop has only an internal speaker, a headphone out, and a mic in
> > (unless there are other outs enabled when the dock is connected).  The
> > windows INI seems to be setting some gpio bits but I don't understand 
>how to
> > map the ini syntax into the alsa driver (or if it needs to be...)
>
>Might be needed, but...
>
> > Node 0x0b [Audio Selector] wcaps 0x300105: Stereo Amp-Out
> >   Amp-Out caps: N/A
> >   Amp-Out vals:  [0x80 0x80]
> >   Connection: 1
> >      0x07
>
>You didn't unmute "Master" mixer switch?
>
>
>Takashi
