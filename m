From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA's jack reporting framework map to Android
 framework
Date: Sat, 12 Jun 2010 18:05:52 +0100
Message-ID: <20100612170552.GA3110@sirena.org.uk>
References: <98769532B4BB14429434178695419EAE0426FF84AD@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9195D244B2
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Jun 2010 19:05:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE0426FF84AD@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mike Lockwood <lockwood@android.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 12, 2010 at 09:28:34AM +0530, Harsha, Priya wrote:

Please fix your MUA to word wrap your messages, it makes them more
legible and easier to reply to.

> The ALSA's jack reporting framework reports jacks at
> /dev/input/eventx. But the Android framework expects the jack reporting
> to be done in /sys/.../switch/h2w.

That ... is simply 'class' - the Android kernel includes a new sysfs
class for switches, CCing in Mike Lockwood who wrote it in case he's got
any input from the Android side.

> Any suggestions as to how  the ALSA's jack reporting framework to
> Android framework? Are there any audio  drivers that have mapped this?

The obvious thing to do here seems to be to update the Android framework
to be able to use the standard kernel interfaces.  I obviously can't
speak for Google but it seems like the sort of patch they'd be willing
to accept, especially if you retain the ability to use the non-standard
extensions that are currently being used.

I guess an alternative would be to have the Android kernels add an
adaptor in the input subsystem (for various reasons not all jack sense
goes through ALSA) so that input subsystem switches get represented via
the Android switch ABI, though that would increase the amount of out of
tree code that needs to be carried and so seems like the wrong direction
to be heading.
