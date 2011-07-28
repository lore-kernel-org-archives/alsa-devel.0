From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: [PATCH] ALSA: asihpi - Clarify adapter index
	validity check.
Date: Fri, 29 Jul 2011 10:14:26 +1200
Message-ID: <4E31DF42.3050000@audioscience.com>
References: <1311803417-10328-1-git-send-email-linux@audioscience.com>
	<s5h62mn6juz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B7EF10381B
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 00:14:31 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LP2007K1DS27110@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 29 Jul 2011 10:14:27 +1200 (NZST)
In-reply-to: <s5h62mn6juz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 28/07/11 17:43, Takashi Iwai wrote:
		if ((adapter >= HPI_MAX_ADAPTERS) || (!pa->type)) {
>> -			hpi_init_response(&hr->r0, HPI_OBJ_ADAPTER,
>> -				HPI_ADAPTER_OPEN,
>> -				HPI_ERROR_BAD_ADAPTER_NUMBER);
>> +		if (!adapter_present) {
>> +			hpi_init_response(&hr->r0, hm->h.object,
>> +				hm->h.function, HPI_ERROR_BAD_ADAPTER_NUMBER);
> 
> Here you are initializing to different values (from HPI_OBJ_ADAPTER to
> hm->h.object, etc).  Is it intentional?

Yes it is. It is so the error response reflects the parameters of the
corresponding message.   It makes for better error logging in userspace.

I can redo the patch with better commit log if you like.
Adding "Correct error response to reflect message object/function ids"


-- 
Eliot Blennerhassett
AudioScience Inc.
