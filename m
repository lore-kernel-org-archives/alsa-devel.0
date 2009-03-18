From: "Medisetty, Naresh" <naresh@ti.com>
Subject: Re: [PATCH 0/9] ARM: DaVinci: ASoC: Adds Audio	support
 for TI DM646X
Date: Wed, 18 Mar 2009 18:02:01 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B67017069809B09D@dbde02.ent.ti.com>
References: <1237204854-29989-1-git-send-email-naresh@ti.com>,
	<20090316153855.GI16539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BCD81037EC
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 13:33:41 +0100 (CET)
In-Reply-To: <20090316153855.GI16539@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

Mark,



Thanks for the review.



I will re-submit the series by taking care of  your comments.



> -----Original Message-----
> From: naresh [mailto:x0090427@ti.com]
> Sent: Wednesday, March 18, 2009 5:50 PM
> To: 'naresh@ti.com'<mailto:'naresh@ti.com'>
> Subject:
>
> On Mon, Mar 16, 2009 at 08:00:54AM -0400, Naresh Medisetty wrote:
> > Adds Audio support for TI DM646X EVM platform
>
> > Signed-off-by: Naresh Medisetty <naresh@ti.com<mailto:naresh@ti.com>>
>
> I'm broadly OK with anything I haven't specifically commented on here.
> However, the ASoC bits of the series need to be updated to reflect the
> current ASoC APIs.  Some additional documentation for your changes to
> the EVM would be very helpful.



I will take elaborate the documentation while re-submitting the patches



>
> It would also be very much better if you could restructure the series
> to
> reflect the changes you're making.  You're actually doing three things:
>
>  - Add support for a dummy codec.
>  - Add support for the McASP port on the DaVinci.
>  - Update the DaVinci EVM driver to use these two things on relevant
>    EVMs.
>
> and the series should be structured to reflect this.  The codec and EVM
> support should each go in a single patch by themselves.  The McASP
> support is big enough to be broken down but it does need to come before
> the EVM support that uses it.



I will structure the series according to this.
