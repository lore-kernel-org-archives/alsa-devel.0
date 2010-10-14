From: Alex <lee188@singnet.com.sg>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 14:25:09 +0800
Message-ID: <BF54D6FC-AAD7-4FD4-89EE-227BD85A4289@singnet.com.sg>
References: <201010131750.18897.julian@jusst.de>
	<loom.20101014T031422-361@post.gmane.org>
	<2021c8d0-f183-4739-a65c-703f3dfc5073@email.android.com>
Mime-Version: 1.0 (iPhone Mail 8A293)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp18.singnet.com.sg (smtp18.singnet.com.sg [165.21.6.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 61228103A3A
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 08:24:40 +0200 (CEST)
In-Reply-To: <2021c8d0-f183-4739-a65c-703f3dfc5073@email.android.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

19.13 with the most sig 7 bits not used.

Alex

Sent from my iPhone

On Oct 14, 2010, at 1:57 PM, Julian Scheel <julian@jusst.de> wrote:

> Hi Alex,
> 
> 
> "Alex" <lee188@singnet.com.sg> schrieb:
> 
>> The current alsa rate feedback rate feedback format is
>> 12.13 in 4 bytes.  Clemens has a patch to make the rate
>> feedback format automatic such that it will work with
>> 10.14 16.16 or any other formats.  We are still testing the
>> patch put .  Currently with 12.13 format rate feedback
>> works well.
> 
> How does it come that alsa uses 12.13? I don't see that mentioned in the specs?
> Is it right or left aligned in the 4 bytes?
> 
>> For example, AT91SAM7 has a limitation of EP siE of 64
>> bytes for EP 3 used for ISO transfers.  There may also be
>> a limitation in that the Same EP number cannot be used
>> for both IN and OUT.
> 
> Hm, I'm not sure about this. You think I should move the feedback pipe into it's own EP?
> I will recheck the At91SAM7 specs later, to see if I can find a note on such a limitation.
> 
> Thanks,
> Julian
> 
