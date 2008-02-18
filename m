From: Aldrin Martoq <amartoq@dcc.uchile.cl>
Subject: Re: ALSA MIDI interface - plugin
Date: Mon, 18 Feb 2008 14:58:56 -0300
Message-ID: <1203357536.6312.13.camel@localhost>
References: <61445c750802140724h1585b495pcc546e2b082e086a@mail.gmail.com>
	<s5hfxvuw483.wl%tiwai@suse.de>
	<61445c750802180647l3604fd9fk43426018d9a80e4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 004F31038FB
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 18:59:01 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so385926ana.80
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 09:59:00 -0800 (PST)
In-Reply-To: <61445c750802180647l3604fd9fk43426018d9a80e4b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Mon, 2008-02-18 at 20:17 +0530, Pharaoh . wrote:
> On Feb 15, 2008 10:23 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > At Thu, 14 Feb 2008 20:54:28 +0530,
> > Pharaoh . wrote:
> > > Now, I have to support rawmidi interface also. Is it possible to write a
> > > userspace
> > > plugin for making MIDI work? Where can I get sample code etc?
> > Another possibility is to write an ALSA sequencer client, and load
> > snd-virmidi driver.  Then you can connect to a rawmidi device as you
> > like.
> Thanks Takashi, I am not sure I understood this fully..Can you point me to
> some sample
> code or relevant documentation.

Look the code of aseqdump from alsa-utils project. You don't need
anything related to kernel, just a normal client that creates a port and
listens for events. Once you receive a MIDI event, process it and do the
magic in your card.

$ aseqdump 
Waiting for data at port 129:0. Press Ctrl+C to end.
Source_ Event_________________ Ch _Data__

$ aconnect -iol

$ aplaymidi -p 129:0 /usr/share/denemo/manual/4for2new.midi

Please note that with the alsaseq API you receive processed MIDI data...
This could be a plus for your development (you don't have to implement
the low-level midi parser). Timidity is a software synth that follow
this approach.


About snd-virmidi, is almost the same, but the port is a 'kernel port'
and it represents a virtual card. I'm not sure what advantages has it.


-- 
Aldrin Martoq <amartoq@dcc.uchile.cl>
