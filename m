From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Re: aplay not playing MPEG
Date: Mon, 04 Aug 2003 16:32:29 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030804163230.1005.h007.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

I wrote:
>Can aplay/alsa send raw MPEG data to a card?
>> 
>>   aplay -Dhw:0  -v -t raw --channels=2 --format=MPEG --rate=44100
~/audio/44khz
>>   Playing raw data '/home/eliot/audio/44khz' : MPEG, Rate 44100 Hz, Stereo
>>   aplay: set_params:805: Sample format non available
>> 
>> This command works fine if I specify S16_LE, S23, FLOAT, S24, but not MPEG.
>> Any suggestions as to whe - do I have a hope of making it work?
>> (My card supports all the above including MPEG in exactly the same way as far
as
>> ALSA driver is concerned)
>> 
>> I have stepped through the code, and got lost in the bit twiddling of masks
and
>> formats.  One thing I notice is that only the linear formats are mentioned in
>> many of the functions in pcm_misc.c eg  snd_pcm_format_width()

Jaroslav wrote:
The handshake between driver and applications is not defined for MPEG and 
other compressed formats.

Can you describe the MPEG stream which your hardware expects? It will help 
us to design the APIs.

Takashi wrote:
the support of MPEG is still incomplete.
the same things are not defined in the kernel side, too.

we have to define the detail of this format.  for example, how the
driver should align the (mpeg-)frame size together with the ALSA frame
size, how can be the variable bitrate handled, etc.

perhaps the first step would be send just it as a byte stream with
the minimum alignment.  then add more restrictions...

My response:
Our hardware just expects a byte stream, it is not necessary to send whole
frames in a single write to the card.  

It is possible to query the buffer size, and how much data is left to play. 
Also available is the count of decoded PCM samples that have been played. 
Our hardware needs to know which layer MPEG the data belongs to. (for various
reasons we don't have a unified layer2 and layer3 decoder)

The possible difficulty with MPEG, especially VBR, is that the amount of data
played is not related to the samples played.  I am not sure how deeply this
assumption (that they ARE related) is embedded into the architecture.

If it is OK to have a "period" indicate that X bytes of compressed data have
been consumed, then if MPEG data could make it through the middle layers to my
driver, it would work right now.

- Eliot

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
