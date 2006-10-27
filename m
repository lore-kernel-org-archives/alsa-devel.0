From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: adding volume to raw-midi device
Date: Fri, 27 Oct 2006 13:27:15 -0400
Message-ID: <1161970036.27225.126.camel@mindpipe>
References: <4A9D3274C93BF5409FEAB520ADD94429172B2B@exchange01-srv.pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4A9D3274C93BF5409FEAB520ADD94429172B2B@exchange01-srv.pianodisc.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Pamela K. Clift" <pclift@pianodisc.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-10-27 at 10:20 -0700, Pamela K. Clift wrote:
> I am starting this email again.  I know I had one response before but I can not get to it.  Most of our office building has burnt down to the ground.  It has taken a while to get things back up and for me to be able to get back to this.
> 
> 
> 
> 
> I am new to alsa and I am trying to write a raw-midi device driver.  When I tried to add the volume control I could not compile the file anymore.  I am hoping someone can help me and see what I am missing.  I have looked in the Writing an Alsa Driver chapter 6 and I have looked at dummy.c .  I believe I am following what they say to do but when I compile the file I get many errors including "warning: "struct snd_ctl_elem_info declared inside parameter list"   I have at the top of my file #include <sound/control.h> along with the other includes I see in the sample files.  Below is the code I added.
> 

ALSA used to typedef all of these structs.  Some people thought that
obfuscated the code so the typedefs were removed between 1.0.8 and the
current version.  Looks like you're trying to add new-style code to old
ALSA.

Should compile against 1.0.8 if you replace "struct snd_foo" with
"snd_foo_t" for all foo...

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
