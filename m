From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Sample format changes by plugin while playing
Date: Thu, 19 Apr 2018 17:57:54 +0200
Message-ID: <7c046ed4-9f38-31d3-61b7-b8b68bd5054c@ladisch.de>
References: <2f7e073c-b51a-dd7d-af89-9a10872faed1@gmx.de>
 <f022197f-4909-c901-b61f-cd8a197d46e8@gmx.de>
 <991e97ca-1176-c2a2-d376-a9c277334b03@ladisch.de>
 <c7d05205-7990-3720-b687-157167a7c350@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 62EB1267235
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 17:58:20 +0200 (CEST)
Received: from olorin.ladisch.de (x2f7f93d.dyn.telefonica.de [2.247.249.61])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 504D555819C4
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 17:58:19 +0200 (CEST)
In-Reply-To: <c7d05205-7990-3720-b687-157167a7c350@gmx.de>
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
> I guess "in theory" means that you don't know about any plugin of such
> kind I could take a look at, right?

No; most plugins force the configuration of the slave to be similar, and
to be done at the same time as their own.

PulseAudio does something similar to this, but it's much more complex
than just an ALSA plugin.


Regards,
Clemens
