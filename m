From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Problem with ALSA on PPC
Date: Tue, 13 Jun 2006 19:09:35 +0100
Message-ID: <1150222175.5111.2.camel@localhost.localdomain>
References: <1149891511.3894.296.camel@mindpipe>
	<1149902770.13569.10.camel@mindpipe>
	<1149933605.5081.1.camel@localhost.localdomain>
	<1150159211.3062.81.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1150159211.3062.81.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-06-12 at 20:40 -0400, Lee Revell wrote:
> On Sat, 2006-06-10 at 11:00 +0100, Adrian McMenamin wrote:
> > I had/have a very similar problem with the Dreamcast - I can only use
> > the oss emulation
> > 
> > Asking about here didn't get me an answer so I await any answers to
> > your
> > problem with anticipation...
> > 
> > / # aplay -l
> > **** List of PLAYBACK Hardware Devices ****
> > aplay: device_list:230: control open (0): Invalid argument
> > 
> 
> Adrian,
> 
> I looked at the strace source and it seems that Super-H is supported:
> 
> $ ls packages/strace-4.5.14/linux/sh
> errnoent.h  ioctlent.h  signalent.h  syscallent.h
> 
> Have you tried it?
> 

I haven't actually. Struggling with other SH kernel problems at the
moment, but I'll have a look

> Lee
