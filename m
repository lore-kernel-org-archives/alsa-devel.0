From: Tim Goetze <tim@quitte.de>
Subject: Re: usb quattro
Date: Wed, 4 Sep 2002 20:55:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209042052440.726-100000@summer.quitte>
References: <s5hit1l66iz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hit1l66iz.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Thu, 05 Sep 2002 01:35:39 +0900,
>Patrick Shirkey wrote:
>> 
>> Sorry if this is stupid, I'm not a trained programmer. I get this now.
>> 
>> Do you know how to fix it?
>
>	% gcc -l qinit qinit.c -lasound -ldl -lm

rather

$ gcc -o qinit qinit.c -lasound -ldl -lm
       ^
i think.

tim



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
