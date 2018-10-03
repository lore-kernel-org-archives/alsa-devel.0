From: Scott Bahling <sbahling@suse.com>
Subject: Re: Controlling the Tascam FW-1884
Date: Wed, 03 Oct 2018 21:31:35 +0200
Message-ID: <87b9b3e544c607297629a78488f775e47b487c3c.camel@suse.com>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
 <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
 <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
 <10a99ea9c672ac6d0c9d5536e9d85a15f5a32d95.camel@suse.com>
 <47f66c7d-4337-52da-72da-cdb3f0638dc4@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 02ECF2677F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 21:31:37 +0200 (CEST)
In-Reply-To: <47f66c7d-4337-52da-72da-cdb3f0638dc4@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Fri, 2018-09-28 at 12:44 +0900, Takashi Sakamoto wrote:
> Hi Scott,
> 
> On Sep 24 2018 18:32, Scott Bahling wrote:

...

> > 
> > The kernel was unstable and the system hard locked frequently with the
> > patches enabled (with and without the GFP_KERNEL patch). But I was able
> > to map out all the controller functions to the bits in the first 16
> > quadlets. I will write up my findings and send them later.
> 
> I'm sorry but I have applied wrong changes to the remote branch for
> kernel patch. It includes three issues:
> 
> 1. call vfree() to memory object allocated by kmalloc()
> 2. bring kernel oops due to double free corruption of 'tscm->status'
> 3. invalid page mapping of 'tscm->status' to process' VMA
> 
> I pushed additional three patches. Would you please test with them?

MMAP works fine and stable with the three additional patches.

-Scott
