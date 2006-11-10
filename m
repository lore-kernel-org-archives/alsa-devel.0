From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Rawmidi device naming
Date: Fri, 10 Nov 2006 09:25:28 +0100
Message-ID: <1163147128.14459.275481443@webmail.messagingengine.com>
References: <1158946723.1097.90.camel@mindpipe>
	<1158948259.1036.271601876@webmail.messagingengine.com>
	<1163104597.16030.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1163104597.16030.6.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Fri, 2006-09-22 at 20:04 +0200, Clemens Ladisch wrote:
> > The client name comes from the card's shortname.
> 
> Sorry, but you are wrong - the client name does not come from the card's
> shortname.  The client gets the name of the first port registered.

Then I guess your kernel does not yet contain this changeset
<http://hg.alsa-project.org/alsa-kernel?cs=54aa2cdfe8d7> from ALSA 1.0.12.


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
