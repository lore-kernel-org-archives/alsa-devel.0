From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [Alsa-user] ALSA / emu10k1 / SPDIF / surround?
Date: Mon, 29 Aug 2005 10:31:47 -0400
Message-ID: <1125325907.4598.23.camel@mindpipe>
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
	 <1125196132.25011.111.camel@mindpipe>  <s5hbr3h3xxy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbr3h3xxy.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thomas Zehetbauer <thomasz@hostmaster.org>, alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-08-29 at 11:16 +0200, Takashi Iwai wrote:
> At Sat, 27 Aug 2005 22:28:51 -0400,
> Lee Revell wrote:
> > 
> > On Sun, 2005-08-28 at 04:18 +0200, Thomas Zehetbauer wrote:
> > > > If you still get both a PCM and a Wave control, and distortion at high
> > > > levels, try removing the "ac97_chip = 1" line.
> > > 
> > > I still got the PCM control and distortions with the "ac97_chip=1" line.
> > > Without it I lost many controls including "Master" and could not hear
> > > any sound at all.
> > 
> > You are supposed to have only a PCM control - there should be no Wave
> > control.
> 
> I guess ac97_chip is always necessary for sb live.  Otherwise the
> front output won't be initialized correctly.

But even if we set it to 1, the user gets a "PCM" control and a "Wave"
control.

As I understand the emu10k1 driver, after initializing the AC97, it's
supposed to rename the "Wave" control to "PCM".  Why is this user
getting both?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
