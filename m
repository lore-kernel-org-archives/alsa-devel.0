From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Gentoo alsa output
Date: Sun, 21 Mar 2010 20:41:32 +0800
Message-ID: <20100321124132.GA7308@localhost>
References: <4BA5E45A.6020703@cdstealer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 2758A10382F
	for <alsa-devel@alsa-project.org>; Sun, 21 Mar 2010 13:41:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4BA5E45A.6020703@cdstealer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: cdstealer <cdstealer@cdstealer.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shane W <shane-alsa@csy.ca>
List-Id: alsa-devel@alsa-project.org

Hi cdstealer,

It looks all sane with HDMI audio. Would you verify HDMI playback with
command

        speaker-test -Dhw:0,3 -c8 -twav

?

Or are there any more concerns?

Thanks,
Fengguang

On Sun, Mar 21, 2010 at 05:18:18PM +0800, cdstealer wrote:
> Hi fengguang,
>     Many thanks for jumping on this.  I have run the script and uploaded the result to:
> 
> http://www.alsa-project.org/db/?f=dbfb35a717aebac5b2650fb9dcf649e1a031ebc0
> 
> If you need anything further, please don't hesitate to contact me.
> 
> Kind regards
> Steve
