From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: fix misc oopses
Date: Thu, 17 Mar 2005 10:02:23 -0500
Message-ID: <1111071744.23171.1.camel@mindpipe>
References: <1110950511.19984.9.camel@mindpipe>
	 <m2u0naqs54.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <m2u0naqs54.fsf@vador.mandrakesoft.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-03-17 at 15:11 +0100, Thierry Vignaud wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > The P16V patch unconditionally checks the IPR2 register in the
> > interrupt handler resulting in infinite loop and system lockup on
> > any non Audigy2 cards.  I really hate checking emu->is_audigy and
> > emu->revision in a fast path like the IRQ handler but I don't see
> > another way.
> > 
> > Also, don't bother allocating/freeing the DMA buffer for P16V unless
> > it's really present.
> > 
> > This is a critical fix and should trigger an immediate rc2 release
> > IMO.  Currently any emu10k1 users other than Audigy 2 will lock up
> > hard as soon as they play any sound.
> > 
> > Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
> 
> fix more oopses:
> 
> Signed-Off-By: Arnaud Patard <apatard@mandrakesoft.com>

OK, those are clearly my fault.

Sounds like this could also fix OSDL bug 4282:

http://bugme.osdl.org/show_bug.cgi?id=4282

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
