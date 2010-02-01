From: pl bossart <bossart.nospam@gmail.com>
Subject: safe support for rewind in ALSA
Date: Mon, 1 Feb 2010 11:20:25 -0600
Message-ID: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7870B243C4
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 18:26:56 +0100 (CET)
Received: by pxi9 with SMTP id 9so4353325pxi.24
	for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2010 09:26:55 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Kai Vehmanen <kvehmanen@eca.cx>
List-Id: alsa-devel@alsa-project.org

All,
I'd like to reopen a thread on concerns with the current
implementation of rewind in ALSA. This was already discussed on the
mailing list last year without any progress.
(see  http://thread.gmane.org/gmane.linux.alsa.devel/65759/focus=65773
and http://article.gmane.org/gmane.linux.alsa.devel/66902)

The problem is that snd_pcm_rewind() allows in theory to go back to
the next sample to be rendered. This however isn't possible on any
existing hardware. DMAs do prefetch samples ahead of time, and output
interfaces have FIFOs on top of this.
This isn't too bad in the PC world with HDAudio, since the prefetching
is limited. However in the embedded space it has become a headache. To
reduce power consumption, most of the recent embedded interfaces do
embed some local internal memory (5kB for TI's McBSP3, a lot more for
others), and we should provide a means for driver developers to set a
bound on how much can be rewound safely when power-saving features are
enabled.

Note that there already are a set of definitions for FIFOs, but they
are either obsolete or no one uses them (actually HDAudio makes use of
this value internally in azx_dev but doesn't export it).

My suggestion would be to add a 'fifo' parameter to the runtime
structure (so that it's visible to the core), let the driver developer
fill the value in the .open routine, and use this parameter in rewind
to prevent rewinding too much. This parameter would include both
hardware FIFOs and DMA buffers.

Comments welcome.
- Pierre
