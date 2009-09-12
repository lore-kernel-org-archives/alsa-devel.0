From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: How to test suspend ?
Date: Sat, 12 Sep 2009 22:28:40 +0200
Message-ID: <20090912222840.4acb153b@Jay>
References: <20090911005856.3d910e79@Jay>
	<20090911061943.GE9410@buzzloop.caiaq.de>
	<20090911215722.292f90d0@Jay> <1252700876.11228.4.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out26.alice.it (smtp-out26.alice.it [85.33.2.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DCA8247D9
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 22:28:55 +0200 (CEST)
In-Reply-To: <1252700876.11228.4.camel@razman>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Sep 2009 13:27:56 -0700
Tobin Davis <tdavis@dsl-only.net> wrote:

> On Fri, 2009-09-11 at 21:57 +0200, Giuliano Pochini wrote:
> 
> > On Fri, 11 Sep 2009 08:19:43 +0200
> > Daniel Mack <daniel@caiaq.de> wrote:
> > 
> > > On Fri, Sep 11, 2009 at 12:58:56AM +0200, Giuliano Pochini wrote:
> > > > I couldn't make s2ram work on my machine and /sys/pci/.../power/state
> > > > virtual files were removed one year ago. How can I test suspend/resume ?
> > > 
> > > See Documentation/power/states.txt
> > 
> > $ cat /sys/power/state
> > 
> > ^^^^ nothing.
> > 
> 
> Cat does nothing because it doesn't change the current state.  It should return:
> 
> standby mem disk
> 
> if the kernel is built to handle power management.

It is... and /sys/power/state is supposed to be "mem" only. But since it
doesn't work, is there another way to test suspend/resume of the soundcard ?


--
Giuliano.
