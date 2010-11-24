From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCHES] Integrate minimal systemd support in
 alsa-utils
Date: Wed, 24 Nov 2010 20:47:37 +0100
Message-ID: <20101124194736.GD27878@tango.0pointer.de>
References: <20101123021657.GA17275@tango.0pointer.de>
	<icjjig$3ft$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C108103816
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 20:47:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <icjjig$3ft$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 24.11.10 17:55, Colin Guthrie (gmane@colin.guthr.ie) wrote:

> 
> 'Twas brillig, and Lennart Poettering at 23/11/10 02:16 did gyre and gimble:
> > +udevrulesdir=/lib/udev/rules.d
> > +
> 
> This doesn't appear to be used unless I missed something?
> 
> If it were used, I'd rather make this configurable. Obviously udev
> pretty much mandates this path but it's a PITA when doing non-root make
> installs to custom prefixes when it's hard coded like this. But like I
> say, this looks unused here...

Well, it still honours $(DESTDIR) logic.

It's referenced by the dist_udevrules_DATA= stanza.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
