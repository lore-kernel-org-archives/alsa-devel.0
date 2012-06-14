From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ALSA: hda: support for wallclock
	timestamps
Date: Wed, 13 Jun 2012 23:57:59 -0500
Message-ID: <4FD96F57.3090502@linux.intel.com>
References: <1339619192-2733-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<1339619192-2733-3-git-send-email-pierre-louis.bossart@linux.intel.com>
	<CA+v+29goT9xmx-h4Fuiyg6wuZFCvBvuFx=1P_=e8CfqoQFahMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E7BB244AD
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2012 06:58:02 +0200 (CEST)
In-Reply-To: <CA+v+29goT9xmx-h4Fuiyg6wuZFCvBvuFx=1P_=e8CfqoQFahMA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/13/2012 10:32 PM, Wang Xingchao wrote:
> I'm afraid you donot think much about the Wall Clock Counter register, 
> the counter will roll over to 0 within 179s under 24Mhz. Another case 
> maybe BCLK stop and controller reset. thanks --xingchao

Hi Xingchao,
all cycle counters will wrap around at some point, the HDAudio wall 
clock isn't an exception. As long as you have 2 periods or events per 
179s, the wrap-around can be detected without any issues. It's 
explicitely handled in the code.
If the BCLK stops, then there's no real audio transfer happening, is 
there? Likewise the controller reset does not matter since we re-init 
during a trigger.
I don't see any of these points as show-stoppers. The HDAudio spec 
clearly mentions that such a wall clock should be used for 
synchronization with other devices, and I am enabling just that.
Regards,
-Pierre
