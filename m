From: Luc Tanguay <lucus@sympatico.ca>
Subject: Re: porting 0.5 to 0.9 app
Date: Fri, 10 May 2002 23:11:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CDC8BD3.8010404@sympatico.ca>
References: <200205090405.g4945Cv27985@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from tomts21-srv.bellnexxia.net (tomts21.bellnexxia.net [209.226.175.183])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id FAA26359
	for <alsa-devel@alsa-project.org>; Sat, 11 May 2002 05:10:14 +0200
Received: from sympatico.ca ([65.94.178.29]) by tomts21-srv.bellnexxia.net
          (InterMail vM.5.01.04.05 201-253-122-122-105-20011231) with ESMTP
          id <20020511031006.QZOD11344.tomts21-srv.bellnexxia.net@sympatico.ca>
          for <alsa-devel@alsa-project.org>;
          Fri, 10 May 2002 23:10:06 -0400
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:

>>I'm in the process of porting a 0.5.x app to 0.9.x.  The application is 
>>Soundtracker.  In this GTK app, I was able to retrieve the file 
>>descriptor using the 'snd_seq_file_descriptor' function.  The file 
>>descriptor was then used to establish a callback to process MIDI events. 
>>
>
>btw, i wanted to note that this is a poor design. using a GUI event
>loop to process real-time MIDI input subjects the MIDI data to
>theoretically unbounded delays before it is processed. you should be
>handling MIDI input in its own thread, ideally. using the sequencer
>with timestamps makes things a bit better, but its still not ideal.
>
I don't think it's poor design... It's no design at all :-)  Anyway 
thanks for the hint.  I'll see what I can do but can you explain more on 
why using the seq. with timestamps would make things better.  ALSA 
documentation for sequencer is so thin (or I need more hours in a day) 
that it is difficult to get the idea on where it is going (client, 
subscription, port, event, etc.).  I don't have the time to read source 
code of other programs to understand how ALSA could be use in my own 
project and knowing the names of every function and parameters available 
in the library won't do no good.  

Luc


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
