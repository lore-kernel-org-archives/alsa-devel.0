From: brunal2496 gmail <brunal2496@gmail.com>
Subject: Re: Exemple of source code for capture without using
	callback
Date: Fri, 23 Oct 2009 11:39:06 +0200
Message-ID: <9694340C-1DD9-4DBD-9BD9-D40B44D3983A@gmail.com>
References: <26289049-EACA-4DC6-A396-E2AF4EB6F2E9@gmail.com>
	<ad2655cb0910220740k5ef0f931j7f0ec48cb5d01cec@mail.gmail.com>
	<4AE074DB.4030600@ladisch.de>
	<ad2655cb0910221247y215abdb9sc5f4c2bb967d3846@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E51624422
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Oct 2009 11:39:08 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 19so2163149fgg.2
	for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2009 02:39:07 -0700 (PDT)
In-Reply-To: <ad2655cb0910221247y215abdb9sc5f4c2bb967d3846@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Tanks for your answer.

>> But _not_ the snd_async_add_pcm_handler function, which is evil.
>> (This is the only ALSA PCM function that mentions "callback" in its
>> documentation, so these are often confused.)
>>
>> The 'good' callback method means that the audio driver informs the
>> application when its wants to have new audio data, not the other way.

If I'm not wrong you're talking about playback in that case, isn't it?  
I'm considering capture so you mean that the good callback method is  
when the audio driver tells the application that it have new audio  
data (the buffer contains at least a "period_size" of audio samples)  
to give to it. Am I right?

> Yes, to clarify, not that call.
> A poll() that then does the callback is the preferred method.

Ok. But I cannot find a source code using poll() for capture on  
internet. Would you please gimme a pointer or at least a pseudo-code  
for an application using poll() i.e. just what is the sequence of the  
function?
Many thanks.
