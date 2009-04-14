From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Correct the DSP_B
 mode
Date: Tue, 14 Apr 2009 15:58:07 +0300
Message-ID: <20090414155807.6e485341.jarkko.nikula@nokia.com>
References: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090414120221.f0e89499.jarkko.nikula@nokia.com>
	<20090414093133.GB12678@sirena.org.uk>
	<200904141334.33497.peter.ujfalusi@nokia.com>
	<20090414142004.fee14e30.jarkko.nikula@nokia.com>
	<dfeb90390904140432o1edb7892hbede4e9014f6dc81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id E92D824367
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:57:26 +0200 (CEST)
In-Reply-To: <dfeb90390904140432o1edb7892hbede4e9014f6dc81@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Arun KS <getarunks@gmail.com>
Cc: "ext@alsa-project.org" <ext@alsa-project.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Apr 2009 13:32:45 +0200
ext Arun KS <getarunks@gmail.com> wrote:

> Hi,
> 
> I m not able to use my osk5912 to test this.
> When i do an aplay with the latest kernel (linux-2.6.30-rc1) i am
> getting an me i/o error.
> 
Are you using mainline or linux-omap? It seems that linux-omap is somewhat broken at the moment. I got Beagle working by going back into commit 823de921c923cc753a6746183e9c513a3452dec7 but not yet figured out one for N810...


Jarkko
