From: Luc Tanguay <lucus@sympatico.ca>
Subject: porting 0.5 to 0.9 app
Date: Wed, 08 May 2002 23:49:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CD9F1B0.9070806@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from tomts12-srv.bellnexxia.net (tomts12.bellnexxia.net [209.226.175.56])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id FAA19517
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 05:48:04 +0200
Received: from sympatico.ca ([65.94.180.114]) by tomts12-srv.bellnexxia.net
          (InterMail vM.5.01.04.05 201-253-122-122-105-20011231) with ESMTP
          id <20020509034756.VAUH21254.tomts12-srv.bellnexxia.net@sympatico.ca>
          for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 23:47:56 -0400
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

Hello,

I'm in the process of porting a 0.5.x app to 0.9.x.  The application is 
Soundtracker.  In this GTK app, I was able to retrieve the file 
descriptor using the 'snd_seq_file_descriptor' function.  The file 
descriptor was then used to establish a callback to process MIDI events. 
 To code looks like:

midi_file_tag = gdk_input_add( snd_seq_file_descriptor( midi_handle),
                 GDK_INPUT_READ,
                 (GdkInputFunction)midi_in_cb,
                 midi_handle);

How do I do the same thing with the new ALSA 0.9.x API ?

thanks


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
