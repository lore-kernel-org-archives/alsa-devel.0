From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Rationale behind snd_pcm_htimestamp()
Date: Wed, 18 Feb 2009 22:51:57 +0100
Message-ID: <20090218215157.GA13939@tango.0pointer.de>
References: <20090216023509.GA16494@tango.0pointer.de>
	<s5hk57qz7ng.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id C3C242433F
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 22:52:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk57qz7ng.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 16.02.09 17:08, Takashi Iwai (tiwai@suse.de) wrote:

> > An alternative way seemed to be to go via the snd_pcm_status
> > structure. However querying that seems not to sync the hw index
> > data. Hmm... so let's call snd_pcm_hwsync() right before querying the
> > struct -- as it turns out however, that function is now deprecated. So
> > which function should I call? The doxygen comments of _hwsync() kind
> > of suggest in a way to call snd_pcm_avail_update(), whose doxygen
> > comments however declare that it does in fact *not* sync the hw state
> > either, but suggest to use snd_pcm_avail() for that.
> > 
> > Ok, so I am now tempted to first call snd_pcm_avail() and then
> > snd_pcm_status() and have all three values atomically. But unfortunately
> > that's not the case. Again the avail value of the two calls differs sometimes.
> > 
> > How can I query the three values atomically? Can i do that at all?
> 
> Hmm, there is no way to get them in atomic way anyway, I guess.
> Even in *_avail_delay(),  basically each of them is called
> sequentially in alsa-lib code.
> 
> But, I wonder whether calling snd_pcm_delay() then
> snd_pcm_htimestamp() doesn't work?  snd_pcm_avail_delay() is nothing
> but a sequential call of snd_pcm_delay() and avail_update().  And,
> htimestamp is avail_update() and timestamp check.
> 
> Well, *_htimestamp() has a loop to sync with avail, so the similar
> logic could be used to sync all of them...

Hmm, so I understood you correctly then the API would need changing to
get the timestamp, the delay and the avail value that belong together?
That's unfortunate.

Why doesn't calling _avail() and then _status() do what I want?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
