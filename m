From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Re: Trying to understand alsa
Date: Fri, 13 Jan 2012 01:25:32 +0000
Message-ID: <1326417932.26936.5.camel@jonspc>
References: <1326411940.23310.47.camel@jonspc>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id AFFC224498
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 02:22:06 +0100 (CET)
Received: from [10.10.10.6] (jonspc [10.10.10.6])
	by mail.jonshouse.co.uk (8.14.1/8.13.8) with ESMTP id q0D1PVus007596
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 01:25:38 GMT
In-Reply-To: <1326411940.23310.47.camel@jonspc>
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

On Thu, 2012-01-12 at 23:45 +0000, Jonathan Andrews wrote:
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

Scrub that, found it in the end ..... Im over 40, I miss plain old
manuals .....
