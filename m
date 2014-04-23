From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: How to show hda trace events in a self-built
	kernel?
Date: Wed, 23 Apr 2014 09:21:07 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B3F45D9@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B3F4357@SHSMSX101.ccr.corp.intel.com>
 <53577A6B.2060400@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AC2AE261600
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 11:21:17 +0200 (CEST)
In-Reply-To: <53577A6B.2060400@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks, David!

tracing_on is '1' by default and current_tracer is 'nop', same for both kernels.

I also notice the 'net' trace event output is okay on the same kernel on which I cannot get hda trace event output.

Regards
Mengdong

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Wednesday, April 23, 2014 4:32 PM
> To: Lin, Mengdong; alsa-devel@alsa-project.org
> Subject: Re: How to show hda trace events in a self-built kernel?
> 
> 
> On 2014-04-23 09:35, Lin, Mengdong wrote:
> > Hi,
> >
> > How to show hda trace events in a self-built kernel?
> >
> > With a self-built kernel under Ubuntu 13.04 or 13.10, I enabled hda
> > trace events by
> >
> > #cd /sys/kernel/debug/tracing/
> >
> > #echo 1 > events/hda/enable
> >
> > #echo 1 > events/had_intel/enable
> >
> > Then I check the codec proc entry and run "cat trace". But I got no
> > output of the hda trace events.
> 
> Did you forget to do:
> # echo 1 > tracing_on

> You might also want to set current_tracer to something.
> 
> Otherwise I don't know what the problem can be.
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
