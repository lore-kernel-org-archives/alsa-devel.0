From: Markus Plail <plail@web.de>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1
 emu10k1_main.c,1.12,1.13
Date: Mon, 15 Apr 2002 09:46:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <873cxxmmjt.fsf@www.gitteundmarkus.de>
References: <E16uY8V-0002TN-00@usw-pr-cvs1.sourceforge.net>
	<3CB5A0CF.1000103@superbug.demon.co.uk> <s5h3cy2ky7g.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cy2ky7g.wl@alsa2.suse.de> (Takashi Iwai's message of "Thu,
 11 Apr 2002 18:16:19 +0200")
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

Hi Takashi!

* Takashi Iwai writes:
> At Thu, 11 Apr 2002 15:42:23 +0100,
> James Courtier-Dutton wrote:
>> 
>> [1  <text/plain; us-ascii (7bit)>]
>> Takashi Iwai wrote:
>> 
>> >Update of /cvsroot/alsa/alsa-kernel/pci/emu10k1
>> >In directory usw-pr-cvs1:/tmp/cvs-serv9192
>> >
>> >Modified Files:
>> >	emu10k1_main.c 
>> >Log Message:
>> >fixed default mask values
>> >(these change won't affect the actual behavior, though)

[snip]

>> This seems to have fixed AC3 Passthru mode on SB Live (rev 7) cards.
>> Just so you know, all SB Live cards worked before for AC3 Passthru 
>> except the rev 7 cards.
>> I just got a report on the xine-user list about it.
>> Ok, so you did not know you were fixing it, but well done anyway!!!! ;-)
> err, frankly speaking, i still don't figure out why with this change
> the pass-through works.  i'm glad to to hear a good news, anyway ;)

Just wanted to let you know that it wasn't the changes in emu10k1_main.c,
but the changes in emumixer.c that made my (I was the one reporting it on
the xine ML) rev07 card working.

Perhaps this helps
Regards
Markus
