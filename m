From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: How to put 16bit none audio PCM data stream into
 a 32bit none audio S/P-DIF transport stream?
Date: Tue, 08 Apr 2003 22:28:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E933EF6.5030601@superbug.demon.co.uk>
References: <20030408140230.GA1987@ulima.unil.ch> <E192u0x-0007pF-00@sc8-sf-list1.sourceforge.net> <s5hn0j1q97r.wl@alsa2.suse.de> <3E934193.6090605@cucumelo.org> <20030408205515.GB6940@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030408205515.GB6940@ulima.unil.ch>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Gregoire Favre wrote:

>On Tue, Apr 08, 2003 at 11:39:31PM +0200, Benny Sjostrand wrote:
>
>  
>
>>Exaclty what do you mean with 32bit spdif ? Sorry, I feel a little bit 
>>newbie about
>>the SPDIF protocol specific details.
>>    
>>
>
>Well,
>
>I have just copied an expert, Dr. Werner Fink, as he spoke in the
>vdr@linuxtv.org mailing list about a problem with AC3overDVB:
>
>"As long as the hardware on the DVB cards are not able to put
>the 16bit none audio PCM data stream into a 32bit none audio
>S/P-DIF transport stream all receivers which uses the bit flags
>of the S/P-DIF transport stream for identifying none audio
>loose.  All S/P-DIF data get from the DVB card to not have the
>none audio bit set.  AFAIK this is a hardware bug (or better
>this is the information I've got from TT) ..."
>
>So I guessed if we are some for which the CS46xx driver don't work with
>our receivers with the same sympton (here from the readme of AC3overDVB:
>"If your receiver doesn't detect the encapsulated stream (at the
>beginning of replay in general) you will hear the digital data played as
>PCM data. It's a spiky noise. Don't turn up the volume too much, or the
>speakers may be damaged. You have been warned!").
>
>  
>
Maybe I can try to clarify things a bit.
SPDIF uses 32bits to carry info bits and the audio data. This 32bits is 
called a frame.
The audio data can be anything up to 24 bits, and then the rest are the 
info bits (Like Copy-Protect, Non-audio etc.) .
Most computer audio cards hold the info bits in a single register and 
automatically fill in each frame's info bits using the contents of the 
register.
This leaves the other audio data to be filled by the PCM stream.
Most audio cards only support 16 bits, and very few support 24 bits, and 
virtually none support access to all 32 bits.
So, "iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2" sets the info bits 
register, with the audio data coming from the PCM.
For AC3 non-audio spdif, it uses only 16 bits, so we have no problem.
The real problem with AC3 via SPDIF on computer sound cards is the 
sample rate.
A lot of audio cards can only do SPDIF non-audio data at 48khz.
Your sample is requesting 44.1khz which could be the problem.
I do not know if your audio card support 44.1khz non-audio spdif. My SB 
Live definitely does not. My SB Live can output standard PCM data at 
different SPDIF rates, but it does re-sampling in hardware. If I wish to 
bypass the re-sampling hardware (bypass needed otherwise the non-audio 
data gets mangled) in my SB Live I have to use 48khz.

A good source of 48 khz non-audio AC3 sound is playing DVDs.
I know xine handles SPDIF passthru of AC3 soundtracks on DVDs quite easily.
At least this will test if the problem is 48/44.1 khz or something else.

Cheers
James





-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
