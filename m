From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 10:56:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209181054350.534-100000@pnote.perex-int.cz>
References: <3D87B793.6090608@yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA17320
	for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2002 10:57:02 +0200
In-Reply-To: <3D87B793.6090608@yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 18 Sep 2002, Chris Rankin wrote:

> Does this mean that the alsa-lib needs to be updated in CVS to be -rc4? 
> I am trying to compile xine and wine from CVS as well as ALSA, and this 
> doesn't work because alsa-utils needs the new headers but xine and wine 
> currently need the old ones. I imagine that the xine and wine people can 
> update their code-bases accordingly, but I doubt that they would relish 
> the prospect of checking for each changed ALSA API in their configure 
> scripts.

The library version can be easy detected at compilation code. The SND_LIB_EXTRAVER
define is 100000 for 0.9.0rc3, 100003 for CVS version of alsa-lib and will 
be 100004 for 0.9.0rc4. Note: If SND_COMPATIBILITY_BUILD_RC3 is defined, 
then applications need to fall back to 0.9.0rc3 API as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
