From: Mark Knecht <markknecht@attbi.com>
Subject: Re: possible problems with rc6 aplay
Date: 16 Dec 2002 17:44:44 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1040089485.1305.1.camel@Godzilla>
References: <200212151910.18nLEb5ck3NZFjX0@robin>
	<3DFE5965.90F4A8B7@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DFE5965.90F4A8B7@earthlink.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: patrick reardon <swpatrick@earthlink.net>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Patrick,
   I believe the AI-3 operates at 48K if it is not receiving a clock via
it's ADAT input. If the ADAT input is applied and provides 44.1K, then
it is my understanding that the AI-3 operates at 44.1K.

Mark

On Mon, 2002-12-16 at 14:53, patrick reardon wrote:
> 
> yes, thnx, it's much clearer now.  my converter is external with no rate switches and from
> the manual i just discovered it always operates at 48000 (Alesis AI-3).  i'm still
> uncertain how to change the card's configuration though.  "alsactl" doesn't seem to
> provide an obvious way to do this (looking at the man page).  but my asound.state file has




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
