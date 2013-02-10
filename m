From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Sun, 10 Feb 2013 22:17:07 +1030
Message-ID: <20130210114707.GA26574@marvin.atrad.com.au>
References: <20130104032449.GA15708@marvin.atrad.com.au>
 <CAN8cciYyWfq=hgdRt6abNpSfWDtG3mfbPNvf7TKGrsJ8OpaDhw@mail.gmail.com>
 <20130104042423.GD15726@marvin.atrad.com.au>
 <CAN8cciYhydz6e6oz2QU4NeQgWsJU+4BQrhW6CK1tYd_+4E6pBw@mail.gmail.com>
 <20130105031254.GD11016@marvin.atrad.com.au>
 <CAN8ccib6xbxAjpNXzxQQGVSo9vuNNPU7NdB7FPFWaNCXLpn+Gw@mail.gmail.com>
 <20130105071605.GA11323@marvin.atrad.com.au>
 <s5hvcb7ohly.wl%tiwai@suse.de>
 <20130113043936.GA8822@marvin.atrad.com.au>
 <s5h8v7xjw4f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 102EE2615D1
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 12:47:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8v7xjw4f.wl%tiwai@suse.de>
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

Hi Takashi

On Sun, Jan 13, 2013 at 10:00:16AM +0100, Takashi Iwai wrote:
> > I noticed your big refactoring patch go past last week.  Is there anything  
> > in there which I should test in relation to the ALC260 / Fujitsu issue
> > we've been discussing, or should I await further info?
> 
> It's worth to test my latest code, yes.  There are lots of fixes
> there, too, together with code refactoring.
> 
> You can test either master, test/hda-gen-parser or test/hda-migrate
> branch of sound-unstable tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git
> 
> Or if you want to avoid the kernel rebuild, you can try alsa-driver
> externally from a snapshot tarball:
>   ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-unstable-snapshot.tar.gz

I'm now back from linux.conf.au and would like to pick up this issue.  Given
that several weeks have elapsed since we last touched base, what would now
be the best tree to test to determine where we are at and what the next
steps should be to restoring the previous functionality for the Fujitsu
S7020 laptop?

Regards
  jonathan
