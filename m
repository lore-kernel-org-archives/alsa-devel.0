From: Remy Bruno <remy.bruno@trinnov.com>
Subject: Re: RME 9632 - Problem half solved
Date: Mon, 9 Oct 2006 12:18:59 +0200
Message-ID: <20061009101859.GA16650@trinnov.com>
References: <20061003103712.GA12508@trinnov.com>
	<20061006135355.GA22664@trinnov.com> <s5h64exs714.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h64exs714.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 06 October at 19:12, Takashi Iwai wrote:
> Could you give a proper changelog text and a signed-off-by line to
> merge your patch into ALSA tree?

Changelog:
hdsp: support for mixer matrix of RME9632 rev 152

Signed-off-by: Remy Bruno <remy.bruno@trinnov.com>

> 
> > 
> > For the frequency problem, I got an answer from RME which explains that another
> > register needs to be set (together with the freq0, 1, 2 bits of the control
> > register). This register is the "DDS" register. Here is how it should be
> > computed:
> > UINT64 CalcDDSValue(UINT64 rate)
> > {
> >         if (rate >= 112000)
> >                 rate /= 4;
> >         else if (rate >= 56000)
> >                 rate /= 2;
> > 
> >         return 104857600000000 / rate;
> > }
> > MemBase[FREQ_REG] = (ULONG)CalcDDSValue(new_rate)
> > 
> > Any ideas of what the offset of this register is? If not, I will ask him. BTW,
> > this register exists only for the 9632 and not for the 9652.
> 
> Hm, the numerator is pretty big, it's 0x100000 * 10^7.
> A clock with fixed point?

Yes, that's weird. That's what they told me. I'll investigate this.

> 
> Anyway, remember that you cannot use 64bit division in the linux
> kernel code as it is.  You can use a macro div64_32 defined in pcm.h,
> though.

OK

Remy

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
