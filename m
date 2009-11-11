From: Mads Kiilerich <mads@kiilerich.com>
Subject: Re: handling of underrunning snd_pcm_writei
Date: Wed, 11 Nov 2009 19:12:24 +0100
Message-ID: <4AFAFE88.5020508@kiilerich.com>
References: <4AFAEB44.60104@kiilerich.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FAF72454C
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 19:12:28 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so320731eyh.16
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 10:12:27 -0800 (PST)
In-Reply-To: <4AFAEB44.60104@kiilerich.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 11/11/2009 05:50 PM, Mads Kiilerich wrote:

> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#gf13067c0ebde29118ca05af76e5b17a9
> says about snd_pcm_writei:
>
>> Returns: a positive number of frames actually written otherwise a
>> negative error code
>> ...
>> Return values:
>> ...
>> -EPIPE an underrun occurred
>> ...
>> The count of bytes can be less only if a signal or underrun occurred.
...
> It surprises me that snd_pcm_writei shows non-blocking behaviour in case
> of underruns and don't use all the offered data. I would guess that it
> either blocked and enjoyed the data it finally got, or that it gave an
> error and didn't take any data at all. But if this is how it is, then
> ... that is how it is ;-)

Ok, experiments indicates that the documented blocking behaviour only 
applies in SND_PCM_STATE_RUNNING. snd_pcm_writei apparently behaves 
non-blocking in SND_PCM_STATE_PREPARED. I can see how that kind of makes 
sense - I just didn't expect that. Is that correctly understood?

/Mads
