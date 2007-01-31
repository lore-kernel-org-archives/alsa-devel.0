From: Fons Adriaensen <fons@kokkinizita.net>
Subject: Re: ice1712 IPGA and ADC controls
Date: Wed, 31 Jan 2007 22:48:58 +0100
Message-ID: <20070131214858.GB7164@linux-2.site>
References: <200701262325.33755.gineera@aspect135.co.uk>
	<20070127123807.GA2662@localhost.localdomain>
	<200701282259.52583.gineera@aspect135.co.uk>
	<s5h7iv61116.wl%tiwai@suse.de>
	<20070129191551.GA2673@localhost.localdomain>
	<loom.20070130T064723-509@post.gmane.org>
	<s5hac00ojg0.wl%tiwai@suse.de>
	<loom.20070131T000127-424@post.gmane.org>
	<s5h8xfjvay6.wl%tiwai@suse.de> <s5h1wlbv62t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1wlbv62t.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Tim <terminator356@users.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 31, 2007 at 11:33:30AM +0100, Takashi Iwai wrote:
> 
>     +---+ +18dB
>     |   |
>     |   | analog
>     |   | gain
>     |   |
>     +---+ 0dB
>     |   |
>     |   | digital
>     |   | att 
>     |[=]--[ -30dB ]
>     |   |
>     +---+ -64dB

This seems a good solution. BTW, is this issue somehow related to
the bug I experienced first with SuSE 8.1 and which is AFAIK still
there in 10.0, resulting in the gain controls in envy24control with
the Terratec EWS88MT not working properly ? 

-- 
FA

Lascia la spina, cogli la rosa.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
