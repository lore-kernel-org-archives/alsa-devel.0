From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Wall Clock Counter
Date: Mon, 18 Sep 2006 12:28:14 +0200
Message-ID: <1158575294.27553.271179033@webmail.messagingengine.com>
References: <705aa3f00609150906r56f1bda5nefea0fbe3251dee7@mail.gmail.com>   
	<1158337693.18762.16.camel@mindpipe>   
	<705aa3f00609151034j5a408668lf34cb095dbae582d@mail.gmail.com>   
	<705aa3f00609151038r7b800cfet7135c09a3c236c1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <705aa3f00609151038r7b800cfet7135c09a3c236c1c@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

shane michael matthews wrote:
> > > > What I want to do is read the value stored in the wall clock counter
> > > > on my sound card.  Searching through the alsa documentation and source
> > > > it appears that snd_timer_read is the function I want to use.
> 
> The device is:
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
> Definition Audio Controller (rev 01)

ALSA timers require that the device can issue interrupts after some
specified interval.  Your HDA controller cannot.

What do you want to use the wall clock counter for?


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
