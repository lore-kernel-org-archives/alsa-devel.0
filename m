From: Markus Plail <plail@web.de>
Subject: Re: AC3 Passthru on SB Live
Date: 28 Feb 2002 12:01:45 +0100
Message-ID: <87664hswdi.fsf@www.gitteundmarkus.de>
References: <NGBBLNODKDFPBFMBBFAFMEDMCCAA.James@superbug.demon.co.uk>
	<s5h8z9elvmc.wl@alsa2.suse.de>
In-Reply-To: <s5h8z9elvmc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Date: 28 Feb 2002 12:01:45 +0100
Message-ID: <878z9dswdi.fsf@www.gitteundmarkus.de>
Lines: 29
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
--text follows this line--
* "Takashi" == Takashi Iwai schrieb am Wed, 27 Feb 2002 17:47:39 +0100:
> At Wed, 27 Feb 2002 15:50:47 -0000,
> James Courtier-Dutton wrote:
>> Hello
>> 
>> AC3 passthru on the SB Live does not seem to work on all platforms
>> with the latest alsa-cvs. (26-2-2002) It works on my system, which
>> is a SB Live Rev 6, which only started working recently.

> Just curious - are you using a kernel with HIGHMEM config?  If
> working with this config, then it should not be a problem of memory
> allocation.  Or, it might be the problem of dma mask.  ALSA uses
> 31bit mask while Creative's driver uses 29bit.  But anyway this
> won't affect unless you have more than 512MB RAM and kernel
> ocasionally allocates the area greater than 512MB.
James has a rev 06 card so it doesn't apply to him. I have a rev07
card and it doesn't work and I don't have HIGHMEM enabled.

>> It does not work on a SB Live rev 7 (I don't have this, but others
>> have reported.)

> IIRC, we still don't implement the direct pass-through method (PASS2
> in Creative's driver) for the recent models (rev.7 or newer).
> Perhaps this makes difference.
Are there plans to implement this? Can I help with doing that? Don't 
know if any of the developers have a rev07 card.

Regards
Markus


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
