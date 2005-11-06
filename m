From: John Rigg <ad@sound-man.co.uk>
Subject: Re: alsa-utils-1.0.10rc2 compile failure SOLVED
Date: Sun, 6 Nov 2005 17:57:58 +0000
Message-ID: <20051106175758.GA4982@localhost.localdomain>
References: <E1EYn1R-0001GR-2H@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E1EYn1R-0001GR-2H@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 06, 2005 at 04:05:33PM +0000, John Rigg wrote:
> I just tried compiling alsa-utils-1.0.10rc2 and it failed with the following 
> error:
> 
> make[2]: Entering directory `/home/jqr/alsa-1.0.10/alsa-utils-1.0.10rc2/alsaconf/po'
> mv: cannot stat `t-ja.gmo': No such file or directory
> make[2]: *** [ja.gmo] Error 1

Solved. Needed to install gettext.

John


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
