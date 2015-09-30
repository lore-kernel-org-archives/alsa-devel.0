From: Panu Matilainen <pmatilai@laiskiainen.org>
Subject: Re: Zoom R16/24 playback slient
Date: Wed, 30 Sep 2015 09:43:13 +0300
Message-ID: <560B8481.1080304@laiskiainen.org>
References: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a82.g.dreamhost.com (sub5.mail.dreamhost.com
 [208.113.200.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 17C6F26069D
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 08:43:19 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 09/29/2015 11:19 PM, Ricard Wanderlof wrote:
>
> Bringing up an old thread from 2014 since I've gotten access to a Zoom R16
> and am keen on getting it to work in full duplex under Linux. Apparently
> (not yet verified here yet, rebuilding a kernel with the patch applied at
> the moment), 8 channel capture works with the quirk, but playback doesn't
> (well, it appears to work, but no sound comes out) and neither does the
> mixer.
>
>> At Sun, 30 Nov 2014 12:08:38 +0200,
>> Panu Matilainen wrote:
>>>
>>> On 11/29/2014 09:39 PM, Takashi Iwai wrote:
>>>> At Sat, 29 Nov 2014 21:35:04 +0200,
>>>> Panu Matilainen wrote:
>>>>>
>>>>> This makes the midi interface and capture work out of the box with
>>>>> R16 (and presumably R24 too but untested). Playback stream would also
>>>>> seem to function fine except for one caveat: no sound is produced,
>>>>> so it is disabled for now.
>>>
>>> [ ... ]
>>>
>>> In the meanwhile I started looking at the mixer - this is just guessing
>>> but maybe its starting with outputs muted which could explain the
>>> playback stream running but without sound.
>>>
>>> The descriptors for interface 0 are garbage but what is there would seem
>>> to map to logical elements by subtype and terminaltype, after those the> > data doesn't seem to add up (eg number of input/output channels
>>> missing/wrongly placed etc):
>>>
>>> ** UNRECOGNIZED:  0b 24 01 00 01 35 00 03 01 02 03
>>>      -> Header?
>>> ** UNRECOGNIZED:  0c 24 02 05 01 01 00 02 03 00 00 00
>>>      -> USB streaming input terminal?
>>> ** UNRECOGNIZED:  09 24 03 08 01 03 00 05 00
>>>      -> Speaker output terminal?
>>> ** UNRECOGNIZED:  0c 24 02 09 01 02 00 08 00 00 00 00
>>>      -> Microphone input terminal?
>>> ** UNRECOGNIZED:  09 24 03 0c 01 01 00 09 00
>>>      -> USB streaming output terminal?
>>>
>>> Anything there that might ring a bell, or other ideas where to start
>>> poking at this thing?
>>
>> Yeah, most of these look almost sane, so any off-by-one firmware
>> issue?
>
> Searching the archives, I could find no further posts on the subject of
> the R16. Panu, did you do any more work on this?

I did, but haven't gotten the playback to work (otherwise I would've 
sent a patch, obviously). Last five months have been a series of health 
issues for me so haven't had any energy left for poking at a stubbornly 
silent white box :)

> Where does the above output come from, and where could I find information
> on what type of data is expected? I assume what's expected is something
> one would get from an USB mixer device?

The output is simply 'lsusb -v' plus manually added guesses as to what 
these unrecognized bits are. The information is "out there", official 
USB documentation is valuable 
(http://www.usb.org/developers/docs/devclass_docs/) and looking at lsusb 
output of other similar products helps figure what might be there.

As for the mixer, I concluded the Zoom does not really have one. The 
interface 0 is a control interface where a mixer would reside, but 
there's no actual mixer unit in there.

> In an earlier incarnation of a patch for the R16 (on the 10th of March
> 2014), there's a discussion between Jason Mancine and Takashi regarding
> the .format field in the quirks table
> (http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074117.html)
> which didn't seem to reach a conclusion; the problem then seemed to be
> that even when setting the .format to SNDRV_PCM_FMTBIT_S24_3LE, ALSA still
> setup up a 32 bit transfer. However, Panu's patch also added a small delay
> in snd_usb_ctl_msg_quirk(), so that perhaps was the real solution to the
> alleged format problem? (The final patch is much smaller than in this
> particular thread, possibly due to the use of QUIRK_ANY_INTERFACE since
> kernel version >3.11 ?)

My memory is a bit hazy on the details, but the automatically detected 
SNDRV_PCM_FMTBIT_S32 (which iirc means the actual 24bit values are 
carried in 32bit chunks) seems to be the right thing for the device, 
forcing it to something else just makes things worse. IIRC. The delay 
was a key part, but not enough.

Another finding from my last round in the spring I do remember clearly, 
is that enabling both the input and output interfaces makes things hang 
up (timeouts and nothing really works). But if you disable the input 
interface and enable the output interface, you get an apparently working 
playback stream. Only no sound comes out. If you disable the output and 
enable input, capture itself works fine.

So perhaps it needs another quirk similar in spirit to the E-Mu:

         /* When capture is active
          * sample rate shouldn't be changed
          * by playback substream
          */
         if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK) {
                 if 
(subs->stream->substream[SNDRV_PCM_STREAM_CAPTURE].interface != -1)
                         return;

Or something. I do intend to continue poking at it sooner or later but 
can't make any promises.


	- Panu -

>
> /Ricard
>
