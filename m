From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: hw_params ignores ioplug's buffer size requirements
Date: Wed, 8 Aug 2012 09:51:42 -0500
Message-ID: <20120808145142.GO2424@foghorn.codeweavers.com>
References: <20120807143211.GM2424@foghorn.codeweavers.com>
 <s5h4noehekq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 5071C26613E
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2012 16:21:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4noehekq.wl%tiwai@suse.de>
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
Cc: Andrew Eikum <aeikum@codeweavers.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 07, 2012 at 06:06:13PM +0200, Takashi Iwai wrote:
> At Tue, 7 Aug 2012 09:32:11 -0500,
> Andrew Eikum wrote:
> > There is also test client, alsa-test.c, which attempts to violate
> > those hw_params restrictions, and succeeds! The eventual call to the
> > ioplug's example_hw_params() callback gets an invalid buffer_size
> > parameter (it happens to be 512).
> 
> Why is it wrong?  512 frames = 512 * 2 channel * 2 bytes-per-sample
>  = 2048 bytes.
> 
> I guess you are confused about the units passed to
> snd_pcm_hw_params_set_buffer_size_near().  It's in frames, not in
> bytes.
> 

Yeah, you're right. I should've noticed the type for that parameter.
Thanks for pointing it out, sorry for the noise.

Andrew
