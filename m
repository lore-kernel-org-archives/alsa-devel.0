From: Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH] Provide card number / PID via sequencer
 client	info
Date: Tue, 16 Feb 2016 09:03:34 +0100
Message-ID: <20160216080334.GA15116@mail.zuhause>
References: <1455370937-501-1-git-send-email-martin@mail.zuhause>
 <1455370937-501-3-git-send-email-martin@mail.zuhause>
 <s5htwlab70o.wl-tiwai@suse.de>
 <20160215183243.GA26482@mail.zuhause>
 <s5hziv194gz.wl-tiwai@suse.de>
 <20160215214454.GA11052@mail.zuhause>
 <s5hsi0t8uxq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe04-2.mx.upcmail.net
 (vie01a-dmta-pe04-2.mx.upcmail.net [62.179.121.164])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F7A62606E6
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 09:03:37 +0100 (CET)
Received: from [172.31.216.43] (helo=vie01a-pemc-psmtp-pe01)
 by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1aVabg-0001BT-Pt
 for alsa-devel@alsa-project.org; Tue, 16 Feb 2016 09:03:36 +0100
Content-Disposition: inline
In-Reply-To: <s5hsi0t8uxq.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Martin Koegler <martin.koegler@chello.at>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 15, 2016 at 11:34:09PM +0100, Takashi Iwai wrote:
> > On Mon, Feb 15, 2016 at 08:08:12PM +0100, Takashi Iwai wrote:
> > > On Mon, 15 Feb 2016 19:32:43 +0100,
> > > Martin Koegler wrote:
> > > > 
> > > > On Mon, Feb 15, 2016 at 11:30:15AM +0100, Takashi Iwai wrote:
> > > > > The idea looks good.  One remaining question is whether only providing
> > > > > the card number or pid is sufficient for all cases.
> > > > 
> > > > I only care about the kernel client. 
> > > 
> > > Well, the question is whether only card number is enough.  What if
> > > cards provide multiple rawmidi devices?
> > 
> > Aren't they currently ports?
> > seq_midi.c creates just one sequencer device per card number.
> 
> Look at cards with synth support, e.g. emu10k1 or OPL3/OPL4.

Should I export the client_index parameter of snd_seq_create_kernel_client too?

Regards,
Martin
