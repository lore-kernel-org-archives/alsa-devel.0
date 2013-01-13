From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Sun, 13 Jan 2013 15:09:36 +1030
Message-ID: <20130113043936.GA8822@marvin.atrad.com.au>
References: <s5hhamyr1ne.wl%tiwai@suse.de>
 <CAN8ccia6SGgukkzYQ_5XA0QkRXiq9E_vvqVmQ+sDBrg9ugqT9g@mail.gmail.com>
 <20130104032449.GA15708@marvin.atrad.com.au>
 <CAN8cciYyWfq=hgdRt6abNpSfWDtG3mfbPNvf7TKGrsJ8OpaDhw@mail.gmail.com>
 <20130104042423.GD15726@marvin.atrad.com.au>
 <CAN8cciYhydz6e6oz2QU4NeQgWsJU+4BQrhW6CK1tYd_+4E6pBw@mail.gmail.com>
 <20130105031254.GD11016@marvin.atrad.com.au>
 <CAN8ccib6xbxAjpNXzxQQGVSo9vuNNPU7NdB7FPFWaNCXLpn+Gw@mail.gmail.com>
 <20130105071605.GA11323@marvin.atrad.com.au>
 <s5hvcb7ohly.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 129F42616BF
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 05:39:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hvcb7ohly.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org, jwoithe@just42.net, peter.golden@btinternet.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 08, 2013 at 03:48:57PM +0100, Takashi Iwai wrote:
> > Node 0x10 is notionally labelled "headphone pin" in the ALC260 datasheet. 
> 
> You can forget the pin notion in the datasheet.  It's just pin
> assignment Realtek thought as a standard arrangement.

Absolutely - that was abundantly clear when I first added the S7020 details
years ago.  The comment was only made in an attempt to make the comments in
the original driver clearer to those reading them now.

> > I've just looked now.  3.3.5 was booted, alsamixer does not show any
> > "automute" control to enable or disable this.  In any case, automute is
> > certainly not happening, so I'm guessing the answer to your question is no.
> 
> There is no automute behavior switching control in the 3.3.x kernel
> driver, so no wonder :)

I wasn't surprised since I thought this too.  However, I was asked to test
it so I did.

> I took a look at your alsa-info.sh outputs now, but unfortunately I
> see no obvious problem there.  At least, the path to the speaker looks
> sane:
> :
> And all GPIOs are cleared too.

Agreed.  Given that the headphone jack works and the respective pin
definition is very similar, I also can't see any obvious reason why things
are getting messed up.  Something subtle perhaps?

> The differences are that the old driver cleared unused pins such as
> 0x0f, 0x11, 0x13 and 0x15.  Could you try to set the pin ctl to 0 for
> these widgets via hda-verb on the fly?

I will try this, hopefully in the next few days.  Like you I suspect, I
can't see that this should make any difference to the speaker's ability to
put out audio or to ALSA's ability to populate alsa-mixer correctly, but
it's easy enough to eliminate it through testing.

> Other than that, the headphone jack is set up with the HP amp and the
> mic is with VREF 50.  They can be changed on the fly, too.

I'll run through some of these variations and let you know the result.

I noticed your big refactoring patch go past last week.  Is there anything  
in there which I should test in relation to the ALC260 / Fujitsu issue
we've been discussing, or should I await further info?

Regards
  jonathan
