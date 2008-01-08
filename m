From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] Remove sound/driver.h
Date: Tue, 8 Jan 2008 17:41:44 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801081741320.22730@tm8103.perex-int.cz>
References: <s5hy7bp2z5v.wl%tiwai@suse.de> <s5hr6hh2xee.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0801081736480.22730@tm8103.perex-int.cz>
	<s5hfxx82rvl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0740224B46
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 17:41:45 +0100 (CET)
In-Reply-To: <s5hfxx82rvl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 8 Jan 2008, Takashi Iwai wrote:

> At Tue, 8 Jan 2008 17:37:21 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > On Thu, 20 Dec 2007, Takashi Iwai wrote:
> > 
> > > This is no concrete patch, but just shows you an essence.
> > > 
> > > In many places, simply the inclusion of sound/driver.h is removed:
> > > 
> > > diff -r 1f5b3ddb6636 isa/als100.c
> > > --- a/isa/als100.c	Thu Dec 20 12:57:48 2007 +0100
> > > +++ b/isa/als100.c	Thu Dec 20 14:12:20 2007 +0100
> > > @@ -20,7 +20,6 @@
> > >      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
> > >  */
> > >  
> > > -#include <sound/driver.h>
> > 
> > Ack. How you would like to solve the alsa-driver internal build?
> 
> By simply adding '#include "adriver.h" in each *.c in alsa-driver
> tree.

Good. Thanks.

				Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
