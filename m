From: Paul Davis <pbd@op.net>
Subject: Re: porting 0.5 to 0.9 app
Date: Thu, 09 May 2002 00:06:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205090405.g4945Cv27985@post2.fast.net>
References: <3CD9F1B0.9070806@sympatico.ca>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id GAA19704
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 06:05:17 +0200
In-Reply-To: Your message of "Wed, 08 May 2002 23:49:04 EDT."
             <3CD9F1B0.9070806@sympatico.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Luc Tanguay <lucus@sympatico.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>I'm in the process of porting a 0.5.x app to 0.9.x.  The application is 
>Soundtracker.  In this GTK app, I was able to retrieve the file 
>descriptor using the 'snd_seq_file_descriptor' function.  The file 
>descriptor was then used to establish a callback to process MIDI events. 

btw, i wanted to note that this is a poor design. using a GUI event
loop to process real-time MIDI input subjects the MIDI data to
theoretically unbounded delays before it is processed. you should be
handling MIDI input in its own thread, ideally. using the sequencer
with timestamps makes things a bit better, but its still not ideal.

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
