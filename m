From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH0/2] jack: Add support for SND_JACK_LINEOUT
Date: Tue, 21 Oct 2008 21:03:23 +0100
Message-ID: <20081021200323.GA9405@sirena.org.uk>
References: <48FCFAA8.8070005@embeddedalley.com>
	<20081021084806.GC10841@sirena.org.uk>
	<48FDF318.8050502@embeddedalley.com>
	<20081021193626.GA6900@sirena.org.uk>
	<48FE309B.5070003@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C43C243BC
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 22:03:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48FE309B.5070003@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew Ranostay <mranostay@embeddedalley.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 21, 2008 at 03:42:19PM -0400, Matthew Ranostay wrote:
> Mark Brown wrote:

> > What do you mean by a "mixer switch"?  Do you just mean a software
> > control that can select between line and headphone signals?

> Yeah, when it's a line out it doesn't mute the other lineouts.

> > Is the
> > hardware able to determine which kind of device is connected to the
> > jack?

> Yes with the AC_VERB_GET_PIN_WIDGET_CONTROL verb being read when reporting the
> jack status.

OK, that's exactly the case I was describing before: it's a jack with
independant line and headphone functions that is able to distinguish
between the two.  The switching isn't particularly relevant to the
function of the jack here, it's a natural feature of the jack API - if
the hardware could also determine if a microphone were connected to the
jack and be configured appropriately then it could also report that.
