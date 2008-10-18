From: Erik de Castro Lopo <mle+tools@mega-nerd.com>
Subject: Re: snd_pcm_sw_params_get_xfer_align deprecated?
Date: Sun, 19 Oct 2008 08:01:05 +1100
Message-ID: <20081019080105.e980db24.mle+tools@mega-nerd.com>
References: <20081018214332.10729096.mle+la@mega-nerd.com>
	<s5h1vye2b4z.wl%tiwai@suse.de>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound.icp-qv1-irony-out3.iinet.net.au
	(outbound.icp-qv1-irony-out3.iinet.net.au [203.59.1.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B8AD10388B
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Oct 2008 23:01:26 +0200 (CEST)
Received: from hendrix (hendrix [192.168.200.99])
	by hendrix.mega-nerd.net (Postfix) with SMTP id 9C646AB125
	for <alsa-devel@alsa-project.org>; Sun, 19 Oct 2008 08:01:05 +1100 (EST)
In-Reply-To: <s5h1vye2b4z.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> At Sat, 18 Oct 2008 21:43:32 +1100,
> Erik de Castro Lopo wrote:
> > 
> > Hi all,
> > 
> > I've got some code that gives me a waring that the above function
> > is deprecated. What should I do:
> > 
> >   a) Call some other function? If so which one?
> >   b) Just drop the call to that function and everything will
> >      continue to work as it should?
> >   c) Something else?
> 
> (b).  This function always sets the value 1.

Thanks Takashi.

Cheers,
Erik
-- 
-----------------------------------------------------------------
Erik de Castro Lopo
-----------------------------------------------------------------
"Windows and MacOS are products, contrived by engineers in the service
of specific companies. Unix, by contrast, is not so much a product as
it is a painstakingly compiled oral history of the hacker subculture."
    -- N Stephenson
