From: Florian Faber <faber@faberman.de>
Subject: Re: RME madiface
Date: Fri, 11 Jul 2008 06:26:51 +0200
Message-ID: <200807110626.52197.faber@faberman.de>
References: <48769BDC.80007@homemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de
	(static-ip-85-25-152-101.inaddr.intergenia.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 293C424568
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jul 2008 06:26:17 +0200 (CEST)
In-Reply-To: <48769BDC.80007@homemail.com>
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

Pleaseuseafullname,

> I have been trying to use the hdspm driver with a recently purchased
> RME Madiface device. The functionality that I require is to play
> various files through various channels under program (script)
> control. I am happy to report that it *almost* works - in that I can
> use my simple userspace programs to play files. However, there are
> subtle problems - in that the external MADI A-to-D (an Euphonix 703)
> does not seem to lock into the sampling rate (something that works
> under windows). Its very close to achieving full functionality (for
> my needs) - but just that tiny bit away from being fully useable.
>
> Any ideas?

There is no difference on the MADI bus wether you use Windows, OS X or 
Linux. This seems to be a specific problem with the Euphonix.

What are the exact parameters you use on Windows (when the Euphonix 
worked)?

> Havent had much luck contacting RME and Winfried Ritsch (who
> wrote/maintains the code).

I maintain the code at the moment.


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
