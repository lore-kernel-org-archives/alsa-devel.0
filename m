From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: RME Hammerfall HDSP 9652
Date: Thu, 28 Aug 2003 08:04:33 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308281204.h7SC4YeW005393@oud>
References: <20030828182641.A28493@nautronix.com.au>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 28 Aug 2003 18:26:41 +0800."
             <20030828182641.A28493@nautronix.com.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nick Arnold <nick.arnold@nautronix.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> Mark Knecht is currently using this code with success, but the card
>> behaved strangely with rev. 104 (0x68) firmware. He had to downgrade it to
>> rev. 101 (0x65) for the card to work properly. 
>>
>> [and Mark concured he had to downgrade the firmware]
>
>We have not made any changes to the firmware thus far.  Unsure if its
>required or not.  

if you can load the driver and the "firmware" (aka "configuration
data", done by hdsploader), then you don't need to worry about this, AFAIK.
however, use lspci -vv to get full version info on the system you
have - the "rev" number indicates the firmware you have.

>Okay, we've set the "Sample Clock Source" on the mixer to 96kHz.  This has
>changed the output of "amixer -contents" to show 14 output channels instead
>of 26.  We can open the card in this mode and can use "aplay" and "arecord"
>(see more discussion below).
>
>However, I'd appreciate some clarification on this point.  This setting seems
>to imply that the new card can run at 96kHz and is aware that 2 48kHz ADAT
>channels are to be combined into one logical 96kHz channel.  Also that the
>card itself will look after the interleaving and de-interleaving of these
>channels.  

this is done in hardware yes.

>2) is my understanding of the 96kHz mode correct?

mostly, yes.

>3) is it possible to use the "Internal 48.0 kHz" setting and keep things
>   "like they used to be"?  Whereby we retain responsiblity for the
>   interleaving and de-interleaving of channels; we operate on the full 26
>   channels; and we can make little (if any) code changes?

to be honest, i don't know what you're really thinking. implementing
this in software by pretending you have 26 channels is, well, a bit
odd. at 96kHz, you have 14 channels, not 26. it just so happens that
the limitations of the ADAT protocol force bitsplitting onto the
situation, but i think you should really forget about that. 

you certainly could do this, and under some cirucmstances it would
work. but under others, it would not. i have never seen or heard of
any ADAT-enabled interface manufacturer encouraging this approach.

>4) why is the number of channels now 14?  It would seem to make sense for it
>   to be 13 -- half the total 46kHz channels available.  

no, because some of the channels are S/PDIF, which supports 96kHz
natively. you've got:

   at <= 48kHz

	  3 * 8 = 24 ADAT channels
	  2 S/PDIF channels

   at >= 88.2kHz

         3 * 4 = 12 ADAT channels
	 2 S/PDIF channels

>We've conducted a test using "aplay" and "arecord":

bad idea. neither of the programs are real-time safe. use ecasound or
jack for testing.

>PS. Mark also mentioned some problems related to the spdif still remain in
>the driver.  We are not using the spdif interface so I'm assuming we can
>safely ignore those issues.

based on your description, i believe you can, yes.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
