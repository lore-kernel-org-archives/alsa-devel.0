From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Rationale behind snd_pcm_htimestamp()
Date: Wed, 25 Feb 2009 22:42:23 +0100
Message-ID: <20090225214222.GC27632@tango.0pointer.de>
References: <20090216023509.GA16494@tango.0pointer.de>
	<s5hk57qz7ng.wl%tiwai@suse.de>
	<20090218215157.GA13939@tango.0pointer.de>
	<s5heixmo8ht.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id CBB43243D9
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 22:42:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5heixmo8ht.wl%tiwai@suse.de>
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

On Wed, 25.02.09 16:13, Takashi Iwai (tiwai@suse.de) wrote:

> > Hmm, so I understood you correctly then the API would need changing to
> > get the timestamp, the delay and the avail value that belong together?
> 
> Yes, if you stick with snd_pcm_htimetamp(), snd_pcm_avil() and co.
> 
> But basically snd_pcm_status() does sync and fetch all status data.
> Shouldn't calling this suffice for your purpose?

Hmm, so snd_pcm_status() does sync? Good to know. I'll then use that.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
