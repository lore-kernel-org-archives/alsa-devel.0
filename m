From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 latency / capture period
Date: Mon, 21 Jun 2004 16:27:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1087849623.8161.46.camel@debian>
References: <200406210803.i5L83SRH009708@www1.pobox.sk>
	 <s5h659llyo6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h659llyo6.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Zubaj <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-06-21 at 11:26, Takashi Iwai wrote:
> At Mon, 21 Jun 2004 10:03:28 +0200,
> Peter Zubaj wrote:
> > 
> > Hi,
> > 
> > >With this patch I can run JACK in capture only mode with the period size
> > >set as low as 128.  64 gives an error.  This is exactly the expected
> > >behavior: 128 frames is the lowest setting the kX ASIO driver allows.
> > 
> > When you dissable these constraints driver automatic sets period size
> > (alias capture buffer size to minimal value)
> > 
> > I think driver will print some asserts - check your console or logs
> > for it.
> 
> Well, if the "error" means an buffer XRUN, the driver doesn't assert.
> 

Yes, that is exactly what it does, it just XRUNS.  The patch is wrong.
I think I have figured out the right way to do it, see my reply to
Takashi.

Lee



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
