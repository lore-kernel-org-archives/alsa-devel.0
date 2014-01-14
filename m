From: Daniel Mack <daniel@zonque.org>
Subject: Re: [ISSUE] crackles and clicks
Date: Tue, 14 Jan 2014 17:08:54 +0100
Message-ID: <52D56116.2060407@zonque.org>
References: <CA+T9nP9VBdW6T8o3=5hFJpMXpHGz59VOGva2+8g8xoPw6Xa8+g@mail.gmail.com>
 <s5hy52kt71z.wl%tiwai@suse.de>
 <89F8E4011FD7234ABFE48744E300CBC206BC3EF2@041-DB3MPN1-093.041d.mgd.msft.net>
 <20140114144224.GC23764@tamtam.fritz.box>
 <89F8E4011FD7234ABFE48744E300CBC206BC449B@041-DB3MPN1-093.041d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id D41E7261AED
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 17:08:55 +0100 (CET)
In-Reply-To: <89F8E4011FD7234ABFE48744E300CBC206BC449B@041-DB3MPN1-093.041d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: LANGLOIS Olivier PIS -EXT <olivier.pis.langlois@transport.alstom.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 01/14/2014 04:59 PM, LANGLOIS Olivier PIS -EXT wrote:
> I experience the audible clicks with VLC but I have reproduced it 
> with aplay as well. The clicks that I hear corresponds to underruns.
>  For the records, this is not happening with a USB device. I have a 
> Intel HDA sound card.

Ok, sorry. I missed that detail.

> I did chime in the discussion to point out that
> the problem could come from something else than ALSA or the sound
> card driver. Here is the output of my aplay session. This makes me
> doubt my hypothesis. I'll check the cpu usage while the Wifi is on
> but not connected or see if running aplay in real-time prio makes 
> things any better.

I see, and I'd say that's a sign that the wifi driver is holding off the
system way too long somewhere, rather than a problem with the sound driver.

Could you repost your findings from the earlier mail and send them to
Larry.Finger@lwfinger.net and linux-wireless@vger.kernel.org? The
wireless people might have an idea what's going on.


Daniel
