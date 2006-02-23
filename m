From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Configure error for alsa-utils
Date: Thu, 23 Feb 2006 07:57:14 +0000
Message-ID: <1140681434.9220.2.camel@localhost.localdomain>
References: <715d90900602221919g512f71edy5985d487c1fde62e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 3D1821C5
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2006 08:57:17 +0100 (MET)
In-Reply-To: <715d90900602221919g512f71edy5985d487c1fde62e@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: boku <boku0712@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-02-23 at 11:19 +0800, boku wrote:
> Dear all,
>     I met an error while configuring alsa-utils. It shows configure:
> error: No linkable libasound was found.
> Then I checked the config.log, there's a message shown 
> "configure:5508: error: No linkable libasound was found." 
> Before configuring alsa-utils, i've compiled alsa-lib with
> cross-compiling method. 
> Could anyone tell me how to pass the alsa-utils installation? Thanks a
> lot!~
>  
Did you specify where your alsalib was when building? Otherwise it will
try to use the alsalib on the build machine.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
