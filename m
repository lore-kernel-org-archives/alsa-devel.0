From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [PATCH] rme96 synchronization support
Date: Tue, 06 Aug 2013 19:42:17 +0200
Message-ID: <52013579.7020304@t-online.de>
References: <51FF9C55.80701@t-online.de> <51FFA643.7060504@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D63B261673
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 19:42:28 +0200 (CEST)
In-Reply-To: <51FFA643.7060504@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05.08.2013 15:18, Clemens Ladisch wrote:
> Knut Petersen wrote:
>>   			      SNDRV_PCM_INFO_MMAP_VALID |
>> +                              SNDRV_PCM_INFO_SYNC_START |
> Please use tabs like in other similar parts of the file.

ack

>>   static void
>> +snd_rme96_playback_start(struct rme96 *rme96,
>> +			 int from_pause)
>> +{
>> +	if ((rme96->playback_substream && rme96->capture_substream) &&
>> +	    (rme96->playback_substream->group =3D=3D rme96->capture_substream-=
>group)) {
>> +		snd_rme96_playcap_start(rme96,from_pause);
>> +	} else {
>> +		if (!from_pause) {
>> +			writel(0, rme96->iobase + RME96_IO_RESET_PLAY_POS);
>> +		}
>> +		rme96->wcreg |=3D RME96_WCR_START;
>> +		writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGISTER);
>> +	}
>> +}
> This is hard to maintain because there is duplicated code.
>
> The proper way to write a synchronized start/stop trigger is to collect
> the needed register bits first, and then apply them at once to the
> register; this works for both single and grouped usage:

Yes, there is duplicated code ... I=B4ll remove that in a V2 of the patch.
But I do not think that it is less readable/maintainable if bit masks are
prepared at the place of use ...

>> -	=

>> +
> Are these whitespace changes deliberate?

No, they are artifacts of inserting/removing debug code at a place
where originally a line with nothing but a tabulator is present.

Your comments were all about coding style. Have you had a look
at the content of the code?

cu,
  Knut
