From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: PCM format restrict dilema
Date: Wed, 17 Sep 2003 16:20:45 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309171617010.5983@pnote.perex-int.cz>
References: <200309161847.h8GIlKtn014678@oud> <3F676332.1000503@superbug.demon.co.uk>
 <Pine.LNX.4.53.0309170903550.5983@pnote.perex-int.cz> <3F68663C.4050401@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F68663C.4050401@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Takashi Iwai <tiwai@suse.de>, manuel.jander@mat.utfsm.cl, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 17 Sep 2003, James Courtier-Dutton wrote:

> The reason I think it might help this way, is because period_size and
> buffer_size and number of periods are all closely linked, so we should
> not have to set them one at a time, but set them as a group.

Yes, but it's violation of the current "refine" algorithm. When I talked
with Takashi, I would like to come with some preset values in alsa-lib
which describes the basic configurations for player applications etc.
These preset values will be hardware specific.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
