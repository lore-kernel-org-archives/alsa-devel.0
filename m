From: Andrew Gaydenko <a@etver.com>
Subject: Re: ice1724: from 1.0.4 to 1.0.5a upgrading problem
Date: Fri, 16 Jul 2004 18:58:08 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407161858.08174@goldspace.net>
References: <200407141718.03846@goldspace.net> <200407141749.42615@goldspace.net> <s5h4qoaadzn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qoaadzn.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi,

Inspired with successfull resolving of "build error in pcm_native.c"
problem I have become rather brave to ask some additional questions
concerning this message subject:

- am I understand well, there were attempts to supply 96k earlier,
  but old code has not supplied a working of 96k for wide range of
  users, and code was redone to be more democratic but less functional
  (at least for me)?

- what does it mean: "special handling" for 96k? Who is handler?
  User? Further driver version?

- are there some development patches to try 96k on current CVS base?

Thanks in advance,
Andrew

======= On Wednesday 14 July 2004 17:57, Takashi Iwai wrote: =======
At Wed, 14 Jul 2004 17:49:42 +0400,
Andrew Gaydenko wrote:
> 
> Takashi,
> 
> To tell the truth, have not understood the word "yet": just now (with 1.0.4)
> my receiver (as qjackctl) shows 96KHz (alsaplayer-jack-alsadriver-hw:0,1-spdif).
> Does it mean some redesign was done for this driver since 1.0.4?

The spdif doesn't support 96kHz without a special handling.
It was a bug that 96kHz was accepted for that interface.


Takashi





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
