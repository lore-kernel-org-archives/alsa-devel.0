From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Direct Delivery of NoteOn events
Date: Wed, 25 Oct 2006 10:25:38 +0200
Message-ID: <1161764738.26435.274165147@webmail.messagingengine.com>
References: <46195E17-B17F-40C2-A77A-7CABB4B9E742@comcast.net>
	<1161676827.21456.274067836@webmail.messagingengine.com>
	<99C795AE-FCD2-4E95-ABE0-145AA81EFB58@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <99C795AE-FCD2-4E95-ABE0-145AA81EFB58@comcast.net>
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
> ...
> Note, that above I have tried both using subscriptions and directly  
> sending to the destination port. Neither works correctly when i am  
> sending the alsa event to another process, but snd_seq_ev_set_dest()  
> does work when sending to another port in the SAME process/client.  I  
> verified this using another thread listening on the 2nd port. Pretty  
> odd.  Finally, I output the event and drain the output...
> 
>  >>>snd_seq_event_output( our_parcel->seq, &event );
> 	snd_seq_drain_output( our_parcel->seq );

What is your program doing after this call?  If you don't wait until the
event has been delivered, the queue with the events still in it will be
destroyed.


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
