From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: ALSA + jack + xrun = kernel crash
Date: Mon, 19 May 2003 12:38:14 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19HnYU-0003Fd-00@sc8-sf-list1.sourceforge.net>
References: <s5hwugmdijp.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 19 May 2003 18:10:02 +0200."
             <s5hwugmdijp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Arthur Peters <amp@singingwizard.org>, Alsa dev list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>could you check whether snd_pcm_stream_linked() returns really only
>zero?  if yes, the code path shouldn't include the complicated locks

aw shoot. of course it returns true: jack tries to link
capture+playback so that we only have to issue single commands to
start+stop. damn, i forgot that, sorry.

--p


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
