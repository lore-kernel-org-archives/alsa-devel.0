From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [Pkg-alsa-devel] Bug#544607:
 /usr/share/alsa/init/default:52: missing closing brace for format
Date: Wed, 2 Sep 2009 14:34:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0909021433260.12522@eeebox2.perex-int.cz>
References: <20090901202614.5849.99958.reportbug@base.lan>
	<20090902122915.GB4978@frodo.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 31476103805
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 14:34:31 +0200 (CEST)
In-Reply-To: <20090902122915.GB4978@frodo.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: 544607@bugs.debian.org, Philipp Jocham <philipp.jocham@gmx.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2 Sep 2009, Elimar Riesebieter wrote:

> forward 544607 alsa-devel@alsa-project.org

>> -ENV{has_pmaster_vol}=="true",CTL{values)="100%",GOTO="headphone0_end"
>> +ENV{has_pmaster_vol}=="true",CTL{values}="100%",GOTO="headphone0_end"

The change was commited to the alsa-utils repository. Thanks.

 					Jaroslav Kysela

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
