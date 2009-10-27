From: Douglas Lopes Pereira <douglaslopespereira@gmail.com>
Subject: Re: Problems with snd_pcm_writei() function
Date: Tue, 27 Oct 2009 15:07:00 -0200
Message-ID: <e0ab60670910271007w134ed082p992a73e1ea54312c@mail.gmail.com>
References: <e0ab60670910221034u498448c5ja4eae8c2f4fd0f66@mail.gmail.com>
	<4AE15DC7.7060108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id E86371037E3
	for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2009 18:07:00 +0100 (CET)
Received: by ewy21 with SMTP id 21so985343ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2009 10:07:00 -0700 (PDT)
In-Reply-To: <4AE15DC7.7060108@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

thanks for your replay. Sorry about the delay, I was taking care of
high priority tasks.

Back to my problem, I'm convinced that I'm passing the correct number
of frames. Do I have to change the buffer if discarding non complete
buffers (<> 160bytes)?

I'm not sure how timing is managed since my function is called by a
third part application but it looks like my code is invoked in a "for"
loop. Next is part of the code which calls my function:

			for (cur = f, next = AST_LIST_NEXT(cur, frame_list);
			     cur;
			     cur = next, next = cur ? AST_LIST_NEXT(cur, frame_list) : NULL) {
				if (!skip) {
					if ((res = chan->tech->write(chan, cur)) < 0) {
						chan->_softhangup |= AST_SOFTHANGUP_DEV;
						skip = 1;
					} else if (next) {
						/* don't do this for the last frame in the list,
						   as the code outside the loop will do it once
						*/
						chan->fout = FRAMECOUNT_INC(chan->fout);
					}
				}
				ast_frfree(cur);
			}


I sent a copy of my code to pastbin. It is available at:
http://www.pastebin.org/48749

I would be glad if you take a look at it.

Thanks for your time.
Regards,
Douglas

On Fri, Oct 23, 2009 at 5:39 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Douglas Lopes Pereira wrote:
>> I'm splitting my audio data into 160 bytes buffers but when buffer
>> with different size is passed to that function I hear a noise (like
>> 'Krrr') on my audio device.
>
> Do you actually pass the correct number of frames?
>
> How do you manage the timing of the snd_pcm_writei() calls?
>
>
> Best regards,
> Clemens
>
