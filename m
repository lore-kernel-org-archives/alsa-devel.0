From: Shingo HORISAWA <tora2329@yahoo.co.jp>
Subject: Re: Problems with Realtek HD Audio
Date: Fri, 9 Feb 2007 15:25:12 +0900 (JST)
Message-ID: <20070209062512.70417.qmail@web3213.mail.kcd.yahoo.co.jp>
References: <s5hbqk4psnj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hbqk4psnj.wl%tiwai@suse.de>
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

Hi, Takashi.


> Well, the codec is usually recognized, but it
> doesn't mean that your
> hardware is really supported.  Check out the kernel
> log and see
> whether the driver tells about "unknown model...". 
> Also try to build
> drivers with --with-debug=detect option for making
> it more verbose.

I tried this option, but I couldn't find such messages (or
any messages) in /var/log/messages.

> >    kernel: hda-intel: Invalid position buffer,
> using LPIB
> > read method instead.
> 
> Does it appear after arecord or even after aplay?

No, it only appeared at the start of arecord.

> I recommend you to try various model options for
> ALC262.  There are
> plenty of varients, but not specific for Toshiba, so
> far.  But it's
> still worth to try.

I also tried all model options in ALSA-configuration.txt,
but it was the same result.


But, I noticed three facts:

  a) This problem occurs when applications are started. 
     But, after restart ALSA, it doesn't occur 
     when I start the "same" application again.
     (When I start another application, it occurs...)

  b) When I run "arecord" after some applications are
started, 
     this problem doesn't occur.
     (When I started "new" application while I'm running
"arecord", it occurs.)

  c) On CD-boot linux, such as KNOPPIX, 
     this problem doesn't occur at all.


I doubted that this is a problem around memory.
So, to make sure that, I have tried to clean a page cache
after this problem occured as follows:

  (1) run "arecord"
  (2) start wireshark(ethereal)  => arecord stopped
  (3) restart ALSA
  (4) run "arecord" again => OK
  (5) start wireshark => arecord is still running
  (6) stop wireshark
  (7) clean a page cache as follows:
         # systcl -w vm.drop_caches=3 
        => arecord is still running
  (8) start wireshark again => arecord stopped!


Does this information help to resolve this problem?


Best regards.

===
Shingo


--------------------------------------
Start Yahoo! Auction now! Check out the cool campaign
http://pr.mail.yahoo.co.jp/auction/


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
