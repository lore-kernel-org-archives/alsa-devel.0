From: Paul Davis <pbd@op.net>
Subject: Re: porting 0.5 to 0.9 app
Date: Thu, 09 May 2002 00:04:03 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205090403.GAA19676@alsa.alsa-project.org>
References: <3CD9F1B0.9070806@sympatico.ca>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id GAA19676
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 06:03:12 +0200
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
> To code looks like:
>
>midi_file_tag = gdk_input_add( snd_seq_file_descriptor( midi_handle),
>                 GDK_INPUT_READ,
>                 (GdkInputFunction)midi_in_cb,
>                 midi_handle);
>
>How do I do the same thing with the new ALSA 0.9.x API ?

its very similar, but there may be more than 1 file descriptor
associated with the handle, and the function fills out a pollfd
struct instead of giving you fd's directly. so, try:
	
	include <poll.h>

	struct pollfd *pfd;
	int limit;

	/* find out how many descriptors there are */
	
	limit = snd_seq_poll_descriptors_count(seq_handle); 
	pfd = (struct pollfd *) malloc (sizeof (struct pollfd) * limit);

	/* now get the file descriptors */
	
	snd_seq_poll_descriptors (seq_handle, pfd, limit)

	/* now use pfd[0..limit-1] as desired */

	midi_file_tag = gdk_input_add(pfd[0].fd,
	                 GDK_INPUT_READ,
			 (GdkInputFunction)midi_in_cb,
			 midi_handle);

obviously, if `limit' > 1, the code becomes more complex for hooking
into a GUI event loop, but its not that hard, and in almost every
case, it will be 1. you must check the value, however: it could be <> 1.

--p











_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
