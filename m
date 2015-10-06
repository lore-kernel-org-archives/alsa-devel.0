From: Panu Matilainen <pmatilai@laiskiainen.org>
Subject: Re: Zoom R16/24 playback slient
Date: Tue, 6 Oct 2015 12:40:15 +0300
Message-ID: <561396FF.70804@laiskiainen.org>
References: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
 <560B8481.1080304@laiskiainen.org>
 <alpine.DEB.2.02.1510060847350.19610@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a59.g.dreamhost.com (sub5.mail.dreamhost.com
 [208.113.200.129])
 by alsa0.perex.cz (Postfix) with ESMTP id E3F052605AE
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 11:40:21 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1510060847350.19610@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/06/2015 10:02 AM, Ricard Wanderlof wrote:
>
> On Wed, 30 Sep 2015, Panu Matilainen wrote:
>
>> My memory is a bit hazy on the details, but the automatically detected
>> SNDRV_PCM_FMTBIT_S32 (which iirc means the actual 24bit values are
>> carried in 32bit chunks) seems to be the right thing for the device,
>> forcing it to something else just makes things worse. IIRC. The delay
>> was a key part, but not enough.
>>
>> Another finding from my last round in the spring I do remember clearly,
>> is that enabling both the input and output interfaces makes things hang
>> up (timeouts and nothing really works). But if you disable the input
>> interface and enable the output interface, you get an apparently working
>> playback stream. Only no sound comes out. If you disable the output and
>> enable input, capture itself works fine.
>
> Having dived into this, and looking carefully at the data produced by the
> Windows driver, it appears that what's happening is that the driver stuffs
> a 32-bit length specifier at the start of each isochronous data packet.
>
> So, for instance, instead of transferring the sample data
>
> 00 12 bf 34  00 98 87 76  00 3c 24 35  00 86 75 64 .. .. (40 bytes)
>
> the Zoom driver would send:
>
> 28 00 00 00  00 12 bf 34  00 98 87 76  00 3c 24 35  00 86 75 64 ... (44 bytes)
>
> No wonder the Zoom gets confused when it gets sent ordinary sample data,
> and tries to interpret the first sample value as a length.
>
> There doesn't seem to be anything in the ALSA USB driver to do this, and
> I'm thinking it's Zoom specific (perhaps to overcome some deficiency in
> the hardware (or USB firmware) in the R16?).

FWIW, while poking around the source I spotted this in sound/usb/midi.c:

/*
  * Novation USB MIDI protocol: number of data bytes is in the first byte
  * (when receiving) (+1!) or in the second byte (when sending); data begins
  * at the third byte.
  */

Just goes to show such quirks are not previously unheard-of. It's MIDI 
so the details differ, but perhaps a similar approach could be used for 
PCM too.

	- Panu -
