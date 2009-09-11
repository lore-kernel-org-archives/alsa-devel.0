From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: How to test suspend ?
Date: Fri, 11 Sep 2009 13:27:56 -0700
Message-ID: <1252700876.11228.4.camel@razman>
References: <20090911005856.3d910e79@Jay>
	<20090911061943.GE9410@buzzloop.caiaq.de> <20090911215722.292f90d0@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id D9E0824352
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 22:27:51 +0200 (CEST)
In-Reply-To: <20090911215722.292f90d0@Jay>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-09-11 at 21:57 +0200, Giuliano Pochini wrote:

> On Fri, 11 Sep 2009 08:19:43 +0200
> Daniel Mack <daniel@caiaq.de> wrote:
> 
> > On Fri, Sep 11, 2009 at 12:58:56AM +0200, Giuliano Pochini wrote:
> > > I couldn't make s2ram work on my machine and /sys/pci/.../power/state
> > > virtual files were removed one year ago. How can I test suspend/resume ?
> > 
> > See Documentation/power/states.txt
> 
> $ cat /sys/power/state
> 
> ^^^^ nothing.
> 

Cat does nothing because it doesn't change the current state.  It should return:

standby mem disk

if the kernel is built to handle power management.  If it does return
any of these values, to change state you would type (as root):
echo mem >/sys/power/state   # suspend to ram
# or
echo disk >/sys/power/state     # suspend to disk (hibernate).



-- 
Tobin Davis 


You too can wear a nose mitten.
