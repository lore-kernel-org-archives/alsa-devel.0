From: Robert Tiemann <rtie@gmx.de>
Subject: Re: Sample format changes by plugin while playing
Date: Thu, 19 Apr 2018 16:22:02 +0200
Message-ID: <c7d05205-7990-3720-b687-157167a7c350@gmx.de>
References: <2f7e073c-b51a-dd7d-af89-9a10872faed1@gmx.de>
 <f022197f-4909-c901-b61f-cd8a197d46e8@gmx.de>
 <991e97ca-1176-c2a2-d376-a9c277334b03@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EA06267235
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 16:22:03 +0200 (CEST)
Received: from [192.168.15.101] ([87.245.7.122]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdHqj-1eisFn2BQv-00iX9Q for
 <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 16:22:02 +0200
In-Reply-To: <991e97ca-1176-c2a2-d376-a9c277334b03@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 04/19/2018 03:53 PM, Clemens Ladisch wrote:

>> Is it possible for an ALSA plugin to reconfigure the sample rate and
>> sample format of its slave in such a way that the software playing
>> through that plugin wouldn't notice?
> 
> In theory, yes.  But you'd have to implement most of this yourself.

That's fine, I just wanted to know if this could possibly work and if
an ALSA plugin could be the right place for this kind of stuff. That
is, before diving into development and hitting any roadblocks only
much later.

I guess "in theory" means that you don't know about any plugin of such
kind I could take a look at, right?

Thank you,
Robert
