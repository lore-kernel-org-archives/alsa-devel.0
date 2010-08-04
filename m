From: errordeveloper@gmail.com
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Thu, 5 Aug 2010 00:33:09 +0100
Message-ID: <20100804233309.GB6629@00110101.home>
References: <4C595A52.7030401@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id B7B5124149
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 01:33:12 +0200 (CEST)
Received: by wyb42 with SMTP id 42so5972420wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 04 Aug 2010 16:33:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C595A52.7030401@gmx.de>
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

it crashes on my machine with one USB soundcard,
and an RME Hammerfall ..i think RME causes it -
i get a `Floating exception` ..hm, not a segfault this time :)

..i can do some tests ..have you got an svn or git?
basically RME alsa driver is different from all other drivers,
so far i only see one mixer that presented snd-hdsp options
in correct way ..it's mostly just tick boxes..
i'd say that you can just try to set up a condition
that if the card is RME, then just ignore that card :)
..otherwise check hdspmixer and hdspconf in alsa-tools.

On Wed, Aug 04, 2010 at 02:17:22PM +0200, Sebastian H. wrote:
> Hello everyone
> 
> I've been working on Alsamixer-Qt4 lately and compiled
> the changes into a new release version 0.4.0.
> Most importantly the cards list can be refreshed now
> and the style got a little overhaul, too.
> A more detailed changelog can be found at the xwmw.org page.
> 
> The new version 0.4.0 is available at the known places.
> http://xwmw.org/alsamixer-qt4/
> http://sourceforge.net/projects/alsamixer-qt4/files/
> 
> Any comments are welcome.
> 
> Cheers,
> Sebastian
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
