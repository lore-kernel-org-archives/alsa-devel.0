From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/6] linux/usb/audio.h: split header
Date: Thu, 11 Mar 2010 18:55:26 -0800
Message-ID: <20100312025526.GA30094@suse.de>
References: <1268338405-8944-1-git-send-email-daniel@caiaq.de>
	<1268338405-8944-2-git-send-email-daniel@caiaq.de>
	<20100311201748.GG28972@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 811D724441
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 03:59:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100311201748.GG28972@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 11, 2010 at 09:17:48PM +0100, Daniel Mack wrote:
> On Thu, Mar 11, 2010 at 09:13:20PM +0100, Daniel Mack wrote:
> > - Split the audio.h file in two to clearly denote the differences
> >   between the standards.
> > - Add many more defines to audio-v2.h. Most of them are not currently
> >   used.
> > - Replaced a magic value with a proper define
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Cc: Clemens Ladisch <clemens@ladisch.de>
> > Cc: Takashi Iwai <tiwai@suse.de>
> 
> Sorry Greg, I forgot to Cc: you on this.
> 
> As the patch touch both the include files and audio code, it would go
> thru the ALSA channel again if you don't mind.

No objection from me:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

thanks,

greg k-h
