From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Problems running latencytest: "error setting freq 1024"
Date: Tue, 23 Mar 2004 16:33:11 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403232133.i2NLXCZt015035@dhin.linuxaudiosystems.com>
References: <20040323205352.GA3246@fliwatut.scifi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out012.verizon.net (out012pub.verizon.net [206.46.170.137])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA04280
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2004 22:33:18 +0100
In-reply-to: Your message of "Tue, 23 Mar 2004 21:53:52 +0100."
             <20040323205352.GA3246@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>$ measure -p ./out/x11.png -o ./out/x11.out -c 0 -f 1024 -n 2 -t 2
>I get this error message: "error setting freq 1024"

probably a permissions problem. try it as root.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
