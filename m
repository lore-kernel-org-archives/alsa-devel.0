From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Alsa Programming Examples
Date: Sun, 9 Jun 2002 13:12:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0206091308190.23357-100000@mailserver.intern.bfad.de>
References: <Pine.LNX.4.21.0206091143590.844-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailserver.intern.bfad.de (mail.bfad.de [212.62.208.67])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA32719
	for <alsa-devel@alsa-project.org>; Sun, 9 Jun 2002 13:11:44 +0200
In-Reply-To: <Pine.LNX.4.21.0206091143590.844-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: Philipp Vollmer <vollmer.philipp@t-online.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 9 Jun 2002, Tim Goetze wrote:

> with all respect, i think you could have tried a little harder to find
> the error.

There is a prominent link on
http://www.alsa-project.org/documentation.php3#0.9doc

Howto use the ALSA API - Paul Davis has also written a brief explanation. 
http://www.op.net/~pbd/alsa-audio.html#captureex

You will find there:

 if ((capture_handle = snd_pcm_open (argv[1], SND_PCM_STREAM_CAPTURE, 0)) <0) {
         fprintf (stderr, "cannot open audio device %s\n", argv[1]);
                 exit (1);
 }

and many other errors.

While examples are the best for of developers documentation, broken examples
are the worst form of misinformation.

I have written about a week ago to pbd@users.sourceforge.net, no answer yet.

Best regards,
--
Tomasz Motylewski



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
