From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [PlanetCCRMA] rme hdsp pcmcia (and probably pci)
	broken
Date: Fri, 07 Dec 2007 15:27:23 -0800
Message-ID: <1197070043.32023.46.camel@cmn3.stanford.edu>
References: <1196127903.15009.34.camel@cmn3.stanford.edu>
	<4bb03be40712061531u7f0ef748ha833ce6a8bcd280e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.stanford.edu (smtp1.Stanford.EDU [171.67.22.28])
	by alsa0.perex.cz (Postfix) with ESMTP id D3629103836
	for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2007 00:27:28 +0100 (CET)
In-Reply-To: <4bb03be40712061531u7f0ef748ha833ce6a8bcd280e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Mayberry <mojofunk@gmail.com>, "Michael E. Smith" <melkhorn@gmx.de>
Cc: alsa-devel@alsa-project.org, planetccrma@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-12-07 at 09:31 +1000, Tim Mayberry wrote:
> On Nov 27, 2007 11:45 AM, Fernando Lopez-Lezcano
> <nando@ccrma.stanford.edu> wrote:
> > Hi, anyone has a pcmcia rme card running? And working? With a reasonably
> > recent alsa? (this probably applies also for the regular pci rme cards,
> > I've had reports on the Planet CCRMA list about problems that sound
> > similar to this one).
> >
> 
> I have a RME Hammerfall HDSP PCI card with a Multiface unit which was
> working fine with Fedora 7. When I upgraded to Fedora 8 recently it
> stopped working properly. I discovered I could get sound out of it
> using aplay with a mono sound file as it seemed to send the mono input
> to all outputs but playing a stereo file would not play out the first
> two analog outputs like it did with Fedora 7(I couldn't tell where the
> output was going).

I just released a newer kernel with a patch that (probably) fixes the
rme problems. Let me know how it goes!

Enjoy!
-- Fernando
