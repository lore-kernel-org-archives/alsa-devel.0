From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: RME Hammerfall HDSP 9652
Date: Thu, 28 Aug 2003 14:40:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32941.193.253.35.6.1062074441.squirrel@www.undata.org>
References: <20030827160852.D21247@nautronix.com.au>
        <34419.80.13.13.11.1061984366.squirrel@www.undata.org>
        <20030828182641.A28493@nautronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030828182641.A28493@nautronix.com.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: nick.arnold@nautronix.com.au
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> We've applied the patch to hdsp.{h,c}.  The newly built driver has
> ameliorated the problem of unexplained signal appearing on our output
> channels.  Thats a win.
>

Ameliorated or solved ?

>> Mark Knecht is currently using this code with success, but the card
>> behaved strangely with rev. 104 (0x68) firmware. He had to downgrade
>> it to rev. 101 (0x65) for the card to work properly.
>>
>> [and Mark concured he had to downgrade the firmware]
>
> We have not made any changes to the firmware thus far.  Unsure if its
> required or not.
>

To make things clear (partly regarding Paul's answer):
we use the word 'firmware' in two cases :
1) to designate the flashable onboard firmware of the hdsp cards, which
determines the card revision.
2) to designate the configuration data that needs to be uploaded into
external IO boxes (Multiface and Digiface) using hdsploader.

Hdsp9652 and 9632 cards do not need  a firmware in acception 2). Their
firmware (1), as well as the firmware (1) of PCI and cardbus hdsp cards,
can be altered using the firmware updater tool available for Mac and
Windows on RME's website. I will write a similar tool for linux in the
next months.

> 1) do we need to do this?  Are there some characteristic symtoms to look
> for?
>

Mark Knecht experienced problems using rev 104 (0x68) firmware (1) on his
hdsp9652. Symptoms are intermitent stops and resumes of any audio
processing by the card (playback and routing). I asked RME about this, but
got no satisfying reply so far. Rev. 101 (0x65) firware (1) seems to work
fine, but you'll need a windows install to use the tool from RME.

> Okay, we've set the "Sample Clock Source" on the mixer to 96kHz.  This
> has changed the output of "amixer -contents" to show 14 output channels
> instead of 26.  We can open the card in this mode and can use "aplay"
> and "arecord" (see more discussion below).
>
> However, I'd appreciate some clarification on this point.  This setting
> seems to imply that the new card can run at 96kHz and is aware that 2
> 48kHz ADAT channels are to be combined into one logical 96kHz channel.
> Also that the card itself will look after the interleaving and
> de-interleaving of these channels.
>
> 2) is my understanding of the 96kHz mode correct?
>
>

I think so.

 3) is it possible to use the "Internal 48.0 kHz" setting and keep things
>    "like they used to be"?  Whereby we retain responsiblity for the
> interleaving and de-interleaving of channels; we operate on the full
> 26 channels; and we can make little (if any) code changes?

No, you can't. The internal rate is then really 96kHz, and the clock
signal on the spdif output is indeed 96kHz. One thing you could do, maybe,
 would be to simulate in userspace what the card is doing in hardware,
keeping the 48 kHz sample rate, if you really need that.

Thomas





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
