From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sun, 20 Apr 2008 02:00:51 +0200
Message-ID: <20080420000051.GA20381@tango.0pointer.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<s5h8wzf4e35.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 8ECA6243FA
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Apr 2008 02:00:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h8wzf4e35.wl%tiwai@suse.de>
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

On Tue, 15.04.08 12:17, Takashi Iwai (tiwai@suse.de) wrote:

> > Now the thing is, this mostly works fine, however on one of my
> > devices, a pair of external Logitech USB speakers (ID 046d:0a04
> > Logitech, Inc. V20 portable speakers), the dB scale seems to be
> > totally bogus. According to ALSA volume ranges from -41 dB to
> > +3dB. However, Every setting > -41 dB makes audio awfully
> > loud. Really, really fucking loud that is. Disco loud. As loud that
> > the speakers start jump around centimeters due to the massive
> > vibrations. Setting the volume to 0dB with those speakers really makes
> > you fear you are trashing them.
> 
> This is typically a problem of your usb hardware.  The USB descriptor
> gives the dB level information and the usb-audio driver simply passes
> the given data as dB scale information.  But, the hardware actually
> doesn't behave as it states.  Unfortunately a frequent problem with
> cheap USB audio devices.
> 
> So, it's definitely no universal ALSA problem.  Please don't mix up.

My understanding is that the dB values of this USB device are relative          
to its maximum gain, and as such consistent in itself. Does the USB
spec define the reference level for the dB values?       

If not there's probably nothing wrong with the USB device. However,
then I guess I am doomed with my task to find good defaults in a
generic way for mixer controls.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
