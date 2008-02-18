From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: ALSA MIDI interface - plugin
Date: Mon, 18 Feb 2008 20:17:17 +0530
Message-ID: <61445c750802180647l3604fd9fk43426018d9a80e4b@mail.gmail.com>
References: <61445c750802140724h1585b495pcc546e2b082e086a@mail.gmail.com>
	<s5hfxvuw483.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 75AE710387B
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 15:47:20 +0100 (CET)
Received: by wx-out-0506.google.com with SMTP id t11so1807356wxc.23
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 06:47:18 -0800 (PST)
In-Reply-To: <s5hfxvuw483.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Feb 15, 2008 10:23 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 14 Feb 2008 20:54:28 +0530,
> Pharaoh . wrote:
> >
> > Now, I have to support rawmidi interface also. Is it possible to write a
> > userspace
> > plugin for making MIDI work? Where can I get sample code etc?
>
> It's possible, but so far, no external plugin framework is implemented
> for rawmidi.  The external plugins are available only for PCM and
> control APIs.  I guess it'd be relatively easy to add the external
> rawmidi plugins, though.
>
> Another possibility is to write an ALSA sequencer client, and load
> snd-virmidi driver.  Then you can connect to a rawmidi device as you
> like.
>
> Thanks Takashi, I am not sure I understood this fully..Can you point me to
some sample
code or relevant documentation.

-Pharaoh.


> Takashi
>
