From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: snd_mpu401_uart: hang when trying to play .mid
Date: Mon, 06 Sep 2004 16:18:25 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094501904.29921.56.camel@krustophenia.net>
References: <20040905092234.GA3605@masina.coderock.org>
	 <s5h656rwhmh.wl@alsa2.suse.de> <20040906154819.GA7901@nd47.coderock.org>
	 <s5h1xhfwej2.wl@alsa2.suse.de>  <20040906185838.GA8347@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040906185838.GA8347@nd47.coderock.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Domen Puncer <domen@coderock.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-09-06 at 14:58, Domen Puncer wrote:
> On 06/09/04 18:25 +0200, Takashi Iwai wrote:
> > At Mon, 6 Sep 2004 17:48:19 +0200,
> > Domen Puncer wrote: 
> > > On 06/09/04 17:18 +0200, Takashi Iwai wrote:
> > > > At Sun, 5 Sep 2004 11:22:35 +0200,
> > > > Domen Puncer wrote:
> > > > Does your hardware really a MPU401 device?
> > > 
> > > I don't know, probably not.
> > > 
> > > > If not, you can remove the call of snd_mpu401_uart_new() in
> > > > snd_trident_probe().
> > > 
> > > Or just never start kmid again :-)
> > > My point is: user can hang the computer; this is a bug.
> > 
> > Sure.  Removing the unneeded creation of mpu401 interface is _the_
> > solution if you really don't have mpu401.
> 
> Umm... you mean removing this for linus tree? Then why it was there
> in the first place?

No, Takashi-san is telling you to try commenting this out and recompile
and see if the problem goes away.  If so then we can figure out how to
detect this MPU-less device and fix it in ALSA CVS.  He probably does
not have access to the hardware to test it himself.

This is a pretty common issue with ALSA because a lot of cards that
purport to be the same as another have small differences, and the alsa
devs can't possibly test every single device.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
