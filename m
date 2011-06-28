From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Jack event API - decision needed
Date: Tue, 28 Jun 2011 17:27:15 +0100
Message-ID: <4E0A00E3.5000102@canonical.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110627120743.GA20707@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id DE83110388E
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jun 2011 18:27:17 +0200 (CEST)
In-Reply-To: <20110627120743.GA20707@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On 2011-06-27 13:07, Mark Brown wrote:
> On Mon, Jun 20, 2011 at 03:37:25PM +0200, David Henningsson wrote:
>
>> 1) We're continuing the path with /dev/input devices
>
>> 2a) We'll rewrite these devices to be read-only ALSA mixer controls
>
>> 2b) We'll rewrite these devices to be something within ALSA, but not
>> exactly mixer controls.
>
>> For options 2a) and 2b) I guess the existing /dev/input thing should be
>> deprecated and/or removed. So part of decision should maybe be based on
>> information about how widespread the usage of these devices are
>> currently...?
>
> So, this discussion seems to have ground to a halt.

Yes, unfortunately, and without a clear consensus. That puts me in a 
difficult position, because I'm trying to get the job done. And very 
preferrable, in the next release of Ubuntu (which is to be released on 
October this year). I've been talking to a few of my colleagues here at 
Canonical, and here's how we reason currently:

We have the input layer. We also have a set of patches for supporting 
this in PulseAudio (although currently unmerged and I'm not sure about 
their current quality/state).
We don't have the alternative Alsa Control API discussed in this thread. 
Without taking a stance of whether that would be a better solution or 
not, designing it will take some time - somewhat depending on the set of 
problems we're aiming to solve. Regardless, it will definitely not reach 
the 3.0 kernel (which is what we will ship in the next release of Ubuntu).

As such, it makes the most sense for me to continue working on the 
existing input layer API for the time being. If or when a new API is 
announced and finished, rewriting the pulseaudio patches to target that 
API will probably make sense. But we're not there today, and the time 
schedule for getting there is unknown.

If upstream udev/PulseAudio would be willing to merge my (existing and 
upcoming) patches, I would appreciate that, as I believe that would make 
both our lives easier. If not, well at least make a note that I /tried/ 
to do things the right way, and to make everybody happy - which is not 
always possible.

-- 
David Henningsson
http://launchpad.net/~diwic
