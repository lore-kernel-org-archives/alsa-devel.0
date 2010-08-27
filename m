From: Eric Holstege <eric_holstege@yahoo.com>
Subject: Re: explicit commandline control of speakers vs
	headphone output
Date: Fri, 27 Aug 2010 11:46:45 -0700 (PDT)
Message-ID: <210284.64008.qm@web50707.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web50707.mail.re2.yahoo.com (web50707.mail.re2.yahoo.com
	[206.190.38.105]) by alsa0.perex.cz (Postfix) with SMTP id 466BC246A5
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 20:46:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks, Clemens;

How were you able to determine that from the "amixer scontents" output.

Although I can't disable *automatic* speaker mute on headphone 
insertion, can I explicitly unmute them again (e.g. with amixer sset or 
cset)?

If not....
"cat /proc/asound/card*/codec*" says it is the Realtek ALC888.
Does this mean I have to somehow patch the kernel sound module file
.../linux-source-2.6.*/sound/pci/hda/patch_realtek.c
to fix this somehow?

Regards
-Eric


Clemens Ladisch wrote:
> Eric Holstege wrote:
>   
>> Simple mixer control ...
>>     
>
> It looks as if your codec cannot be configured to disable the automatic
> headphone switching.
>
>
> Regards,
> Clemens
>
>
>   
