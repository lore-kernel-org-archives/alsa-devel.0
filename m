From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: hdsp9652 mixer
Date: Thu, 10 Jul 2003 08:54:07 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <45967.81.51.162.201.1057820047.squirrel@www.undata.org>
References: <33068.217.128.161.242.1057308191.squirrel@www.undata.org>
        <1057796357.2959.8.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1057796357.2959.8.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: markknecht@comcast.net
Cc: thomas@undata.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Thomas,
>    I wanted to spend some time this afternoon trying this mixer patch
> out, but I'm not sure how to proceed. Maybe you can give me a
> suggestion. Thanks.
>
>    I'm running Gentoo. The current version of Alsa I have installed is
> Version 0.9.4-r1. I looked at your patch, and I also looked at the code
> I'm building from, and they don't seem to match up by line number, but
> the section you are modifying is in the file on my system. You're patch
> expected to find it on line 705, while in my code the equivalent
> position around line 677. My code has been patched beyond the CVS using
> two patches provided by Paul a couple of weeks ago. This may account
> completely for the differences, or maybe not. I'm not sure.
>
>    I'll probably try just inserting your code in by hand as it is pretty
> simple change, but I'm not sure if bad results will mean anything...
>
>    Let me know your thoughts.
>
> Thanks,
> Mark
>
>

You should apply my patch after Paul's ones. Even if the lines do not
match stricly, as long as the code is found and patched it is ok. Maybe
the difference is caused by Takashi's snd-page-alloc patch ?

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
