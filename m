From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Sat, 5 Jan 2013 17:57:06 +1030
Message-ID: <20130105072706.GB11323@marvin.atrad.com.au>
References: <20121228135207.GA24779@marvin.atrad.com.au>
 <s5hhamyr1ne.wl%tiwai@suse.de> <50E69ABD.40109@canonical.com>
 <20130105024917.GA11016@marvin.atrad.com.au>
 <50E7AFD6.5050003@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 98FCA261986
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2013 08:27:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <50E7AFD6.5050003@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 05, 2013 at 05:45:10AM +0100, David Henningsson wrote:
> >>Meanwhile, there is hda-jack-retask utility (in the alsa-tools
> >>package) that might be helpful for Jonathan?
> >
> >I discovered that utility during my initial investigations.  Unfortunately
> >it requires GTK3 and I have not yet had an opportunity to upgrade the laptop
> >to a distro version which includes it.  Given my schedule I suspect it's
> >going to be several months before I get the chance.
> 
> Maybe I should add an ncurses interface ;-)

:-) I for one would find it useful (even after I have gtk3 on the machine).

> Anyway, if it's easier for you to read the HDA spec than upgrading
> your laptop, you can use the kernel interfaces directly using a
> "firmware patch" file or reconfigure sysfs. This is what
> hda-jack-retask uses.

That's interesting.  I'll definitely take a look at the documentation you
mentioned.  Then again, if the full fix isn't too far away I may just stick
with 3.3.5 until that becomes available.  That probably comes down to how
much time Takashi has.

> Or a compromise; boot up a live-CD of a newer distro, create the
> firmware file with hda-jack-retask, then copy the result back to
> your current distro setup.

I'll look into this too.  I would need multiple such firmwares to cope with
different configurations (they are sometimes switched on the fly) but like
you said, it would be another interim solution.

Regards
  jonathan
