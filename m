From: Paul Davis <pbd@op.net>
Subject: Re: ALSA instrument API
Date: Thu, 04 Apr 2002 09:31:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204041431.JAA13020@renoir.op.net>
References: <200204041124.AFF89495@msgdirector2.onetel.net.uk>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA16326
	for <alsa-devel@alsa-project.org>; Thu, 4 Apr 2002 16:31:58 +0200
In-Reply-To: Your message of "Thu, 04 Apr 2002 12:21:47 +0100."
             <200204041124.AFF89495@msgdirector2.onetel.net.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: bownie@bownie.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Thanks to Maarten I've got involved in implementing ALSA support for
>Rosegarde n 4.  I've been browsing the ALSA API and patching together
>a driver layer to give u s a general framework we can share between
>ALSA and aRts.  The ALSA Instrument API looks promising but so far I
>can't find much on it on the mailing list archive or on the web.  Any
>clues for an overview?

AFAIK, it has never been fully developed (and certainly is not used by
more than a handful of test programs). You should be talking to Josh
Green and others on LAD who are interested in defining how this should
work more fully. There are a lot of tricky issues that arise from the
distinctions between external MIDI devices and software-implemented
MIDI devices, including those with hardware support (such the as the
synths on many current consumer audio interfaces). I don't think these
have ever really been worked out within ALSA - I could, as usual, be
wrong. 

--p
