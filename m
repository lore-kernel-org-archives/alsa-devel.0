From: Markus Plail <plail@web.de>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1
 emu10k1_main.c,1.12,1.13
Date: Tue, 16 Apr 2002 16:51:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87662rn1d1.fsf@www.gitteundmarkus.de>
References: <873cxxmmjt.fsf@www.gitteundmarkus.de>
	<Pine.LNX.4.33.0204160911040.509-100000@pnote.perex-int.cz>
	<s5h7kn729d9.wl@alsa2.suse.de> <87sn5vn72w.fsf@www.gitteundmarkus.de>
	<3CBC26AB.6030907@superbug.demon.co.uk> <s5h8z7nvhlv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z7nvhlv.wl@alsa2.suse.de> (Takashi Iwai's message of "Tue,
 16 Apr 2002 16:33:00 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James@superbug.demon.co.uk, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi!

* Takashi Iwai writes:
> Hi James,

> does "Digital/Analog Jack" switch affects the behavior on your digital
> jack?  i guess it doesn't.
> if it doesn't affect, then we can switch this bit safely on all
> cards.

So you thought that my problem was this not being enabled? I can assure
you then, that this wasn't the problem. I have played with that switch
all way through my alsa SB live experience. It worked properly to switch
digital sound off and the default value (i.e. after having asound.state
deleted) was/is digital sound ON.

Regards
Markus
