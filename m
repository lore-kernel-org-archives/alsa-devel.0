From: Nick Fortune <nick@onepointsystems.com>
Subject: Re: Test Patch6 for Conexant HD Audio.
Date: Thu, 26 Oct 2006 19:45:05 +0100
Message-ID: <20061026184505.GA16391@creeper>
References: <20061026173031.GA899@creeper> <1161886425.18211.109.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1161886425.18211.109.camel@razman>
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

I get:

> make[5]: *** No rule to make target `/var/tmp/portage/media-sound/alsa-driver-1.0.13/work/alsa-driver-1.0.13/pci/hda/patch_conexant.o', needed by `/var/tmp/portage/media-sound/alsa-driver-1.0.13/work/alsa-driver-1.0.13/pci/hda/snd-hda-intel

I had a quick look at things and couldn't see anything obvious, but
I'm not realy familiar with the structure of the alsa project.

Could the file be in the wrong place?

On 11:13 Thu 26 Oct     , Tobin Davis wrote:
> I just looked over the patch and found that it was incomplete.  In
> reviewing my commandline history, I discovered that test6 didn't get the
> alsa-kernel base patch (it only had the patch_conexant.c code), required
> for building this code.
> 
> Here is the real test6 patch.  It should work against both the alsa HG
> tip and the alsa-driver-1.0.13.tar.bz2 download.  Earlier versions of
> alsa have not been compile tested.
> 
> Tobin

-- 
Don't let THEM immanentize the Eschaton!

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
