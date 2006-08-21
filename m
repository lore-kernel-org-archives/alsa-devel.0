From: Haakon Riiser <haakon.riiser@fys.uio.no>
Subject: Re: SysEx overflow when using the MIDI sequencer event
	interface
Date: Mon, 21 Aug 2006 11:34:14 +0200
Message-ID: <20060821093414.GA25757@bigboss.venod.com>
References: <20060819102421.GA1991@fox> <20060819200154.GA1054@fox>
	<20060820111938.GA1577@fox>
	<1156149858.23278.269020232@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1156149858.23278.269020232@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

[Clemens Ladisch]

> The sequencer interface is designed to send small messages
> asynchronously in real time (or at specified scheduled times).  Not
> doing any bandwidth management is part of the current design.
> 
> The rawmidi interface is better suited to send big SysEx messages.

Right, but is it possible to use rawmidi while the sequencer is opened?
I tried, but open() blocks until I close the sequencer.

-- 
 Haakon

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
