From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: Trying to understand alsa
Date: Fri, 13 Jan 2012 09:10:58 -0600
Message-ID: <20120113151058.GG24575@foghorn.codeweavers.com>
References: <1326404651.22083.28.camel@jonspc>
	<20120112221218.GE24575@foghorn.codeweavers.com>
	<1326410207.23310.17.camel@jonspc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
	by alsa0.perex.cz (Postfix) with ESMTP id BFC002412E
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 16:11:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326410207.23310.17.camel@jonspc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Andrews <jon@jonshouse.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 12, 2012 at 11:16:47PM +0000, Jonathan Andrews wrote:
> On Thu, 2012-01-12 at 16:12 -0600, Andrew Eikum wrote:
> > On Thu, Jan 12, 2012 at 09:44:11PM +0000, Jonathan Andrews wrote:
> > > I have an application that works using 512 sample packets of 22050Hz 16
> > > bit mono audio.  The 'receiver' takes many audio streams from a network
> > > via UDP, at the moment it pipes them into pulse.
> > > 
> > > Can alsa buffer audio. At the moment every time I and set an audio
> > > buffer size I get a negative response from
> > > snd_pcm_hw_params_set_buffer_size .  I'm somewhat confused about the
> > > units alsa uses ...
> > > 
> > 
> > You don't want to over-specify your requirements. You require a buffer
> > size of "at least" 3 * 512 frames. So use set_buffer_size_min().
> 
> I cant find any reference to "set_buffer_size_min" in the ALSA API
> documentation I have or the link you provided ?
> snd_pcm_hw_params_set_buffer_time_near() is the closest and that seems
> to take an argument in useconds.  
> ?
> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html
> 

The doxygen docs are split strangely. The function is documented here:
http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.html#gb8d160039ffbbb15cb7187aa9ffae462

I find keeping the alsa-lib source on hand for quick grepping is often
helpful.

Andrew
