From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: ssm4567: Add driver for Analog Devices
	SSM4567 amplifier
Date: Wed, 1 Oct 2014 20:44:02 +0300
Message-ID: <20141001174402.GD5865@mwanda>
References: <20141001170257.GB11786@mwanda>
 <CAOMFOmXOhDc=nwqcCUPqF6yFqMSvZwdE1gbATxZVhFpM40nvHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 1046F2604D8
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 19:44:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMFOmXOhDc=nwqcCUPqF6yFqMSvZwdE1gbATxZVhFpM40nvHQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 01, 2014 at 10:12:53AM -0700, Anatol Pomozov wrote:
> Hi
> 
> On Wed, Oct 1, 2014 at 10:02 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > Hello Anatol Pomozov,
> >
> > The patch 1ee44ce03011: "ASoC: ssm4567: Add driver for Analog Devices
> > SSM4567 amplifier" from Sep 26, 2014, leads to the following static
> > checker warning:
> 
> Thanks!
> 
> What static checker do you use and how can I run locally?

This is a smatch warning, but you have to run with the --spammy option
to see it because these warnings are often false postives.

~/progs/smatch/devel/smatch_scripts/kchecker --spammy sound/soc/codecs/ssm4567.c

regards,
dan carpenter
