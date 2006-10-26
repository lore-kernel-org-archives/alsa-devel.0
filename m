From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Direct Delivery of NoteOn events
Date: Thu, 26 Oct 2006 09:23:47 +0200
Message-ID: <1161847427.29328.274258312@webmail.messagingengine.com>
References: <46195E17-B17F-40C2-A77A-7CABB4B9E742@comcast.net>
	<1161676827.21456.274067836@webmail.messagingengine.com>
	<99C795AE-FCD2-4E95-ABE0-145AA81EFB58@comcast.net>
	<1161764738.26435.274165147@webmail.messagingengine.com>
	<68553F7D-DBC4-4D0E-A5A4-071B94359269@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <68553F7D-DBC4-4D0E-A5A4-071B94359269@comcast.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: paul santa clara <kesserich1@comcast.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

paul santa clara wrote:
> On Oct 25, 2006, at 4:25 AM, Clemens Ladisch wrote:
> > What is your program doing after this call?
> 
> The function enters into an infinite while{} which bombards alsa with  
> events.

Should be OK.

> > If you don't wait until the event has been delivered, the queue
> > with the events still in it will be destroyed.
> 
> Hmmm...I'm not sure you what you mean here.

When the program exits, all resources are cleaned up.

> Is there a function i can call to block the thread until ALSA has
> delivered the events?

snd_seq_sync_output_queue(), but this doesn't seem to be your problem.

Please check whether any of the ALSA functions returns an error code.

What gets output when you play to an instance of aseqdump?


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
