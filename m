From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: [PATCH] alsa-info.sh - Fixed typo that stops
	the	'Automatic Upload' warning from appearing.
Date: Tue, 20 May 2008 23:07:21 +1000
Message-ID: <1211288841.3811.1.camel@localhost>
References: <200804290010.52696.wishie@wishie.net>
	<s5h1w4nwly1.wl%tiwai@suse.de> <200805190008.30421.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id D5B382488F
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 15:07:25 +0200 (CEST)
In-Reply-To: <200805190008.30421.wishie@wishie.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Travis Place <wishie@wishie.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Travis,

Thanks for fixing this. I got burned by it today running it on a
computer at work. I was none too pleased to see my machine details
uploaded.

Anyway, thanks for fixing it.

Ben Stanley.

On Mon, 2008-05-19 at 00:08 +1000, Travis Place wrote:
> Fixed a typo that was causing no warning about the script automatically 
> uploading info to a pastebin. Some users were NOT too happy with this.
> 
> Also, bumped up the version number so existing versions will automatically 
> update to the fixed version upon next script run.
> 
> 
> diff -r 93548f7b2086 alsa-info.sh
> --- a/alsa-info.sh	Wed Apr 30 14:47:42 2008 +0200
> +++ b/alsa-info.sh	Mon May 19 00:01:04 2008 +1000
> @@ -1,6 +1,6 @@
>  #!/bin/bash
>  
> -SCRIPT_VERSION=0.4.43
> +SCRIPT_VERSION=0.4.44
>  CHANGELOG="http://hg.alsa-project.org/alsa/log/tip/alsa-info.sh"
>  
> 
> #################################################################################
> @@ -215,7 +215,7 @@ if [ "$QUESTION" = "yes" ]; then
>  if [ "$QUESTION" = "yes" ]; then
>  if [[ -n "$DIALOG" ]]
>  then
> -if [ -z "NOUPLOAD" ]; then
> +if [ -z "$NOUPLOAD" ]; then
>  	dialog --backtitle "$BGTITLE" --title "ALSA-Info script v 
> $SCRIPT_VERSION" --yesno "\nThis script will collect information about your 
> ALSA installation and sound related hardware, to help diagnose your 
> problem\n\nBy default, this script will AUTOMATICALLY UPLOAD your information 
> to a pastebin site.\n\nSee $0 --help for options\n\nDo you want to run this 
> script?" 0 0
>  else
>  	dialog --backtitle "$BGTITLE" --title "ALSA-Info script v 
> $SCRIPT_VERSION" --yesno "\nThis script will collect information about your 
> ALSA installation and sound related hardware, to help diagnose your 
> problem\n\nSee $0 --help for options\n\nDo you want to run this script?" 0 0
> 
> 
> Thanks,
> Travis Place
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
