From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hw_params from shared library problem
Date: Mon, 26 Jun 2006 17:38:06 -0400
Message-ID: <1151357886.26257.153.camel@mindpipe>
References: <44A04D7B.1070002@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44A04D7B.1070002@gmx.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Gerald Grabner <gerald.grabner@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-06-26 at 23:11 +0200, Gerald Grabner wrote:
> Hi everybody,
> 
> I'm wondering how to correctly build a shared library using alsa
> pcm. Setting the hardware parameters in a function which is part of a
> shared library produces an error, snd_pcm_hw_params gives "invalid
> argument". The example below with three primitive files (main file,
> header and function code) illustrates the problem. With a static
> library, everything works fine.
> 
> My system: gcc 3.4.6 on Gentoo with alsa 1.0.11.
> 
> Does anybody have an idea about the cause of this problem or how to 
> solve it?
> 

Cannot reproduce it here.  It works perfectly.  Toolchain bug?

Lee


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
