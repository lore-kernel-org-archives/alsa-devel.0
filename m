From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: opening alsa pcm device for input/output on specific channels
Date: Thu, 6 Jun 2002 17:09:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <004201c20d74$84dabb90$0400a8c0@martijn>
References: <200206061455.g56EtjH07853@post2.fast.net>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA14878
	for <alsa-devel@alsa-project.org>; Thu, 6 Jun 2002 17:09:56 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> >> correct. i know you love EASI
> >
> >is it that obvious? :)
> >
> >perhaps if more people like it, it would make sense porting
> >it to linux...
>
> much less sense than porting ASIO, i'm afraid. there are very few
> programs for win/macos that use EASI, but lots that use ASIO, and an
> ASIO layer would make porting the audio side of such programs much
> easier.
>
> personally, i don't like either of them very much, which is partly why
> i wrote JACK.

ok. you are now using: ALSA kernel -> ALSA lib -> JACK.
that's not too different from: kernel driver -> EASI or ASIO plugin -> JACK
i think the difference between ALSA and EASI/ASIO is that the latter have
device dependant code in both user space and kernel. i think this is a
cleaner
solution. i have not yet looked into ASIO much, but perhaps porting it would
make sense also. both EASI and ASIO plugins could use the same low level
kernel driver. is there a reason why this has not been done. licensing
perhaps?

do you agree that having a device specific user space plugin has advantages
over a generic kernel driver interface?

--martijn





_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
