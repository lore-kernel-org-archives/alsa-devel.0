From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] tlv320aic3x: headset/button press support
Date: Tue, 2 Dec 2008 19:50:19 +0000
Message-ID: <20081202195013.GA6972@sirena.org.uk>
References: <20081126220742.GA24648@buzzloop.caiaq.de>
	<20081127114951.GA3933@sirena.org.uk>
	<20081202163754.GA29550@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 934941037E3
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 20:50:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081202163754.GA29550@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 02, 2008 at 05:37:54PM +0100, Daniel Mack wrote:
> On Thu, Nov 27, 2008 at 11:50:21AM +0000, Mark Brown wrote:

> > > +#define AIC3X_HEADSET_DETECT_CELLULAR	(2 << 5)
> > > +#define AIC3X_HEADSET_DETECT_BOTH	(3 << 5)

> > What exactly is CELLULAR?  A headset?

> There is different types of headsets supported by this chip (see page 42
> of the datasheet), and this bits define which types the detection should
> be enabled for.

I *belive* it's a headset but please submit a patch adding some text
documenting this, ideally people shouldn't have to refer to the
datasheet to use the driver.

> Best regards,
> Daniel
> 
> ---
> 
> - Add aic3x_set_headset_detection() function to define the headset detection
>   mode for tlv32aic3x chips
> - added aic3x_button_pressed()
> - Read from the real-time registers in aic3x_headset_detected() to query
>   headset presence without an occured interrupt
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>

As I have repeatedly mentioned it would be very much better if you were
to do your submissions in the standard fashion which is documented in
Documentation/SubmittingPatches.  The fact that you don't do this makes
your patches more difficult to apply and doesn't encourage review.

Note in particular the --- above which causes your commit message to be
removed.
