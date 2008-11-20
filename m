From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC, TWL4030 Register defaults
Date: Thu, 20 Nov 2008 12:49:12 +0000
Message-ID: <20081120124910.GC4539@sirena.org.uk>
References: <ef0d8a250811200319kd1afdf8r74d09d54e37b830c@mail.gmail.com>
	<20081120112304.GB4539@sirena.org.uk>
	<ef0d8a250811200351x3d18ea1fm58e9dac3613aeea9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C95D524359
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 13:49:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ef0d8a250811200351x3d18ea1fm58e9dac3613aeea9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 05:21:11PM +0530, naveen krishna ch wrote:
> On Thu, Nov 20, 2008 at 4:53 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> > As I said in reply to your first mail I'd really like to see some sort
> > of explanation as to why you are making these changes - are the defaults
> > in the existing driver wrong?  There seem to be an awful lot of changes
> > here and there's no discussion in the patch as to what they mean.

> The existing driver does the default settings for only one input device
> (Line in) and one output device (Headset out).
> The CODEC supports 5 output devices and 4 input devices.

Thanks for the detail here - this really should go in the changelog for
your patch so people reviewing the history of the driver can see what's
happened.

> The default values given by the drivers author are according to his custom
> requirements, expanding them to the CODEC's ability these values can be
> modified.

> What all this patch is doing is setting the default playback and capture
> volumes of various input and output devices to reasonable values.

It is perfectly normal for the default configuration of codecs to not be
suitable for use on a given platform, normally the codec will have the
power on defaults in silicon.  Systems should use something like alsactl
restore to set things up appropriately for their system during startup.
