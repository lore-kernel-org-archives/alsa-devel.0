From: Paul Davis <pbd@op.net>
Subject: Re: current buglets
Date: Thu, 15 Aug 2002 11:59:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17fMzs-0005hC-00@usw-sf-list1.sourceforge.net>
References: <s5hbs84tesw.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 15 Aug 2002 15:46:55 +0200."
             <s5hbs84tesw.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>known bugs i know of (and am working on) are:

hdsp
   - cold+warm boot required to get output working
   - 96kHz and 88.2kHz not accessible via PCM interface

rme9652
   - 96kHz and 88.2kHz not accessible via PCM interface

wavefront
   - cs4232 PCM output does not work at all (produces white noise)

i will be working on the hdsp+rme9652 ones soon; the cs4232 one
will have to fall in someone else's lap.

--p


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
