From: paul santa clara <kesserich1@comcast.net>
Subject: Re: Direct Delivery of NoteOn events
Date: Thu, 26 Oct 2006 15:26:01 -0400
Message-ID: <D1D41433-05A1-47E1-8178-BDC4D03C63AB@comcast.net>
References: <46195E17-B17F-40C2-A77A-7CABB4B9E742@comcast.net>
	<1161676827.21456.274067836@webmail.messagingengine.com>
	<99C795AE-FCD2-4E95-ABE0-145AA81EFB58@comcast.net>
	<1161764738.26435.274165147@webmail.messagingengine.com>
	<68553F7D-DBC4-4D0E-A5A4-071B94359269@comcast.net>
	<1161847427.29328.274258312@webmail.messagingengine.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1161847427.29328.274258312@webmail.messagingengine.com>
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

Dearest Clemens,
	Thank you so much for your help.  After I checked the results of  
each and every alsa function + macro, i discovered that the source  
field of the event was not being set properly.  It turns out that  
snd_seq_create_simple_port was returning 0 for both calls.  As a work  
around, i simply scanned for the ports and used that id in  
snd_seq_port_subscribe_set_source.  I assume this is a bug?  Just out  
of curiosity, i attempted to switch over to snd_seq_create_port but  
gcc was unable to determine the size of the snd_seq_port_info_t  
struct.  The headers reveal it to be a typedef of _snd_seq_port_info  
but the trail ended there.

best regards and thanks again. :)
-paul santa clara



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
