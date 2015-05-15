From: sylvain.bertrand@gmail.com
Subject: Re: USB-Audio.conf routing and dmix
Date: Fri, 15 May 2015 02:07:15 +0000
Message-ID: <20150515020715.GA418@freedom>
References: <20150509002017.GB18945@freedom> <20150511195734.GA12233@freedom>
 <55531850.1020208@ladisch.de> <20150513113215.GA569@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id AEB8E261540
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 04:07:16 +0200 (CEST)
Received: by wizk4 with SMTP id k4so266594588wiz.1
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 19:07:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150513113215.GA569@freedom>
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

On Wed, May 13, 2015 at 11:32:15AM +0000, sylvain.bertrand@gmail.com wrote:
> On Wed, May 13, 2015 at 11:24:32AM +0200, Clemens Ladisch wrote:
> >>> I linked the surround51 and surround71 pcms with the 'disable-able' dmix
> >>> section from the default pcm.
> > 
> > These devices are not supposed to use plug or dmix.
> 
> Ok. Then, there is no pcm to output 5.1 sound with dmix.
> 
> Does it mean that the application is in charge to build a alsa-lib pipeline
> with dmix pcm and surround51 pcm, in order to let other applications output 5.1
> sound at the same time?

Then what is the "Right"(tm) way to do that?

-- 
Sylvain
