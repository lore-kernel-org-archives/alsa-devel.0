From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [patch] ALSA: snd-aoa: two copy and paste bugs
Date: Wed, 13 Nov 2013 09:29:54 +0100
Message-ID: <1384331394.14578.0.camel@jlt4.sipsolutions.net>
References: <20131113074520.GD25541@elgon.mountain>
	 <s5h4n7gso19.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <s5h4n7gso19.wl%tiwai@suse.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Jaroslav Kysela <perex@perex.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-11-13 at 09:29 +0100, Takashi Iwai wrote:
> At Wed, 13 Nov 2013 10:45:20 +0300,
> Dan Carpenter wrote:
> > 
> > These functions were cut and paste and the tests for NULL weren't
> > updated properly.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Thanks, applied.

FWIW, looks fine to me - I wonder how long this has been broken though,
must be practically forever. I guess we never got it wrong and missed
adding some pointers? :-)

johannes

