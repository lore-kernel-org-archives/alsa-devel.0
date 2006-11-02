From: "Konstantin Shaposhnikov" <k.shaposhnikov@gmail.com>
Subject: Re: Conexant test code
Date: Thu, 2 Nov 2006 17:59:57 +0000
Message-ID: <b12092cb0611020959q325aa511h65387b68c03bfdb4@mail.gmail.com>
References: <1162339150.18211.239.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1162339150.18211.239.camel@razman>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

This is results of testing conexant patch 7.

Information about test notebook (HP Pavilion dv2000)

uname -a
  Linux zeon 2.6.18-suspend2 #5 SMP Thu Oct 19 11:12:15 BST 2006 i686 Genuine
  Intel(R) CPU           T2300  @ 1.66GHz GNU/Linux

"lspci -s 0:1b -vn | grep Subsystem
  Subsystem: 103c:30b2

Alsa version: 1.0.13

Internal microphone is working.

Probably it was my fault during testing of test patch 6 that microphone didn't
work. It is necessary to toggle capture facility on both internal
microphone and
Capture control (using Space key in alsamixer).

I guess that cxt5047_hp_automic should be called when user plug in/plug out
external microphone and unmute internal microphone automatically. Unfortunately
I am not able to test it because I haven't external mic.


Internal speakers still not muted when headphones are plugged.

If you give me some suggestions how to experiment with my notebook in order to
find right commands to mute internal speakers I will be able to help with
fixing this problem. As I already wrote ctx5047_hp_automute is called
correctly, but code of this method doesn't mute internal speakers.


Regards,
Konstantin

On 10/31/06, Tobin Davis <tdavis@dsl-only.net> wrote:
> Here's test patch 7.  This should (hopefully) re-enable Mic recording
> and mute the internal speakers when headphones are plugged in.
>
> I've combined the driver wrapper with the kernel patch for easier
> distribution and integration.
>
> For the new testers in the group, here's the instructions:
>
> wget ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.13.tar.bz2
> tar -jxf alsa-driver-1.0.13.tar.bz2
> cd alsa-driver-1.0.13
> ./configure --with-debug=full --with-cards=hda-intel
> patch -p1 <conexant-test7.patch
> make ; make install
> dmesg -c
>
> Stop all audio applications and remove all audio drivers (lsmod |fgrep
> snd).  Reload the new driver with "modprobe snd-hda-intel" and test it
> out.  Use alsamixer to report any mixer issues (easier to debug than
> kmix/gmix, whatever-gui-mixer).  If nothing works, or one function
> doesn't work, try reloading the driver with "model=test" as a parameter.
> This should enable everything.
>
> Send me your test results.  Please include the system make/model, and
> the subsystem line from "lspci -s 0:1b -vn" (Ex: Subsystem: 103c:30b2).
> I need this for tracking what works on what systems.
>
> Thanks,
> --
> Tobin Davis <tdavis@dsl-only.net>
>
>
>


-- 
http://step-inside.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
