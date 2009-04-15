From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 1/2] keywest: Convert to new-style i2c
	driver
Date: Wed, 15 Apr 2009 09:20:57 +0200
Message-ID: <20090415092057.52542464@hyperion.delvare>
References: <20090410170726.3616b6d5@hyperion.delvare>
	<18917.26938.10873.119892@drongo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id B8665243A1
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 09:21:08 +0200 (CEST)
In-Reply-To: <18917.26938.10873.119892@drongo.ozlabs.ibm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Paul,

On Wed, 15 Apr 2009 14:57:30 +1000, Paul Mackerras wrote:
> Jean Delvare writes:
> 
> > The legacy i2c binding model is going away soon,
> 
> But not before 2.6.30, right?

Ideally, yes, before 2.6.30. This is what
Documentation/feature-removal-schedule.txt says:

---------------------------

What:	i2c_attach_client(), i2c_detach_client(), i2c_driver->detach_client(),
	i2c_adapter->client_register(), i2c_adapter->client_unregister
When:	2.6.30
Check:	i2c_attach_client i2c_detach_client
Why:	Deprecated by the new (standard) device driver binding model. Use
	i2c_driver->probe() and ->remove() instead.
Who:	Jean Delvare <khali@linux-fr.org>

---------------------------

There are only 10 legacy i2c drivers remaining (not counting staging),
9 of which are ppc drivers. My hope was that ppc developers would see
the deprecation warning and convert the drivers themselves, but it did
not happen. Which is why I am trying to do it myself now, admittedly
quite late in the 2.6.30 development cycle.

This seems doable to me if my patches get proper testing fast (which
seems to be the case, thanks!) and positive results (not true for onyx,
but tas and therm_pm72 are apparently OK). Now I know I have to be
realistic, if problems arise and/or ppc people feel too bad about me
pushing these patches at about rc3 time, I will refrain from doing so
and wait for 2.6.31. But there are a number or i2c-core improvements
other developers are asking for for quite some times now, which depend
on the removal of the legacy model, so delaying this wound not make me
happy at all.

Thanks,
-- 
Jean Delvare
