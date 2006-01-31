From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-devel] Lost with ALSA in the beginning
Date: Tue, 31 Jan 2006 17:29:38 +0100
Message-ID: <20060131162938.GB15911@turing.informatik.uni-halle.de>
References: <drnik8$eo8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-reply-to: <drnik8$eo8$1@sea.gmane.org>
Content-disposition: inline
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Eugen Bigz <zhenja@zlo.ee>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Eugen Bigz wrote:
> The problem is following: I do not understand how to configure ALSA 
> properly. [...] All I can get, when using aplay is: Unknown PCM
> default.

The config files for the ALSA library seem to be missing.

> Please point me to the place in the documentation, which tells how to 
> configure ALSA manually.

There is no such place (or documentation).

Have a look at the Makefile.am files below alsa-lib/src/conf to see
where the config files are to be installed.


HTH
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
