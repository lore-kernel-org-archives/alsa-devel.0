From: Florian Faber <faber@faberman.de>
Subject: Re: RME madiface
Date: Fri, 11 Jul 2008 09:54:31 +0200
Message-ID: <200807110954.31479.faber@faberman.de>
References: <48769BDC.80007@homemail.com>
	<200807110626.52197.faber@faberman.de>
	<4877029F.6080006@homemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de
	(static-ip-85-25-152-101.inaddr.intergenia.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 686A92486F
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jul 2008 09:54:02 +0200 (CEST)
In-Reply-To: <4877029F.6080006@homemail.com>
Content-Disposition: inline
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

Dee,

> >> Any ideas?
> > There is no difference on the MADI bus wether you use Windows, OS X
> > or Linux. This seems to be a specific problem with the Euphonix.
> I have no reason to believe the MADI bus is different. However, I
> suspect the stream are different.

The MADI cards work autonomous, they are only controlled by a few 
parameters. If the parameters are the same, the behaviour is the same. 
Thus the settings must differ, and we have to find out where.

> I have two Euphonix boxes and they both behave perfectly under
> windows - but not under linux. The main problem under linux is that
> they lose sync - at the slightest electromagnetic interference (such
> as turning off/on the speakers - on the analogue side - even from a
> distance of 3 metres). 

I don't believe electromagnetic interference to be a reasonable cause 
for this. What exactly is your setup - 1x 703 and 1x 713? And both lose 
sync?

I just had a glance over the Euphonix' user manual and had to learn that 
they cannot loop through MADI and you have to use the wordclock. So, 
please, be a bit more specific about the setup - and maybe via private 
mail, because that's of no relevance to alsa development..


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
