From: Paul Davis <pbd@op.net>
Subject: Re: PCM ioctls
Date: Sat, 17 Aug 2002 07:59:31 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208171157.NAA13178@alsa.alsa-project.org>
References: <20020816221225.10207.qmail@web11504.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA13178
	for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2002 13:57:30 +0200
In-Reply-To: Your message of "Fri, 16 Aug 2002 15:12:25 PDT."
             <20020816221225.10207.qmail@web11504.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guilhem Tardy <guilhem_tardy@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>There are 3 standard PCM ioctls, and a driver could potentially support others
>via its own ioctl function registered in the snd_pcm_ops_t structure. Could
>anyone give me a hint regarding how an application could then call such
>standard and other ioctls?

i'm not going to do that, but i will point you at the "hwdep" API,
which exists specifically to provide a way to make hw-dependent
operations available that don't map into the existing ALSA API. you
create a hwdep device within the driver; apps can open it, and call
whatever ioctl's you provide. 

its a bad idea for general purpose software, of course, since such s/w
can't know about your specific ioctls, but it works well for writing
h/w specific control apps. i have an app for the wavefront synth, for
example, which has a whole bunch of operations that don't fit into any
of the existing PCM, MIDI or Sequencer APIs. these are implemented via
the hwdep API, such as it is.

--p


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
