From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: snd-usb: tighten EP_FLAG_RUNNING
 checks
Date: Thu, 12 Jul 2012 16:58:40 +0200
Message-ID: <4FFEE620.1090003@gmail.com>
References: <1342099187-6978-1-git-send-email-zonque@gmail.com>
	<4FFEDF38.7060808@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id E6BE2244AE
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2012 16:58:45 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so1741958bkc.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Jul 2012 07:58:45 -0700 (PDT)
In-Reply-To: <4FFEDF38.7060808@ladisch.de>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, philipp@dreimann.net, joseph.salisbury@canonical.com
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On 12.07.2012 16:29, Clemens Ladisch wrote:
> Daniel Mack wrote:
>> In endpoint.c, bail out earlier in case the stream is stopped.
>> ...
>> @@ -350,7 +350,8 @@ static void snd_complete_urb(struct urb *urb)
>>  		     urb->status == -ENODEV ||		/* device removed */
>>  		     urb->status == -ECONNRESET ||	/* unlinked */
>>  		     urb->status == -ESHUTDOWN ||	/* device disabled */
>> -		     ep->chip->shutdown))		/* device disconnected */
>> +		     ep->chip->shutdown) ||		/* device disconnected */
>> +		     !test_bit(EP_FLAG_RUNNING, &ep->flags))
>>  		goto exit_clear;
> 
> Is this really needed?
> The URBs will be unlinked at the same time.

This just brings the code in sync with what we had before. If URBs are
just unlinked but not killed, they will return with data payload, and in
case of implicit feedback streams, the retire code could issue new
output packets. Might be I overlooked a reason why that could never
happen, but even if I did, the check here doesn't hurt, right?


Daniel
