From: sylvain.bertrand@gmail.com
Subject: Re: USB-Audio.conf routing and dmix
Date: Wed, 13 May 2015 11:32:15 +0000
Message-ID: <20150513113215.GA569@freedom>
References: <20150509002017.GB18945@freedom> <20150511195734.GA12233@freedom>
 <55531850.1020208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 82EAB265A8C
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 13:32:17 +0200 (CEST)
Received: by wgnd10 with SMTP id d10so37848660wgn.2
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 04:32:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55531850.1020208@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2015 at 11:24:32AM +0200, Clemens Ladisch wrote:
>>> I linked the surround51 and surround71 pcms with the 'disable-able' dmix
>>> section from the default pcm.
> 
> These devices are not supposed to use plug or dmix.

Ok. Then, there is no pcm to output 5.1 sound with dmix.

Does it mean that the application is in charge to build a alsa-lib pipeline
with dmix pcm and surround51 pcm, in order to let other applications output 5.1
sound at the same time?

regards,

-- 
Sylvain
