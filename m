From: Paul Davis <pbd@op.net>
Subject: Re: opening alsa pcm device for input/output on specific channels
Date: Thu, 06 Jun 2002 21:28:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206070123.g571N8H12005@post2.fast.net>
References: <004201c20d74$84dabb90$0400a8c0@martijn>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA24337
	for <alsa-devel@alsa-project.org>; Fri, 7 Jun 2002 03:23:15 +0200
In-Reply-To: Your message of "Thu, 06 Jun 2002 17:09:09 BST."
             <004201c20d74$84dabb90$0400a8c0@martijn>
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

>> personally, i don't like either of them very much, which is partly why
>> i wrote JACK.
>
>ok. you are now using: ALSA kernel -> ALSA lib -> JACK.

thats the current config, except that we now have

      solaris audio -> JACK

as well. and we use very, very little of alsa-lib with JACK unless the
user asks to by using a non-"hw" PCM device name.

>that's not too different from: kernel driver -> EASI or ASIO plugin -> JACK
>i think the difference between ALSA and EASI/ASIO is that the latter have
>device dependant code in both user space and kernel. i think this is a
>cleaner solution. 

there has been talk here about device dependent code going into
alsa-lib. also with ALSA and applications like JACK that use features
not yet abstracted into the ALSA API (e.g. hardware monitoring), we
have device dependent code in user space too.

>	   i have not yet looked into ASIO much, but perhaps porting it would
>make sense also. both EASI and ASIO plugins could use the same low level
>kernel driver. is there a reason why this has not been done. licensing
>perhaps?

when abramo and i have talked about this (just a little bit), we felt
quite sure you could implement ASIO (and thus *probably* EASI) on top
of alsa-lib.

>do you agree that having a device specific user space plugin has advantages
>over a generic kernel driver interface?

actually, no i don't. i prefer to see features that are truly
"cross-interface" be abstracted into the API, and those cards that
support them provide them via the generic kernel driver
interface. however, in the end it doesn't make a lot of difference as
long as the application has no clue what's going on. 

i've thrown down the gauntlet with JACK's design by saying that i
think that the vast, overwhelming majority of audio apps should have
no clue whether they are even running with access to an actual h/w
audio interface. providing device specific features doesn't seem very
important to me. this is stuff that is handled by the control API and
alsactl/amixer right now. it would be better if we had a graphical
application to supplement them, but thats the only place i care about
device specific stuff as a rule.

--p


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
