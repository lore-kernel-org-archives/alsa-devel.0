From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: seq: maximum number of events w.r.t. ordering in
	queue
Date: Tue, 06 Feb 2007 12:59:23 +0100
Message-ID: <1170763163.22570.1173152487@webmail.messagingengine.com>
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
>   // buffer size for all events
>   unsigned int b = (n+1)*sizeof(snd_seq_event_t);
> 
>   // set output buffer and client pool size
>   if ( snd_seq_set_output_buffer_size(seq,b) )
>     printf("Error setting output_buffer_size\n");
>   if ( snd_seq_set_client_pool_output(seq,b) )
>     printf("Error setting client_pool_output\n");

What the documentation failed to tell you is that the parameter to
snd_seq_set_client_pool_output() is measured in events, not in bytes,
and that a value that is too big is silently ignored.


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
