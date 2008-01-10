From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] [ALSA] Add ASoC drivers for the
 Freescale MPC8610 SoC
Date: Thu, 10 Jan 2008 17:19:02 -0600
Message-ID: <4786A7E6.8040503@freescale.com>
References: <12000050651235-git-send-email-timur@freescale.com>	<12000050664035-git-send-email-timur@freescale.com>	<12000050682718-git-send-email-timur@freescale.com>	<fa686aa40801101502v264d8caw6faf935d71b15c9@mail.gmail.com>	<4786A650.2080107@freescale.com>
	<fa686aa40801101517q2d4e6673l995ef4123f0d0ad4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 912F924759
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 00:19:11 +0100 (CET)
In-Reply-To: <fa686aa40801101517q2d4e6673l995ef4123f0d0ad4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, david@gibson.dropbear.id.au
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:

>> As for the GUTS driver, well, I just program a few registers at startup, and I
>> don't think any other driver touches them.
> 
> Okay; at some point in the future they'll need to be accessed from a
> common routine too.

I'll add that to my to-do list.

-- 
Timur Tabi
Linux kernel developer at Freescale
