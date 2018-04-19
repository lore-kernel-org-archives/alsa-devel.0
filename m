From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Sample format changes by plugin while playing
Date: Thu, 19 Apr 2018 15:53:26 +0200
Message-ID: <991e97ca-1176-c2a2-d376-a9c277334b03@ladisch.de>
References: <2f7e073c-b51a-dd7d-af89-9a10872faed1@gmx.de>
 <f022197f-4909-c901-b61f-cd8a197d46e8@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id A4F63267140
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 15:53:29 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 79E2D5583529
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 15:53:28 +0200 (CEST)
In-Reply-To: <f022197f-4909-c901-b61f-cd8a197d46e8@gmx.de>
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

Robert Tiemann wrote:
> Is this the correct list to ask questions about ALSA plugin development?

Yes.

> Is it possible for an ALSA plugin to reconfigure the sample rate and
> sample format of its slave in such a way that the software playing
> through that plugin wouldn't notice?

In theory, yes.  But you'd have to implement most of this yourself.


Regards,
Clemens
