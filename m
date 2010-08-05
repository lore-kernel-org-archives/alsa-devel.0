From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Intel HDMI audio stops after 15 minutes
Date: Thu, 5 Aug 2010 09:02:59 +0800
Message-ID: <20100805010259.GA6079@localhost>
References: <20100804173509.GA12328@csy.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id A87EC243C0
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 03:03:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100804173509.GA12328@csy.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shane W <shane-alsa@csy.ca>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 05, 2010 at 01:35:09AM +0800, Shane W wrote:
> Hey all,
> 
> On my Intel DG45 mainboard (Yamaha RX-v1800 receiver) I am
> now only getting audio for about 15 minutes before it stops
> and I have to restart the X server. Playing a movie with
> audio works fine but playing an mp3 has the cutout. Is
> there a new power saving mode or the like that has crept
> in?

Did the screen go off at the same time?

I was also fighting with it with a bunch of options 

Section "Monitor"
        Identifier      "Configured Monitor"
        option          "DPMS"  "false"
EndSection

Section "ServerFlags"
        #                       minutes
        Option "BlankTime"      "100"
        Option "StandbyTime"    "300"
        Option "SuspendTime"    "400"
        Option "OffTime"        "500"
EndSection

Thanks,
Fengguang
