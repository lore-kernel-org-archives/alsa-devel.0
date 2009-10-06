From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH 18/31] HDA patch_via.c: Add 48K sample rate
 limit for S/PDIF streams.
Date: Tue, 6 Oct 2009 14:21:44 +0200
Message-ID: <20091006122144.GJ17195@prithivi.gnumonks.org>
References: <002DCEC0FD024441A08A6AEFF6FFC6BB@DemianM1330>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F6E324440
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 14:25:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <002DCEC0FD024441A08A6AEFF6FFC6BB@DemianM1330>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Demian Martin <demianm_1@yahoo.com>
Cc: liboat@gmail.com, tiwai@suse.de, alsa-devel@alsa-project.org, lydiawang@viatech.com.cn, LoganLi@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

Hi all,

I agree with the previous posts in this thread.

The use of > 48kHz sample rate is common use today, so if the hardware supports
it, the driver should not disable it.

Since there are some users that successfully use SPDIF with > 48kHz, it cannot
be a general hardware problem.  If there's a general hardware problem, then
it would never work for anyone.

If there are some codec chips/variants/versions, or even certain boards that
have bad SPDIf signal performance, then we should black-list those bad
chips/versions/boards, rather than disable the feature for everyone.

Also, as far as I understand, the worst thing that can happen when a "too high"
sample rate is used:  It will not work for some users on some hardware.  That,
I think, is acceptable (if no workaround / black-list can be created).

This would be different if there are other effects:  If the high sample rate
would cause some hardware-lock-up or similar, then it definitely needs to be
disabled.

Regards,
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
