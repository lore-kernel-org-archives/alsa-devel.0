From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: caiaq driver: audio 4 dj and jackd
Date: Mon, 2 Dec 2013 19:48:57 +0000
Message-ID: <201312021948.58167.gineera@aspect135.co.uk>
References: <529BF843.6000608@gmail.com> <529CAE8D.6020003@zonque.org>
 <529CB1F6.7070607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net
 [62.24.128.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F603265068
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 20:42:08 +0100 (CET)
In-Reply-To: <529CB1F6.7070607@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Monday 02 December 2013 16:14, Gabriel M. Beddingfield wrote:
> On 12/02/2013 08:00 AM, Daniel Mack wrote:
> >> TBH, the whole substream concept is lost on me.  Where does this
> >> guarantee come from?  From the substream concept or from intimate
> >> knowledge of this device?
> >
> > Both :)

<snip>

> > What are your results with the multi plugin? Is that something you can
> > live with?
>
> I don't actually have one of these devices and the end-user I was
> helping is happy now, AFAIK.
>
> But solving this required editing asoundrc files (ugh) and casting
> several magic spells.  Would be nice if it "just works."

The same problem occurs with Portaudio on this device (or similar) - it would 
be great to just be able to open one device with 4 channels, or 2 stereo 
pairs.

I had wondered whether it could be done by some card-specific definitions in 
eg /usr/share/alsa/cards as is done particularly with PCI cards??  Anybody 
any ideas?

Gabriel, could you post the multi pcm you worked out for this, as it may help 
others?

Regards

Alan
