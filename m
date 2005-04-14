From: Tom Watson <sdc695@yahoo.com>
Subject: Re: Speaker-test improvements
Date: Thu, 14 Apr 2005 13:41:47 -0700 (PDT)
Message-ID: <20050414204147.78276.qmail@web60808.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Måns Rullgård <mru@inprovide.com> Writes:


> Takashi Iwai <tiwai@suse.de> writes:
>
>> At Wed, 13 Apr 2005 21:02:31 +0100,
>> James Courtier-Dutton wrote:
>>> 
>>> Hi,
>>> 
>>> I have got some voice samples saying things like "Front Right" etc. that
>>> I want the speaker-test program to output instead of the loud sine wave
>>> it currently does. The sine wave will stay there as an option as I find
>>> it useful for some things.
>>> 
>>> The samples are 10 .wav files in 48khz mono S16_LE format.
>>> Where abouts should I put them in the CVS, and where abouts should they
>>> get installed to, so that speaker-test can find them?
>>
>> That's great.  (Is the voice female or male?  We might need both to be
>> PC ;)
>
>Not to mention all the languages of the world.
>
>-- 
>Måns Rullgård
>mru@inprovide.com


I made up a sound file similar to this and it was quite helpful.  One of the
files had individual voices (one at a time) to identify the speakers, and being
with the proper 4-channel specifications for broadcast they were identified as
"left front", "right front", "left BACK" and "right BACK".  In doing so it
eliminated the abbreviation of "R" being both "rear" and "right" (not very
clear).

Another test was having all of the channels identified "simultaneously",
usually in a loop.  This allowed me to play with mixer controls which always
get mixed up and get the correct things in the correct places.  When you hook
up sound cards and amplifiers and other external gear, it helps to have the
channel identified.  Some mixer controls on some cards fold the "back" channels
into the "front" channels, and then you need to poke around in your mixer
program ('alsamixer' is but one) to turn on/off "mutes" to get it right. 
Having the speaker test "loop" with spoken words was VERY helpful to me.

The only "problem" I see is having the samples at one speed.  Sometimes it is
helpful to have the program send the sounds out at a specific speed to the ALSA
api, where it does further operations (another re-sampling).

Another useful option on a sequential test would be to have the channel
identified on standard output at the beginning of the spoken words.

I really don't see a problem with the "voice" being male and English.  I
suspect that since it is ONLY A TEST, we don't need to be PC at all.

Perhaps the sound files for the sounds (mono for each, merged in the program)
can be put in such a place that they can be altered to suit the user.  It may
be that "LFE" may not be the desired name for the particular output.  There may
be 8 or more channels to identify, and maybe having them labeled "one"... would
be "better".  Given that more than one sound card might be used, and all slaved
thru plugins, it could go higher.  Who knows.

Just some thoughts...

-- 
Tom Watson
tsw@johana.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
