From: Oliver Schrempf <un1q@stud.uni-karlsruhe.de>
Subject: Re: asoundrc problem
Date: Mon, 3 Feb 2003 14:40:26 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302031434160.17295-100000@rzstud2.stud.uni-karlsruhe.de>
References: <s5h4r7lioor.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4r7lioor.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> it's the expected behavior, because the hardware doesn't support this
> format.  it suppors only S32_LE.

OK, I understand this, but when I use
% arecord -Dhw:0,0 -fS32_LE -r48000 foo.wav
I get
arecord: set_params:792: Channels count non available

Is this expected, too?

> but it seems that this is an alsa-lib bug although i can play
> 4-channel wav file using two consumer cards...
Hmm? Can I help here? I'm no expert in alsa-lib, but I can test on my
hardware. Let me know if you need something.
Thanks

Oli



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
