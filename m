From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCH] PulseAudio plugin: report XRUN state
	back	to application
Date: Sat, 22 Dec 2007 23:34:00 +0100
Message-ID: <20071222223359.GA13486@tango.0pointer.de>
References: <20071125211226.GF17108@tango.0pointer.de>
	<s5hd4txs49u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 8ADD61038C4
	for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2007 23:34:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hd4txs49u.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 26.11.07 11:13, Takashi Iwai (tiwai@suse.de) wrote:

> > Alternatively, ioplug could be beefed up to properly handle XRUNs, but
> > I thought this fix is simpler.
> 
> But it's a layer violation :)
> 
> We need a proper state-notification function.  It'd be simply setting
> the state in the end, but at least, it's clear and the ioplug can do
> any action or sanity-check if once needed.
> 
> A proposed patch is below.  Comments?

Looks good to me. 

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
