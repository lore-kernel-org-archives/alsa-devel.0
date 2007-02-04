From: "S. Petty" <spetty01@gmail.com>
Subject: dsnoop slave definition fails on startup
Date: Sun, 04 Feb 2007 09:41:21 -0500
Message-ID: <eq4rah$lhp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

In the past I've used SuSE 9.x for my installations with a Delta 1010LT 
card, but the most recent install I opted for SuSE 10.1.  I'm starting 
to regret it!   I've never needed to install alsa by hand, the distro 
install has always taken care of it.

I have the 1010LT broken out into 8 separate devices.  I have this exact 
configuration running on at least a dozen other machines, and have 
gotten quite good at getting it going in a hurry.  This SuSE 10.1, 
install, though gives me the following errors when I try to start the 
device:

> ALSA lib pcm_dsnoop.c:568:(snd_pcm_dsnoop_open) unable to initialize slave
> ALSA lib pcm_direct.c:849:(snd_pcm_direct_initialize_slave) requested or auto-format is not available

My asound.conf looks like this:

> # Asound.conf START
> pcm.snoop10 {
>         type dsnoop
>         ipc_key 123
>         slave {
>                 pcm"hw:1"
>                 period_time 0
>                 period_size 1024
>                 buffer_size 4096
>                 rate 11025
>                 channels 10
>         }
>         slowptr true
> 
> }
> pcm.channel1 {
>         type plug
>         slave.pcm snoop10
>         ttable.0.0 1
> }
> pcm.channel2 {
>         type plug
>         slave.pcm snoop10
>         ttable.0.1 1
> }     ....  down to channel 8

The alsa driver version is 1.0.11rc3, and the kernel version is 
2.6.16.27-0.6

Can anyone suggest anything that I might check or change?  Is a 
definition in my asound now incompatible with the current version of 
drivers?

Thanks for any help.	


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
