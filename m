From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: ALSA 1.0.15rc1
Date: Fri, 31 Aug 2007 15:31:24 +0200
Message-ID: <m2wsvbhlub.fsf@vador.mandriva.com>
References: <Pine.LNX.4.61.0708311112510.10136@tm8103.perex-int.cz>
	<m2tzqghviz.fsf@vador.mandriva.com> <m2ps14hvcs.fsf@vador.mandriva.com>
	<Pine.LNX.4.61.0708311234180.10136@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from office.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 21BC510382A
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Aug 2007 15:31:29 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0708311234180.10136@tm8103.perex-int.cz> (Jaroslav
	Kysela's message of "Fri\, 31 Aug 2007 12\:39\:46 +0200 \(CEST\)")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela <perex@suse.cz> writes:

> > > > 	ALSA 1.0.15rc1 packages are released. Please, check 
> > > > http://www.alsa-project.org for download and changelog.
> > > > 
> > > > 						Jaroslav
> > > 
> > > Looks like you included the 1.0.14 changelog too. Eg, below shouldn't
> > > have you killed everythinkg after "release 1.0.14a"?
> > > 
> > > http://www.alsa-project.org/main/index.php/Changes_v1.0.14_v1.0.15rc1#alsa-lib
> > 
> > in fact, even "Fix plugin directory" & "Properly disable
> > -Bsymbolic-functions if ld doesn't support" looks part of 1.0.14a
> 
> It's changelog between 1.0.14 and 1.0.15rc1 not 1.0.14a and 1.0.15rc1.
> I can remove 1.0.14a changes, but then the changelog name might be 
> confusing.

You got a point.
Still, it looks like bogus order:
- 1.0.14a changes
- 1.0.14 changes
- 1.0.15 changes
