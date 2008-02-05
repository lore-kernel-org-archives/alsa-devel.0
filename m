From: Aldrin Martoq <amartoq@dcc.uchile.cl>
Subject: Re: [PATCH] SND_SEQ_BLOCK and
	SND_SEQ_PORT_CAP_NONE	defines
Date: Tue, 05 Feb 2008 02:55:45 -0300
Message-ID: <1202190945.6081.6.camel@localhost>
References: <17eedd8a0801310942g48245675k4a96162e810fd21a@mail.gmail.com>
	<s5h63x83l7w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by alsa0.perex.cz (Postfix) with ESMTP id A4C00103831
	for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2008 06:55:57 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so2285897fka.0
	for <alsa-devel@alsa-project.org>; Mon, 04 Feb 2008 21:55:56 -0800 (PST)
In-Reply-To: <s5h63x83l7w.wl%tiwai@suse.de>
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

On Fri, 2008-02-01 at 13:38 +0100, Takashi Iwai wrote:
> At Thu, 31 Jan 2008 14:42:42 -0300,
> Aldrin Martoq wrote:
> > Hey hackers,
> > While developing pyalsa sequencer API, I found that sometimes 0 is
> > used instead of a #defined value or constant.
> > In my opinion, given that the alsa API is opaque (hides internal
> > structure and provides methods for accessing them), we should define
> > those missing "constants" for being consistent. So far I found:
> > SND_SEQ_BLOCK 0 (blocking mode)
> > SND_SEQ_PORT_CAP_NONE (the port defines no access capabilites)
> Well, I myself don't mind to add such defintions, but remember that
> these flags are no enum but bits.  When you see BLOCK and NONBLOCK
> definitions, you'll likely think these are exclusive.  However,
> (BLOCK|NONBLOCK) or (NONE|READ) can be passed without problems.

I'm sorry, you are right and I was absolutely wrong. I thought mode is
something like an enumeration rather than a flag (I think still there is
a problem, for example there is no "change mode" api function, instead
there is a snd_seq_nonblock function ?!); the port cap type was clearly
a mistake.

I will correct this in the python version (remove this non-meaning
constants) and please forget my patch. Thanks,

-- 
Aldrin Martoq <amartoq@dcc.uchile.cl>
