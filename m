From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: hdsp vs 16bit vs dmix
Date: Mon, 26 Jan 2004 14:15:33 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401261415070.2959@pnote.perex-int.cz>
References: <3FFC41E9.3050501@boosthardware.com> <s5hn08yznzf.wl@alsa2.suse.de>
 <40150EB7.8070907@undata.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40150EB7.8070907@undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Takashi Iwai <tiwai@suse.de>, Patrick Shirkey <pshirkey@boosthardware.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Jan 2004, Thomas Charbonnel wrote:

> Now if you do specify 'channels 18' in the dmix slave definition, the 
> error is as follows :
> aplay: set_params:827: Sample format non available
> I have 'format S32_LE' set in the dmix slave definition, but it doesn't 
> seem to be taken into account.

It should be. Did you used 'aplay -D plug:your_dmix'?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
