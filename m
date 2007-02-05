From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: seq: maximum number of events w.r.t. ordering in
	queue
Date: Mon, 05 Feb 2007 19:10:25 +0100
Message-ID: <1170699026.3324.1173012819@webmail.messagingengine.com>
References: <45C62E51.3050608@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <45C62E51.3050608@gmx.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Gerald Grabner <gerald.grabner@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Gerald Grabner wrote:
> for simultaneously playing many midi tracks each with a large number
> of events, it would be convenient to output one track after the other
> in a simple loop, without caring about the ordering of the events.
> 
> Of course, this requires an output buffer large enough to hold all
> events, otherwise events of the later are postponed every time the
> buffer is full. But one question remains, at least for me:
> Is there a maximum number of events w.r.t. the ordering in a queue?

Yes.  Your client buffer can have any size, but the events stored in the
kernel for a queue are sent from an interrupt handler and must therefore
be in locked kernel memory.  The kernel buffer is currently restricted
to 2000 events for one client.


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
