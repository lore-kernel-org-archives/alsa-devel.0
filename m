From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Fwd: [was Re: [linux-audio-user] Multiple (three) RME Hammerfalls...
 any	experience]
Date: Sat, 29 Nov 2003 21:32:57 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FC891F9.20701@boosthardware.com>
References: <20031129072006.80694.qmail@web20903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: A list for linux audio users <linux-audio-user@music.columbia.edu>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have forwarded this to alsa-devel as there is probably more luck 
finding the answer here and it would be a valuable thread to have as a 
resource.

R Parker wrote:
> Hi,
> 
> I can't help you much, however, unless JACK has
> recently been worked on I think there's a 32 track
> limitation. It's known to be technically trivial.
> Otherwise I don't believe alsa would be a problem,
> assuming you've got wordclock i/o on the hammerfall
> cards. 
> 
> Midi Time Code syncronization in Ardour could also be
> problematic, it doesn't work with my Tascam DM-24.
> Even though transport location is accurate, the
> automation system can't interpret Ardour mtc. Paul has
> announced his intention to implement SMPTE but I'm not
> sure if that's been done yet.
> 
> I wonder what the status of 96kHz adat is with the
> hammerfall drivers.
> 
> Anyway, that's not much help. Sorry.
> 
> ron
> 
> --- Ronald van Engelen <ronalde@xs4all.nl> wrote:
> 
>>Hi,
>>
>>After rereading my message, I saw too many
>>unclarities and typos, so
>>I'll try again.
>>
>>The problem is that we have to transfer a few hours
>>of 72-channel music
>>from three synced Mackie SDR24/96's to a harddisk. I
>>don't really know 
>>what format the music is recorded in.
>>
>>As my colleague is unable to use three RME
>>Hammerfall DSP card's in his
>>dual G4 powermac with OSX (don't know exact
>>version), I wondered if I
>>could use Linux to capture the music to harddisk.
>>
>>If anybody has any experience, please let me know.
>>Otherwise we will
>>proceed with one card and thus 24 channels at a
>>time, which does work.
>>
>>Thanks,
>>Ronald van Engelen
>>
>>
>>Op vr 28-11-2003, om 20:06 schreef Ronald van
>>Engelen:
>>
>>>Hi there,
>>>
>>>A colleague of mine is having major problems using
>>
>>multiple (three) RME
>>
>>>Hammerfall cards using Mac OS 9 and X and
>>
>>consulted me for help. 
>>
>>>The problem is that he has to transfer a few hours
>>
>>of 72-channel music
>>
>>>(recorded with Mackie HDR's) to his harddisk for
>>
>>further mixing and
>>
>>>processing.
>>>
>>>I only have experience with (single and dual)
>>
>>stereo cards using alsa,
>>
>>>jack, ardour and ladspa. I wonder if anybody have
>>
>>experience with
>>
>>>multiple RME cards using alsa, and particullary
>>
>>experience doing such a
>>
>>>task with mentioned tools? 
>>>
>>>I haven't had the chance to examine his
>>
>>(Mac-related) problem but it
>>
>>>sounds like he might suffering from problems
>>
>>related to his
>>
>>>power-supply?
>>>
>>>Regards,
>>>Ronald van Engelen
>>>
>>>


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================


  Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
