From: Touko Korpela <touko.korpela@iki.fi>
Subject: Re: No sound on Asus EeePC 1215b (hda-intel)
Date: Sun, 4 Sep 2011 16:15:57 +0300
Message-ID: <20110904131557.GA25946@tiikeri.vuoristo.local>
References: <20110829115005.GA2937@lisko> <20110831203045.GA12513@lisko>
	<4E5E9C9A.8090908@ladisch.de>
	<20110831220806.GA16753@tiikeri.vuoristo.local>
	<4E5F4DEF.3070602@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
	[83.102.40.132]) by alsa0.perex.cz (Postfix) with ESMTP id EB2742441F
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Sep 2011 15:16:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E5F4DEF.3070602@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, debian-user@lists.debian.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 01, 2011 at 11:18:39AM +0200, David Henningsson wrote:
> On 09/01/2011 12:08 AM, Touko Korpela wrote:
> >On Wed, Aug 31, 2011 at 10:42:02PM +0200, Clemens Ladisch wrote:
> >>Touko Korpela wrote:
> >>>>No sound is heard (but mixer is not muted).
> >>>>Shouldn't mixer have more channels to adjust?
> >>>
> >>>00:01.1 Audio device: ATI Technologies Inc Device 1314
> >>>00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA) (rev 40)
> >>
> >>Your default sound device is the device that happened to be detected
> >>first, which is your GPU's HDMI output.
> >>
> >>Tell whatever sound configuration tool is used in your distribution to
> >>use the other sound device.
> >
> >Shouldn't that be hidden when HDMI cable is not plugged (like now)?
> 
> I'm working on hiding exactly that at the UI level (gnome/pulseaudio
> level rather than ALSA), but that is a long-term goal and not all
> pieces are into place yet.
> 
> >Does this kind of system work for someone?
> 
> A very similar machine, Asus 1215P [1], was enabled by the team I'm
> involved with, so yes, it definitely works for someone, and it would
> surprise me if it does not work out of the box from an Ubuntu 11.10
> Beta Live-CD even though the link says "pre-install only".
> 
> You could try this terminal command:
> 
> speaker-test -D plughw:SB -c 2 -t sine
> 
> And see if that outputs sound (try both headphones and internal speakers).

I tested that command and it works. Now just have to figure out the right
way to select default sound output device (on Debian). Ideally it should
work automatically.
