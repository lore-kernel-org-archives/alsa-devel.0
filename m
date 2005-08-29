From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: ALSA / emu10k1 / SPDIF / surround?
Date: Mon, 29 Aug 2005 11:53:47 -0400
Message-ID: <1125330827.4598.34.camel@mindpipe>
References: <1124755115.5763.3.camel@hostmaster.org>
	 <1125166820.22285.68.camel@hostmaster.org>
	 <1125168446.25011.68.camel@mindpipe>
	 <1125173150.22285.103.camel@hostmaster.org>
	 <1125174445.25011.76.camel@mindpipe>
	 <1125177706.22285.144.camel@hostmaster.org>
	 <1125178767.25011.86.camel@mindpipe>
	 <1125181627.22285.155.camel@hostmaster.org>
	 <1125183623.25011.102.camel@mindpipe>
	 <1125195487.2684.8.camel@hostmaster.org>
	 <1125196132.25011.111.camel@mindpipe> <s5hbr3h3xxy.wl%tiwai@suse.de>
	 <1125325907.4598.23.camel@mindpipe> <s5h1x4c4ust.wl%tiwai@suse.de>
	 <1125330291.4598.28.camel@mindpipe>  <s5hy86k3fls.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <s5hy86k3fls.wl%tiwai@suse.de>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thomas Zehetbauer <thomasz@hostmaster.org>, alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-08-29 at 17:52 +0200, Takashi Iwai wrote:
> At Mon, 29 Aug 2005 11:44:50 -0400,
> Lee Revell wrote:
> > 
> > On Mon, 2005-08-29 at 17:38 +0200, Takashi Iwai wrote:
> > > But ac97 chip is never initialized if ac97_chip == 0.
> > 
> > Right, but the user tried my patch to set ac97_chip to 1 for that model,
> > and is still getting a "Wave" and a "PCM" control.  Is this the expected
> > behavior?
> 
> Yes.  As mentioned in the last mail, "Wave" -> "PCM" is done only on
> audigy, not on sb live.

So then what is the ddifference between the Wave and PCM controls?
Don't they do the same thing?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
