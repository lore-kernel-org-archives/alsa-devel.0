From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: complied error
Date: Tue, 11 Oct 2005 13:48:59 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0510111347450.11223-100000@studcom.urz.uni-halle.de>
References: <20051008012707.76091.qmail@web8608.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051008012707.76091.qmail@web8608.mail.in.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jack christe <jack_alyz@yahoo.co.in>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

jack christe wrote:
> whn i m running ./configure --with-cards=azx
>               gives
> checking for which soundcards to compile driver for...
> configure: error: Unsupported soundcard azx

See "./configure --help" for a list of drivers.

> /root/alsa-driver-1.0.8rc1/acore/init.c:526: error:
> dereferencing pointer to incomplete type  "

1.0.8rc1 is an old development version.  Use 1.0.9b or 1.0.10rc1.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
