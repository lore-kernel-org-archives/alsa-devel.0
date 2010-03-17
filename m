From: Daniel Mack <daniel@caiaq.de>
Subject: Re: How to create an Alsa mixer for a USB device w/o
 mixer descriptor?
Date: Wed, 17 Mar 2010 17:11:16 +0100
Message-ID: <20100317161116.GG30801@buzzloop.caiaq.de>
References: <4BA094B9.8010907@web.de>
	<20100317112804.GB30801@buzzloop.caiaq.de>
	<4BA0C162.5090606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 11D55103841
	for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2010 17:11:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4BA0C162.5090606@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <fexpop@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 17, 2010 at 12:47:46PM +0100, Felix Homann wrote:
> Daniel Mack schrieb:
> >Does that mean it doesn't export _any_ descriptors for that? Or just not
> >output terminal?
> >
> 
> As far as I can tell, there really is no descriptor for a mixer
> device or similar. Please, see the attached output of lsusb -v. (The
> device is mostly working with QUIRK_AUDIO_STANDARD_INTERFACE quirks.
> )

Jep, it seems so.

> Although I posted it before, you might take a look at my findings in
> the attached  reverse-engineering-...txt file. I didn't know
> anything about Audio Class devices when I gathered that information,
> and digged only a bit deeper by now. For me, it seems that the
> device is actually operated like an ordinary USB mixer (v1).

Well then I would just try it that way and see what it takes.

> >Thinking about what you're trying to achieve, I think at least one way
> >to go is to implement a new function ('handle_audio_mixer_unit_quirks'
> >for example) in sound/usb/mixer_quirks.c and call it from
> >snd_usb_create_mixer(). The function would need to return a static fake
> >descriptor, hard-coded in mixer_quirks.c. Now that the driver works with
> >structs for descriptors, that shouldn't be hard to do.
> 
> OK, I'll try to work my way through the sources. Although it's
> probably not too hard for someone familiar with Alsa and USB
> devices, it might take some time for me ;-)

It is, however, easier to implement such changes if you actually have
the device to play around with it than trying to add such quirks
blindly. So - go, give it a try :)

Daniel
