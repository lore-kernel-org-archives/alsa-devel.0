From: David Henderson <dhenderson@digital-pipe.com>
Subject: Re: additional problem
Date: Mon, 11 Jul 2011 10:26:05 -0400
Message-ID: <4E1B07FD.9030702@digital-pipe.com>
References: <4E0B2F67.3070304@digital-pipe.com>	<4E0C68ED.1070506@digital-pipe.com>
	<s5hiprmijtw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6ECAC244E1
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 16:28:11 +0200 (CEST)
Received: by gxk1 with SMTP id 1so1611850gxk.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2011 07:28:10 -0700 (PDT)
In-Reply-To: <s5hiprmijtw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/01/2011 02:41 AM, Takashi Iwai wrote:
> At Thu, 30 Jun 2011 08:15:41 -0400,
> David Henderson wrote:
>> On 06/29/2011 09:57 AM, David Henderson wrote:
>>> Hi gang!  I've successfully been able to compile the alsa-utils
>>> package with the
>>> "--with-alsa-inc-prefix=/opt/staging/alsa/var/share/include
>>> --with-alsa-prefix=/opt/staging/alsa/lib", but the problem I'm having
>>> now is that the compiled binaries are looking for those directories
>>> during run-time and not just compile-time.  Does anyone have any
>>> thoughts on using those directories for package creation, but that the
>>> software doesn't use the '/opt/staging/alsa' prefix during run-time?
>>>
>>> Thanks,
>>> Dave
>> bump for help
> It works usually as is.  Check once via ldd whether the binary is
> really linked with that fixed path.  You may hit a problem when using
> libtool with *.la files, for example.
>
>
> Takashi

Thanks for the continued help Takashi.  I've performed the requested 
steps, but all referenced libs are correct (e.g. /lib/... and not 
/opt/staging/alsa/lib/...).  Any other thoughts?

Thanks,
Dave
