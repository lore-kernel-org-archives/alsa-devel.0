From: Markus Plail <plail@web.de>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1
 emu10k1_main.c,1.12,1.13
Date: Tue, 16 Apr 2002 14:47:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87sn5vn72w.fsf@www.gitteundmarkus.de>
References: <873cxxmmjt.fsf@www.gitteundmarkus.de>
	<Pine.LNX.4.33.0204160911040.509-100000@pnote.perex-int.cz>
	<s5h7kn729d9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7kn729d9.wl@alsa2.suse.de> (Takashi Iwai's message of "Tue,
 16 Apr 2002 13:03:46 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Takashi!

* Takashi Iwai writes:
> Markus, could you try the latest cvs version, which fixes the "real"
> behavior, whether digital out works?  if it doesn't work again, then
> definitely GPOUT0 is the spot.

It doesn't work with latest CVS.

> looking at OSS source codes, i found GPOUT0 is necessary only for 5.1
> cards (and seems for Audigy too - i need to fix again).
> so i'm not sure whether we can determine it from revision number.

Someone should test if the version which is doing fine here, is also OK
on other revisions of the card, so 'we' could just leave the 'else
statement' away. James has a rev06 to check it, for example.

Regards
Markus
