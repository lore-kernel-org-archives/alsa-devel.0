From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: sound connector detection
Date: Sun, 2 Jul 2006 22:48:35 -0400
Message-ID: <200607022248.36459.dtor@insightbb.com>
References: <1151671786.13412.6.camel@localhost>
	<200607011609.59426.dtor@insightbb.com>
	<1151832510.5536.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0189343689=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1151832510.5536.32.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Johannes Berg <johannes@sipsolutions.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============0189343689==
Content-Type: multipart/alternative; boundary="Boundary-00=_EWIqEeBHqzA5FH+"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_EWIqEeBHqzA5FH+
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sunday 02 July 2006 05:28, Richard Purdie wrote:
> One thing the input system does well is pass simple switch events to
> userspace though its event devices. Not using the input system for
> switch like events like these is going to result in code duplication.
> 

I think that hotplug/uevent like mechanism would be better suited here.
You want to monitor changes in system state and you do not really want
to monitor myriad of devices but just latch onto one data feed and get
all the data from it (unlike input devices where you might want to
separate data coming from different devices). The following "event"
might be a good starting point:

	struct system_change_event {
		struct timeval time;	/* look for 32/64 bit issues */
		__u16 type;
		__u16 code;
		__s32 value;
		char object_path[224];
};

Maybe we should start looking into connector or a pure netlink implementation.

-- 
Dmitry
--Boundary-00=_EWIqEeBHqzA5FH+
Content-Type: text/html;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:10pt;font-family:Monospace">
<p>On Sunday 02 July 2006 05:28, Richard Purdie wrote:</p>
<p>&gt; One thing the input system does well is pass simple switch events to</p>
<p>&gt; userspace though its event devices. Not using the input system for</p>
<p>&gt; switch like events like these is going to result in code duplication.</p>
<p>&gt; </p>
<p></p>
<p>I think that hotplug/uevent like mechanism would be better suited here.</p>
<p>You want to monitor changes in system state and you do not really want</p>
<p>to monitor myriad of devices but just latch onto one data feed and get</p>
<p>all the data from it (unlike input devices where you might want to</p>
<p>separate data coming from different devices). The following &quot;event&quot;</p>
<p>might be a good starting point:</p>
<p></p>
<p>	struct system_change_event {</p>
<p>		struct timeval time;	/* look for 32/64 bit issues */</p>
<p>		__u16 type;</p>
<p>		__u16 code;</p>
<p>		__s32 value;</p>
<p>		char object_path[224];</p>
<p>};</p>
<p></p>
<p>Maybe we should start looking into connector or a pure netlink implementation.</p>
<p></p>
<p>-- </p>
<p>Dmitry</p>
</body></html>
--Boundary-00=_EWIqEeBHqzA5FH+--


--===============0189343689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0189343689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0189343689==--
