From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 6/8] ALSA: control: fix over 80 characters
 lines
Date: Thu, 12 Feb 2015 13:54:43 +0100
Message-ID: <54DCA293.2030900@perex.cz>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>	<1423651052-19593-7-git-send-email-o-takashi@sakamocchi.jp>
 <s5h4mqspshi.wl-tiwai@suse.de> <54DCA0EC.1010107@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id C08692604ED
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 13:54:44 +0100 (CET)
In-Reply-To: <54DCA0EC.1010107@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Dne 12.2.2015 v 13:47 Takashi Sakamoto napsal(a):
> On Feb 11 2015 21:01, Takashi Iwai wrote:
>> At Wed, 11 Feb 2015 19:37:30 +0900,
>> Takashi Sakamoto wrote:
>>> @@ -1010,7 +1013,8 @@ struct user_element {
>>>  	unsigned int elem_data_size;	/* size of element data in bytes */
>>>  	void *tlv_data;			/* TLV data */
>>>  	unsigned long tlv_data_size;	/* TLV data size */
>>> -	void *priv_data;		/* private data (like strings for enumerated type) */
>>> +	/* private data (like strings for enumerated type) */
>>> +	void *priv_data;
>>
>> Better to put the comment in the same line like other fields.
> 
> Which do you mean, we allow this line over 80 characters (keep what it
> was), or I should revise this comment within 80 characters considering
> the authours idea?

Keep it as-is. Any change will make the readability more worse.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
