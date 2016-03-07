From: Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH v2 1/3] ALSA: seq: Provide card number /
	PID	via sequencer client info
Date: Mon, 7 Mar 2016 22:13:05 +0100
Message-ID: <20160307211305.GA24681@mail.zuhause>
References: <1456943188-29600-1-git-send-email-martin@mail.zuhause>
 <1456943188-29600-3-git-send-email-martin@mail.zuhause>
 <s5h37s7sxq3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe04-1.mx.upcmail.net
 (vie01a-dmta-pe04-1.mx.upcmail.net [62.179.121.163])
 by alsa0.perex.cz (Postfix) with ESMTP id C0EE926154F
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 22:13:07 +0100 (CET)
Received: from [172.31.216.43] (helo=vie01a-pemc-psmtp-pe01)
 by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1ad2Sh-0006Z1-I4
 for alsa-devel@alsa-project.org; Mon, 07 Mar 2016 22:13:07 +0100
Content-Disposition: inline
In-Reply-To: <s5h37s7sxq3.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Martin Koegler <martin.koegler@chello.at>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 03, 2016 at 10:43:32AM +0100, Takashi Iwai wrote:
> > From: Martin Koegler <martin.koegler@chello.at>
> > 
> > rawmidi devices expose the card number via IOCTLs, which allows to
> > find the corresponding device in sysfs.
> > 
> > The sequencer provides no identifing data. Chromium works around this
> > issue by scanning rawmidi as well as sequencer devices and matching
> > them by using assumtions, how the kernel register sequencer devices.
> > 
> > This changes adds support for exposing the card number for kernel clients
> > as well as the PID for user client.
> > 
> > The minor of the API version is changed to distinguish between the zero
> > initialised reserved field and card number 0.
> > 
> > Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> 
> This ABI change itself looks simple enough, so I have no big problem
> to merge if you can convince other people with it :)
> 
> Clemens?

The current solution has been proposed by him:
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-February/104175.html

Regards,
Martin
