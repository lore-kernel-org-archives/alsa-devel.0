From: Paul Davis <pbd@op.net>
Subject: Re: opening alsa pcm device for input/output on specific channels
Date: Thu, 06 Jun 2002 11:00:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206061455.g56EtjH07853@post2.fast.net>
References: <003101c20d72$0b1d5620$0400a8c0@martijn>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA14653
	for <alsa-devel@alsa-project.org>; Thu, 6 Jun 2002 16:55:53 +0200
In-Reply-To: Your message of "Thu, 06 Jun 2002 16:51:35 BST."
             <003101c20d72$0b1d5620$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> correct. i know you love EASI
>
>is it that obvious? :)
>
>perhaps if more people like it, it would make sense porting
>it to linux...

much less sense than porting ASIO, i'm afraid. there are very few
programs for win/macos that use EASI, but lots that use ASIO, and an
ASIO layer would make porting the audio side of such programs much
easier. 

personally, i don't like either of them very much, which is partly why
i wrote JACK. 

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
