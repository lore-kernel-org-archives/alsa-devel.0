From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: prealloc/buffer time limit?
Date: Tue, 14 Feb 2006 09:13:02 +0100
Message-ID: <20060214081302.GA8685@turing.informatik.uni-halle.de>
References: <43ED016D.9030301@request.com>
 <20060213080655.GA8896@ifiu25.informatik.uni-halle.de>
 <43F0A0AB.3050102@request.com>
 <20060213155244.GF9177@ifiu25.informatik.uni-halle.de>
 <43F0D934.8090809@request.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <43F0D934.8090809@request.com>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ron Cococcia <ron.cococcia@request.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ron Cococcia wrote:
> Clemens Ladisch wrote:
> >Change appropriate fields in snd_intel8x0_stream, too.
> 
> That's exactly what I was looking for :)  As James mentioned, it might 
> not work correctly, but I'm experimenting to see what I can make it do.

This hardware has not size limit for its DMA buffer.


Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
