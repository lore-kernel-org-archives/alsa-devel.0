From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Fri, 30 Apr 2010 17:04:07 -0500
Message-ID: <u2hed82fe3e1004301504x95b2947fv60cc561feb3f26a4@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>
	<t2ged82fe3e1004301446mfbe63ddele99ad22ae331dd57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 514D7103921
	for <alsa-devel@alsa-project.org>;
	Sat,  1 May 2010 00:04:38 +0200 (CEST)
Received: by pwj8 with SMTP id 8so351146pwj.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2010 15:04:37 -0700 (PDT)
In-Reply-To: <t2ged82fe3e1004301446mfbe63ddele99ad22ae331dd57@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, broonie@opensource.wolfsonmicro.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 30, 2010 at 4:46 PM, Timur Tabi <timur@freescale.com> wrote:

> When I boot Linux, I get this:
>
> asoc: cs4270 <-> /soc@e0000000/ssi@16000 mapping ok
> sysfs: cannot create duplicate filename '/devices/platform/soc-audio/cs4270'

*sigh* never mind.  The problem was that the stream_name was the same
for both DAIs.

What exactly should the stream names be set to, anyway?  I did this:

	machine_data->dai[0].stream_name = "playback";
	machine_data->dai[1].stream_name = "capture";

but I have a suspicion that this is too simplistic.

-- 
Timur Tabi
Linux kernel developer at Freescale
