From: stan <stanl@cox.net>
Subject: Re: Hidden rate conversion, and Alsa configuration
Date: Fri, 27 Jul 2007 10:37:46 -0700
Message-ID: <20070727103746.30d03e39@localhost.localdomain>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<20070719142440.GA2467@localhost>
	<200707201333.38449.gineera@aspect135.co.uk>
	<200707271720.41278.gineera@aspect135.co.uk>
	<75b66ecd0707270859q33f02d05la5160f3443dc9cc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao101.cox.net (fed1rmmtao101.cox.net [68.230.241.45])
	by alsa0.perex.cz (Postfix) with ESMTP id EE116103817
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jul 2007 19:37:48 +0200 (CEST)
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao101.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
	id <20070727173746.CNFK1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>
	for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2007 13:37:46 -0400
In-Reply-To: <75b66ecd0707270859q33f02d05la5160f3443dc9cc1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 27 Jul 2007 11:59:53 -0400
"Lee Revell" <rlrevell@joe-job.com> wrote:

> On 7/27/07, Alan Horstmann <gineera@aspect135.co.uk> wrote:
> > Could you give pointers as to how to modify Alsa configuration so
> > that rate conversion can never happen, as I would prefer to have an
> > error accessing the sound card rather than unknown conversion,
> > which in my use should never be neccesary anyway.
> 
> Simply open the hw device rather than the default, dmix, or plughw
> device.
> 
> Lee

Lee,

Are you saying that plughw *does* do hidden conversion?  I thought its
definition was equivalent to 

newplug {
        type plug
        slave {
                pcm "hw:0,0"
        }
}

Is this doing conversion?
