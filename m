From: "Sander van Leeuwen" <sandervl@xs4all.nl>
Subject: Re: C-Media 8378 revision 37 & OPL3 midi
Date: Fri, 19 Jul 2002 15:23:45 +0200 (CDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207191323.g6JDNOLL077610@smtpzilla1.xs4all.nl>
References: <s5hn0soqa6z.wl@alsa2.suse.de>
Reply-To: "Sander van Leeuwen" <sandervl@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0soqa6z.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Jul 2002 12:33:08 +0200, Takashi Iwai wrote:
>> I have two cmedia cards; a revision 37 & 39. Everything
>> works well on the rev 39 card, but OPL3 midi is silent
>> on the rev37.
>> OPL3 initialization succeeds and there are no clear signs
>> of any problems. My first guess was that this revision
>> may have a difference (bug) with regards to the FM
>> volume. However, testing different mute & volume settings 
>> shows no improvement.
>Synth volume and switch?
Both. I even manually changed the registers during playback.

>> Is this a know problem of the ALSA driver, a hardware bug or 
>> even a defective OPL3 part in this particular revision?
>the support of opl3 is bad on this driver.
It's not bad at all as it is perfect on the rev 39 card.
Well, at least in the driver I ported to OS/2. Don't know about the Linux version
or even the latest code.

>it works somehow on my mine (rev 037) but the sounds are weird.
>maybe another (undocumented) initialization step would be necessary.
Too bad. Maybe I'll find out something soon. If I do, I'll send the results
to this list.

Sander



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
