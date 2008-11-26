From: karl@lil-voodoo.co.uk
Subject: Alsa Driver Development - General Concepts
Date: Wed, 26 Nov 2008 15:48:26 -0000 (UTC)
Message-ID: <42406.12.4.27.248.1227714506.squirrel@www.lil-voodoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from harpoon.unitedhosting.co.uk (harpoon.unitedhosting.co.uk
	[83.223.124.227])
	by alsa0.perex.cz (Postfix) with ESMTP id D2C5524713
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 16:48:27 +0100 (CET)
Received: from www.lil-voodoo.co.uk (localhost.localdomain [127.0.0.1])
	by harpoon.unitedhosting.co.uk (8.13.1/8.13.1) with ESMTP id
	mAQFmQSr008739
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 15:48:26 GMT
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

Hi,

I've got a couple of audio/midi devices knocking around that I'd quite
like to add ALSA support for (for use in Linux sequencers/DAWs) so I've
been reading up on Linux device drivers and Alsa driver development.

I do have a programming background but unfortunately, I'm a little
confused on a couple of points and I was hoping someone wouldn't mind
helping me out.

I'm kind of basing my thoughts on the idea that I have a USB device which
is not recognised by the kernel and does not expose a known midi interface
(so requires a completely new Alsa driver?). The goal would be for this
device to be usable in Linux midi sequencers.

- How does the Alsa driver communicate with the hardware? Would I need to
write a Kernel driver (e.g. a character device) for the Alsa driver to
talk to?

- Would my Alsa driver basically create a card instance and then a RawMidi
component? I'm assuming the use of RawMidi would then allow applications
to recognise the Alsa driver as a seemingly ordinary midi port??? Then
implement _input_trigger() and _output_trigger() to exchange data with the
application, whilst passing data to/from the kernel driver to talk to the
hardware?

Sorry if I'm way off base. I'm trying to get in on this thing to help
spread some extra Linux love in music world.

Many thanks.
