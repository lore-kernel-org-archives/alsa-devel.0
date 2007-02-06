From: Gerald Grabner <gerald.grabner@gmx.net>
Subject: Re: seq: maximum number of events w.r.t. ordering in
 queue
Date: Tue, 06 Feb 2007 21:40:43 +0100
Message-ID: <45C8E7CB.9000700@gmx.net>
References: <45C62E51.3050608@gmx.net>
	<1170763163.22570.1173152487@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1170763163.22570.1173152487@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Gerald Grabner wrote:
>>   // buffer size for all events
>>   unsigned int b = (n+1)*sizeof(snd_seq_event_t);
>>
>>   // set output buffer and client pool size
>>   if ( snd_seq_set_output_buffer_size(seq,b) )
>>     printf("Error setting output_buffer_size\n");
>>   if ( snd_seq_set_client_pool_output(seq,b) )
>>     printf("Error setting client_pool_output\n");
>
> What the documentation failed to tell you is that the parameter to
> snd_seq_set_client_pool_output() is measured in events, not in
> bytes, and that a value that is too big is silently ignored.

Indeed, that did the trick!


Besides the fact that ALSA is a great piece of software, the
documentation is a bit poor in some places - like this one. Since I am
not a developer of the ALSA lib, I can only make suggestions, e.g.
adding the following doxygen snippet at line 264/265 in seqmid.c
(alsa-lib-1.0.14rc2) for snd_seq_set_client_pool_output:

 * The pool size is measured in events, not in bytes. The maximum size
 * is 2000, values greater than that are ignored.

Thx & Regards,
Gerald

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
