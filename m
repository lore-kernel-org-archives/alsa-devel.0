From: Benno Senoner <sbenno@gardena.net>
Subject: Compro TV VideoMate Gold Plus, FM Tuner audio to ALSA ?
Date: Tue, 11 Jan 2005 01:54:09 +0100
Message-ID: <41E323B1.2010401@gardena.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: alsa-devel@lists.sourceforge.net, eric.dorland@mail.mcgill.ca
List-Id: alsa-devel@alsa-project.org

Hi alsa folks,

I've read good reviews about this TV/FM card around, especially 
regarding the FM radio
quality.

http://www.tv-cards.com/tvgoldplus.php


according to this message, there seems a patch to make this card work
http://www.spinics.net/lists/vfl/msg12422.html
and a short grep in the 2.6.10 kernel tree reveals that it is supported 
out of the box: (2.6.9 did not support it)

./linux-2.6.10/drivers/media/video/saa7134/saa7134-cards.c:    
[SAA7134_BOARD_VIDEOMATE_TV_GOLD_PLUS] = {
./linux-2.6.10/drivers/media/video/saa7134/saa7134-cards.c:             
.name           = "Compro VideoMate TV Gold+",


It would be nice to be able to to being able to have an ALSA / jack (on 
a kernel 2.6 system, eg FC2/FC3) setup using
a good soundcard to output the audio from the FM receiver digitally 
through jack.

The question what would in your opinion be needed to make such a setup 
work ?
Assume one gets the FM card working under v4l with OSS output.
What must be done to get this output into ALSA ?
eg do v4l OSS modules conflict with ALSA modules under kernel 2.6 ?

the review states: "... The tuner is a Philips FM1236 feeding a Philips 
SAA7134HL 9-bit ADC chip.  .. "
I quick grep in the alsa 1.0.7 driver source seems that this chip is not 
natively supported in ALSA yet.

So any chance to feed the FM audio digitally into an ALSA card without 
resorting to the old analog cable
solution ?

For additional infos see attached mail of a conversation I had with Eric 
Dorland (author of the patch).

thanks in advance for infos and thoughts on the matter.

cheers,
Benno

* Benno Senoner wrote:

>> Hi,
>> I saw this message on the v4l list.
>> I am considering buying this TV card and I am in particular interested
>> in the FM tuner part since I heard it provides good audio quality.
>> Is it currently supported ?
>  
>

i personally wasn't interested in the FM tuner and have never used. I
did extract the gpio bits for it, so in theory it should work, but I
don't know anyone who's tested it. As for audio quality, no clue, but
the TV quality was pretty good considering the price of the card.


>> What do I need to make it work ? just use a bleeding edge 2.6 kernel ? 
>> (stable).
>  
>

Well the patches are in Gerd Knorr's patchsets on linux.bytesex.org so
you would probably need those. Eventually those patches reach the
mainline kernel, but as all things it can take time. I didn't check if
my changes were in 2.6.9, they're definitely not in 2.6.8. 
 

>> Do you know if the FM audio can be captured digitally via OSS or ALSA ?
>> (I remembed some bttv cards can do it via btaudio OSS module).
>  
>

You can do this, you need to pass the oss=1 flag (or something like
that) to the driver. 


>> How about multiple cards support ?
>> It would be cool to listen do one FM station while recording another in the
>> background (digitally).
>  
>

You'd need two cards for that, which should work just fine (in theory).

-- Eric Dorland




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
