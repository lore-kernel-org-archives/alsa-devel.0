From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Thu, 19 Jan 2006 22:06:47 +0100
Message-ID: <9a8748490601191306q75b101b5g488aee398d420a00__7302.04978394813$1137704913$gmane$org@mail.gmail.com>
References: <20060119174600.GT19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.207])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3691F15E
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 22:06:49 +0100 (MET)
Received: by wproxy.gmail.com with SMTP id 70so318428wra
        for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 13:06:47 -0800 (PST)
In-Reply-To: <20060119174600.GT19398@stusta.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On 1/19/06, Adrian Bunk <bunk@stusta.de> wrote:
[snip]
> My proposed timeline is:
[snip]
> - after the release of 2.6.17 (and before 2.6.18):
>   remove the subset of drivers marked at OBSOLETE_OSS_DRIVER without
>   known regressions in the ALSA drivers for the same hardware

May I suggest you also update the "When" part of this entry in
Documentation/feature-removal-schedule.txt :

What:   drivers depending on OBSOLETE_OSS_DRIVER
When:   January 2006
Why:    OSS drivers with ALSA replacements
Who:    Adrian Bunk <bunk@stusta.de>

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
