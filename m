From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: new "in-compatible" alsa-lib PCM API
Date: Tue, 17 Sep 2002 20:49:28 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209172047490.796-100000@ecabase.localdomain>
References: <Pine.LNX.4.33.0209171436440.537-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ecabase.localdomain (cs78169135.pp.htv.fi [62.78.169.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA05015
	for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2002 19:50:52 +0200
In-Reply-To: <Pine.LNX.4.33.0209171436440.537-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 17 Sep 2002, Jaroslav Kysela wrote:

> 1) New "versioned" library is libasound.so.3, so that older applications 
>    uses older libasound.so.2. 

Hmm, the 'Versions' ld script doesn't seem to be in CVS, and as a result,
linking alsa-lib currently fails. Have I missed something?
 
-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
