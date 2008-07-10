From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add initial support of Mitac
	mioa701	master volume.
Date: Thu, 10 Jul 2008 09:50:20 +0100
Message-ID: <1215679820.23761.7.camel@localhost.localdomain>
References: <87vdzgp0ue.fsf@free.fr>
	<1215549906-14829-1-git-send-email-robert.jarzmik@free.fr>
	<1215549906-14829-2-git-send-email-robert.jarzmik@free.fr>
	<1215601158.4882.257.camel@localhost.localdomain>
	<871w23kkek.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C432C246C5
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jul 2008 10:50:36 +0200 (CEST)
In-Reply-To: <871w23kkek.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-07-09 at 20:00 +0200, Robert Jarzmik wrote:
> Liam Girdwood <liam.girdwood@wolfsonmicro.com> writes:
> 
> > On Tue, 2008-07-08 at 22:45 +0200, Robert Jarzmik wrote:
> >> Depending on the "Mio Mode" chosen, the master volume
> >> controls the widget volume/mute levels, providing userspace
> >> a unified vision of volume control (one control only).
> >> 
> >
> > The userspace manager does the same thing here. I prefer the userspace
> > approach for the long term instead of this being handled differently by
> > each driver. It's in git atm though.  
> 
> OK. So drop the patch. If the same functionnality is already available, I'll see
> if I can use it. May I know how stable that API is, and who actually uses it ?

I'm not going to drop the patch yet as it works for you :)

The API is very new and is in need of more users (i.e. more than just me
atm). Openmoko folks have expressed interest and will hopefully start
using this in the future. The overall aim would be to integrate this
into alsa-lib and salsa-lib when it's mature.

Liam
