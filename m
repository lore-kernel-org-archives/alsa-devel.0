From: Paul Davis <pbd@op.net>
Subject: Re: About integer64
Date: Thu, 09 May 2002 08:59:23 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205091258.g49CwN924620@post2.fast.net>
References: <3CDA6B48.3E68AE3A@alsa-project.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 09 May 2002 14:27:52 +0200."
             <3CDA6B48.3E68AE3A@alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>However also if this is the case I'd prefer to have UINTEGER and/or
>UINTEGER64.

I agree. I would prefer specific types for unsigned controls, not an
extra bit to indicate this. imagine:

      switch (control->type) {
      case INTEGER:
           if (control->unsigned) {
	      ...
	   } else {
	      ...
	   }
	   break;

versus:
      
       switch (control->type) {
       case INTEGER:
           ...
	   break;
       case UINTEGER:
           ...
	   break;

i much prefer the latter.
	   
--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
