From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Wed, 18 Sep 2002 00:15:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D87B793.6090608@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mta01-svc.ntlworld.com (mta01-svc.ntlworld.com [62.253.162.41])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA10973
	for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2002 01:15:55 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Does this mean that the alsa-lib needs to be updated in CVS to be -rc4? 
I am trying to compile xine and wine from CVS as well as ALSA, and this 
doesn't work because alsa-utils needs the new headers but xine and wine 
currently need the old ones. I imagine that the xine and wine people can 
update their code-bases accordingly, but I doubt that they would relish 
the prospect of checking for each changed ALSA API in their configure 
scripts.

Chris



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
