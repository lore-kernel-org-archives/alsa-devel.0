From: Daniel Mack <daniel@caiaq.de>
Subject: Re: How to create an Alsa mixer for a USB device w/o
 mixer descriptor?
Date: Wed, 17 Mar 2010 12:28:04 +0100
Message-ID: <20100317112804.GB30801@buzzloop.caiaq.de>
References: <4BA094B9.8010907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1744C10381A
	for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2010 12:28:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4BA094B9.8010907@web.de>
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

On Wed, Mar 17, 2010 at 09:37:13AM +0100, Felix Homann wrote:
> as posted earlier, I've got a USB device (Fast Track Ultra 8R) wich 
> *has* a mixer unit but doesn't have a descriptor for it. It's operated 
> by standard control messages. Although I'm specifically interested in 
> my  device, I guess there are many more USB interfaces out there with 
> similar issues.

Does that mean it doesn't export _any_ descriptors for that? Or just not
output terminal?

> So in general:
> What's the best way to build a Alsa mixer for such devices. Should one 
> bypass all the descriptor parsing and build a mixer specifically for the 
> device in interest? Or should one think about  passing a "fake" 
> descriptor to the mixer build process?

Check out the latest USB audio sources from the ALSA git - they have
been undergoing a major refactoring lately.

Thinking about what you're trying to achieve, I think at least one way
to go is to implement a new function ('handle_audio_mixer_unit_quirks'
for example) in sound/usb/mixer_quirks.c and call it from
snd_usb_create_mixer(). The function would need to return a static fake
descriptor, hard-coded in mixer_quirks.c. Now that the driver works with
structs for descriptors, that shouldn't be hard to do.

One thing to pay attention to is that this fake descriptor must not have
any references to other entities or descriptors of the device unless you
take care for them, too. In particular, you would need to add a hook to
snd_usb_copy_string_descriptor() if you want to give your controls a
name.

Hope that helps,
Daniel
