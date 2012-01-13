From: Elias Kokkinis <ekokkinis@upatras.gr>
Subject: Re: Read and write different buffer sizes
Date: Fri, 13 Jan 2012 19:42:09 +0200
Message-ID: <F67C0857-6EB8-4EEF-8485-1445114699AB@upatras.gr>
References: <B927995C-7CD1-46DF-9B58-A4E62574A688@upatras.gr>
	<4F104748.2000900@ladisch.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nic.upatras.gr (nic.upatras.gr [150.140.129.30])
	by alsa0.perex.cz (Postfix) with ESMTP id A8526244CA
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 18:42:12 +0100 (CET)
In-Reply-To: <4F104748.2000900@ladisch.de>
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

Clemens, thanks for your reply.

Do you think there is a way to accomplish this using different period sizes in input/output? I haven't exactly grasped the way ALSA reads and writes yet, so I have a difficult time planning how to do this...

Elias

On 13 Jan 2012, at 17:01, Clemens Ladisch wrote:

> Elias Kokkinis wrote:
>> I would like to ask if it is possible in ALSA to define different
>> buffer sizes in the input and output streams.
> 
> Yes.  (But which buffer sizes are allowed always depends on the
> hardware's capabilities.)
> 
>> I am using PCM sound and I want to read 2048 samples, do some
>> processing involving overlap-add and then keep 1024 of them and put
>> them to the output. And so on...
>> 
>> So I want to have the same sample rate and everything but different
>> buffer sizes. Is this possible? I have tried an implementation of
>> this, but I think the output for some reason still outputs 2048
>> samples and the audio is choppy, like having 1024 samples of audio and
>> 1024 of silence.
> 
> Regardless of the buffer size, when both devices run at the same rate,
> you must output, on the average, as many samples as you have read.
> 
> 
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
