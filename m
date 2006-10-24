From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Direct Delivery of NoteOn events
Date: Tue, 24 Oct 2006 10:00:27 +0200
Message-ID: <1161676827.21456.274067836@webmail.messagingengine.com>
References: <46195E17-B17F-40C2-A77A-7CABB4B9E742@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <46195E17-B17F-40C2-A77A-7CABB4B9E742@comcast.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: paul santa clara <kesserich1@comcast.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

paul santa clara wrote:
> I am having difficulty getting alsa to actually delivery a noteon
> event for me.  I am came across a list posting from 2004 which
> claimed that Queue's were necessary for NoteOn's to allow alsa to
> schedule the concomitant Noteoff at the appropriate time.

This applies only to note events, not to note on events.
Note events are split into a note on and a note off event.

> Nevertheless, i can find nothing in the documentation which
> collaborates this.

Well, there is no documentation ...

> Still, i did attempt to use to a Q but was unable  
> to produce any results.  Here is the offending code:
> ...
> snd_seq_ev_set_direct( &event );

You shouldn't use this when using a queue. (However, the following
call to snd_seq_ev_schedule_tick() will correct this.)

> int queue = snd_seq_alloc_queue( our_parcel->seq );

You must create the queue before you try to send events through it.


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
