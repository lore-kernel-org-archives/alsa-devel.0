From: Markus Plail <plail@web.de>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1
 emu10k1_main.c,1.12,1.13
Date: Wed, 17 Apr 2002 10:30:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87it6qk9ra.fsf@www.gitteundmarkus.de>
References: <873cxxmmjt.fsf@www.gitteundmarkus.de>
	<Pine.LNX.4.33.0204160911040.509-100000@pnote.perex-int.cz>
	<s5h7kn729d9.wl@alsa2.suse.de> <87sn5vn72w.fsf@www.gitteundmarkus.de>
	<s5hads3vhph.wl@alsa2.suse.de> <87elhfn1rd.fsf@www.gitteundmarkus.de>
	<s5h3cxvvd8h.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cxvvd8h.wl@alsa2.suse.de> (Takashi Iwai's message of "Tue,
 16 Apr 2002 18:07:26 +0200")
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
> At Tue, 16 Apr 2002 16:42:30 +0200,
> Markus Plail wrote:

>> Doesn't change anything really. I did an 'alsasound stop', edited
>> EMU10K1.conf and then 'alsasound start'. Was that right?

I am very sorry, I must have missed something yesterday. It DOES indeed
work with the change made in EMU10K1.conf

> yes.  now please check the state of this switch by alsamixer.
> try to play raw data once, and check whether the switch is changed.
> alsamixer will show the current status (and change the status if any
> notified).

As I wrote in another mail: While playing in passthrough mode (xine) the
switch doesn't do anything, while it works properly with normal (xmms
mp3 for example) digital mode.

Sorry for the confusion
Regards
Markus
