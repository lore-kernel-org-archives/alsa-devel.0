From: David Henderson <dhenderson@digital-pipe.com>
Subject: Re: compile problems
Date: Mon, 27 Jun 2011 11:06:11 -0400
Message-ID: <4E089C63.3080407@digital-pipe.com>
References: <4E088113.6040500@digital-pipe.com>	<BANLkTi=mDwbo59wT5tAhmV0K60f6+TT2BQ@mail.gmail.com>	<4E088C15.3030608@digital-pipe.com>	<BANLkTikPDJ3UQgoaPniBEei3pkVQT=b0hw@mail.gmail.com>
	<BANLkTim-W1S7Gv1EKDSga8ScxhiVaicy=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 21FF0243FA
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 17:07:55 +0200 (CEST)
Received: by yxm34 with SMTP id 34so1686647yxm.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2011 08:07:54 -0700 (PDT)
In-Reply-To: <BANLkTim-W1S7Gv1EKDSga8ScxhiVaicy=Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Pardini <pardo.bsso@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/27/2011 10:27 AM, Adrian Pardini wrote:
> On 27/06/2011, Adrian Pardini<pardo.bsso@gmail.com>  wrote:
> [...]
>> Also you may have to set the
>> LDFLAGS environment variable to point to where your libraries are
>> being installed under /opt
>
> --with-alsa-prefix looks more suitable. Maybe
> --with-alsa-prefix=opt/staging/alsa/var/ is all you need.
>

Ok, I tried using this configure parameter instead of the 
--with-alsa-inc-prefix, but it's still bombing.  I even tried compiling 
using each sub-directory as the value until the actual value was the 
entire path to where the header files were stored - each providing the 
same error message.  One thing I did notice was by using the different 
configure parameter, the output was slightly different:

using --with-alsa-inc-prefix=...
<snip>
checking for ALSA CFLAGS...  -I/opt/staging/alsa/var
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >= 1.0.16... not present.
configure: error: Sufficiently new version of libasound not found.

using --with-alsa-prefix=...
<snip>
checking for ALSA CFLAGS...
checking for ALSA LDFLAGS...  -L/opt/staging/alsa/var -lasound -lm -ldl 
-lpthread
checking for libasound headers version >= 1.0.16... not present.
configure: error: Sufficiently new version of libasound not found.

Do I still need to adjust the LDFLAGS variable since it looks like it's 
passing that value to it already?

Thanks,
Dave
