From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Wall Clock Counter
Date: Fri, 15 Sep 2006 18:46:34 +0200
Message-ID: <1158338794.6226.271032492@webmail.messagingengine.com>
References: <705aa3f00609150906r56f1bda5nefea0fbe3251dee7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <705aa3f00609150906r56f1bda5nefea0fbe3251dee7@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: shane michael matthews <shane.michael.matthews@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

shane michael matthews wrote:
> What I want to do is read the value stored in the wall clock counter on my
> sound card.  Searching through the alsa documentation and source it appears
> that snd_timer_read is the function I want to use.

ALSA timers are interval timers.  There is no device-independent API
for getting a wall clock counter value.

If you want to synchronize to a PCM device, you can use the hw_ptr value
as a wall clock counter.


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
