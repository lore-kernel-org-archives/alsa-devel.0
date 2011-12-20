From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: implement new endpoint
 streaming model
Date: Tue, 20 Dec 2011 21:08:01 +0100
Message-ID: <4EF0EB21.1050605@gmail.com>
References: <1324374520-32332-1-git-send-email-zonque@gmail.com>
	<1324374520-32332-3-git-send-email-zonque@gmail.com>
	<s5hehvzgsfx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A72324413
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 21:08:06 +0100 (CET)
Received: by eekb57 with SMTP id b57so6529024eek.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 12:08:05 -0800 (PST)
In-Reply-To: <s5hehvzgsfx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: blablack@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On 12/20/2011 04:42 PM, Takashi Iwai wrote:
> At Tue, 20 Dec 2011 10:48:37 +0100,
> Daniel Mack wrote:
>>
>> @@ -99,7 +104,7 @@ static int deactivate_urbs(struct snd_usb_substream *subs, int force, int can_sl
>>   */
>>  static void release_urb_ctx(struct snd_urb_ctx *u)
>>  {
>> -	if (u->urb) {
>> +	if (!u || u->urb) {
>>  		if (u->buffer_size)
> 
> This will lead to Oops when u == NULL, no?

Yes, that's right. That said, it seems this hunk can be removed
entirely. I'll fix this in the next version.

>> +/* determine the number of frames in the next packet */
>> +static int next_packet_size(struct snd_usb_endpoint *ep)
>> +{
>> +	unsigned long flags;
>> +
>> +	if (ep->fill_max)
>> +		return ep->maxframesize;
>> +
>> +	spin_lock_irqsave(&ep->lock, flags);
>> +	ep->phase = (ep->phase & 0xffff)
>> +		+ (ep->freqm << ep->datainterval);
>> +	spin_unlock_irqrestore(&ep->lock, flags);
>> +
>> +	return min(ep->phase >> 16, ep->maxframesize);
> 
> If you need a protection here, safer to cover until min(), I guess.

Ok, will do.

I'll wait with a new version until there's feedback from people who
tested the code on their hardware :)

Thanks for the review.

Daniel
