From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Rawmidi device naming
Date: Fri, 10 Nov 2006 20:08:54 +0100
Message-ID: <1163185734.9785.275524218@webmail.messagingengine.com>
References: <1158946723.1097.90.camel@mindpipe>
	<1158948259.1036.271601876@webmail.messagingengine.com>
	<1163104597.16030.6.camel@mindpipe>
	<1163147128.14459.275481443@webmail.messagingengine.com>
	<1163181255.21285.34.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1163181255.21285.34.camel@mindpipe>
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
> On Fri, 2006-11-10 at 09:25 +0100, Clemens Ladisch wrote:
> > Then I guess your kernel does not yet contain this changeset
> > <http://hg.alsa-project.org/alsa-kernel?cs=54aa2cdfe8d7> from ALSA 1.0.12.
> 
> I'm working with ALSA 1.0.9b.  The code seems to have completely
> changed.  Can you suggest how I might fix this in my ALSA version?

In theory, you should be able to use rmidi->card->shortname instead of
rmidi->name in the set_client_name function.


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
