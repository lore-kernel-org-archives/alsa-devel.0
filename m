From: Lars Heineken <Lars.Heineken@gmx.de>
Subject: Re: fedora core alsaconf patch
Date: Sat, 22 Nov 2003 11:18:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBF3808.1060104@gmx.de>
References: <1069458051.11875.5.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1069458051.11875.5.camel@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I think we need a similar extension to support Mandrake, after 
installation from the sources all modules in modules.conf where gone, 
except the ones from alsa.. :-)

>Included is a patch that fixes alsaconf to work correctly under fedora
>core 1. Otherwise alsaconf happily creates a modules.conf file that only
>contains the alsa configuration and nothing else (a path in the if's
>that does not create a $TMP file before the alsa configuration process
>starts). 
>



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
