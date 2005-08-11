From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: [HDA patch] support for Si3054/5 HDA modems
Date: Thu, 11 Aug 2005 22:10:43 +0300
Message-ID: <20050811191043.GA18826@sashak.softier.local>
References: <20050810194745.GE20213@sashak.softier.local>
 <s5hy8786caq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hy8786caq.wl%tiwai@suse.de>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 11:41 Thu 11 Aug     , Takashi Iwai wrote:
> 
> Great!  Is it supposed to work with slmodem?

Yes, as full featured modem emulation.

Of course it is usable with aplay, arecord, amixer, whatever too.

> Then we'll need a definition of modem PCM for hda-intel, right?

Yes, I missed this. (I traditionally use 'aplay -l' and then choose
right device).

> Currently, we assume that the codec order is fixed and the number is
> assigned statically in the config.  It will be necessary to improve
> this probing.

Good idea.

Sasha.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
