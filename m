From: Markus Plail <plail@web.de>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1
 emu10k1_main.c,1.12,1.13
Date: Tue, 16 Apr 2002 16:42:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87elhfn1rd.fsf@www.gitteundmarkus.de>
References: <873cxxmmjt.fsf@www.gitteundmarkus.de>
	<Pine.LNX.4.33.0204160911040.509-100000@pnote.perex-int.cz>
	<s5h7kn729d9.wl@alsa2.suse.de> <87sn5vn72w.fsf@www.gitteundmarkus.de>
	<s5hads3vhph.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hads3vhph.wl@alsa2.suse.de> (Takashi Iwai's message of "Tue,
 16 Apr 2002 16:30:50 +0200")
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
> ok, now it's clear.

> interesting, perhaps on alsa implemented in the inversed manner.  if
> my guess is correct, you'll get digital outs by changing
> /usr/share/alsa/cards/EMU10K1.conf like the following:
> --- /usr/share/alsa/cards/EMU10K1.conf	2002-03-22 16:05:56.000000000 +0100
> +++ EMU10K1.conf	2002-04-16 16:23:28.000000000 +0200
> @@ -240,7 +240,7 @@
>  				name "SB Live Analog/Digital Output Jack"
>  				lock true
>  				preserve true
> -				value 1
> +				value 0
>  			}
>  		]
>  	}
> please check this?

Doesn't change anything really. I did an 'alsasound stop', edited
EMU10K1.conf and then 'alsasound start'. Was that right?

Regards
Markus
