From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dmix and oss.
Date: Fri, 30 May 2003 21:42:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305302135550.18165-100000@pnote.perex-int.cz>
References: <3ED78C70.5020500@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3ED78C70.5020500@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 30 May 2003, James Courtier-Dutton wrote:

> Is it possible to get the OSS emulation to use the dmix alsa plugin ?
> 
> Basically, so one can get multi-open /dev/dsp on a single-open sound 
> hardware.

There is only one solution at the moment: libaoss (distributed in the
alsa-oss package). It uses LD_PRELOAD hack (not wonderful, but it might
help).

My plain is to work on some "easy" API on top of ALSA's HAL which enables 
us easy porting of older applications and get rid of all frustrating OSS 
things.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
