From: "Tim Mayberry" <mojofunk@gmail.com>
Subject: Re: rme hdsp pcmcia (and probably pci) broken
Date: Fri, 7 Dec 2007 09:31:06 +1000
Message-ID: <4bb03be40712061531u7f0ef748ha833ce6a8bcd280e@mail.gmail.com>
References: <1196127903.15009.34.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <planetccrma-admin@ccrma.Stanford.EDU>
In-Reply-To: <1196127903.15009.34.camel@cmn3.stanford.edu>
Content-Disposition: inline
Sender: planetccrma-admin@ccrma.Stanford.EDU
Errors-To: planetccrma-admin@ccrma.Stanford.EDU
List-Help: <mailto:planetccrma-request@ccrma.stanford.edu?subject=help>
List-Post: <mailto:planetccrma@ccrma.stanford.edu>
List-Subscribe: <http://ccrma-mail.stanford.edu/mailman/listinfo/planetccrma>,
	<mailto:planetccrma-request@ccrma.stanford.edu?subject=subscribe>
List-Unsubscribe: <http://ccrma-mail.stanford.edu/mailman/listinfo/planetccrma>,
	<mailto:planetccrma-request@ccrma.stanford.edu?subject=unsubscribe>
List-Archive: <http://ccrma-mail.stanford.edu/pipermail/planetccrma/>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@alsa-project.org, planetccrma@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

On Nov 27, 2007 11:45 AM, Fernando Lopez-Lezcano
<nando@ccrma.stanford.edu> wrote:
> Hi, anyone has a pcmcia rme card running? And working? With a reasonably
> recent alsa? (this probably applies also for the regular pci rme cards,
> I've had reports on the Planet CCRMA list about problems that sound
> similar to this one).
>

I have a RME Hammerfall HDSP PCI card with a Multiface unit which was
working fine with Fedora 7. When I upgraded to Fedora 8 recently it
stopped working properly. I discovered I could get sound out of it
using aplay with a mono sound file as it seemed to send the mono input
to all outputs but playing a stereo file would not play out the first
two analog outputs like it did with Fedora 7(I couldn't tell where the
output was going).

Reverting to the stock F7 kernel returned functionality to normal so I
downloaded the source packages for the F7 and F8 kernels and had a
quick peek. They both seem to be using the same upstream kernel source
but with different patch sets applied. The Fedora 8 kernel source
contains a ~1MB alsa patch that I imagine has something to do with the
breakage.

Tim.
