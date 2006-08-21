From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: SysEx overflow when using the MIDI sequencer event
 interface
Date: Mon, 21 Aug 2006 10:44:18 +0200
Message-ID: <1156149858.23278.269020232@webmail.messagingengine.com>
References: <20060819102421.GA1991@fox> <20060819200154.GA1054@fox>
	<20060820111938.GA1577@fox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060820111938.GA1577@fox>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Haakon Riiser <haakon.riiser@fys.uio.no>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Haakon Riiser wrote:
> Turns out that the buffer that overflows isn't a hardware buffer
> in the CM-32L -- it's a software buffer in ALSA that is fixed to
> a single page of memory (4096 bytes on x86).
> 
> This wouldn't be a problem if there were a mechanism that allowed
> incoming events to wait until there's room in the output buffer,
> or at least to fail with EAGAIN, allowing the application to retry.

The sequencer interface is designed to send small messages
asynchronously in real time (or at specified scheduled times).  Not
doing any bandwidth management is part of the current design.

The rawmidi interface is better suited to send big SysEx messages.

You said you're trying to fix DOSBox.  If it emulates a hardware MIDI
interface, it shouldn't accept MIDI data at a faster rate than a real
MIDI interface would.


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
