From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Scatter Gather DMA
Date: Wed, 5 Mar 2003 17:20:20 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0303051714121.13668-100000@mailserver.intern.bfad.de>
References: <Pine.LNX.4.44.0303051652210.1014-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailserver.intern.bfad.de (mail.bfad.de [212.62.208.67])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA10072
	for <alsa-devel@alsa-project.org>; Wed, 5 Mar 2003 17:20:04 +0100
In-Reply-To: <Pine.LNX.4.44.0303051652210.1014-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> I don't see a problem here. The PAGE_SIZE is 4kB for i386. Simply
> follow the code in the via82xx driver and limit the maximum count of 
> periods to 4.

This is easy solution, but a bit limiting. For example cs4281 supports max 2
periods. It is rather hard to work with it. There is a patch for ALSA 0.5 (by
Pekka Pessi) which I have ported to 0.9 which is switching DMA addresses in the
end-of-period interrupt. Works nicely, unlimited number of periods. Similar
solution could be used here. Or do you expect problems with it? 

Best regards,
--
Tomasz Motylewski



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
