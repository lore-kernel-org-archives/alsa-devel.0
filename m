From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Fri, 22 Feb 2013 09:02:19 +1030
Message-ID: <20130221223219.GA31006@marvin.atrad.com.au>
References: <s5h8v6ncpcp.wl%tiwai@suse.de>
 <20130217125316.GA25824@marvin.atrad.com.au>
 <s5h1ucedgge.wl%tiwai@suse.de> <s5hzjyzi8a5.wl%tiwai@suse.de>
 <20130220121055.GA23804@marvin.atrad.com.au>
 <s5hip5ni0ur.wl%tiwai@suse.de>
 <20130221121540.GA11524@marvin.atrad.com.au>
 <CAN8ccibAsWUVCcEem-ykcouJ6RXEG8k-eq9mPf7VV7qPied6nw@mail.gmail.com>
 <20130221135230.GA12678@marvin.atrad.com.au>
 <CAN8cciYK=o_bEW-u63+U-hOj6mYtypQ63vwVv2u7foicNr98cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C573261644
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 23:32:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAN8cciYK=o_bEW-u63+U-hOj6mYtypQ63vwVv2u7foicNr98cQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, jwoithe@just42.net, peter.golden@btinternet.com, ullinux@ymail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 21, 2013 at 10:01:58PM +0800, Raymond Yau wrote:
> > >
> > > Can you confirm that the speaker really need this patch to work ?
> > >
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=978e77e78cff7a85a31ad552ffd8afee319e8721
> >
> > No.  The speaker required this patch:
> >
> > http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=e6e0ee507f630350d883bb3343e78cab30cad5e2
> 
> Is this patch also need ?
> 
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=39aedee7a1cc3c72d68674ff6ff142299fa0897b

In the context of the code currently in sound-unstable, I'm not sure.  At
the time it was committed the setting of add_out_jack_modes was certainly
useful since having access to that control is definitely needed on this
model given that line out and headphone share a physical jack.  Whether it's
still necessary to explicitly turn on the HP amp of node 0x10 given
Takashi's latest changes I'm not sure.  I suspect it is.

To summarise: I expect this patch is still relevant.  However, I will try to
explicitly check this and let you know.

Regards
  jonathan
