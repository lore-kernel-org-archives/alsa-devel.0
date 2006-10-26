From: Matt Porter <mporter@embeddedalley.com>
Subject: Re: [PATCH] hda: add sigmatel dig mic support and
	refactor 9227
Date: Thu, 26 Oct 2006 10:36:24 -0400
Message-ID: <20061026143624.GB1507@matthew-porters-computer.local>
References: <20061025202110.GA351@matthew-porters-computer.local>
	<s5hejsv7321.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from oh.embeddedalley.com (cpe-088197.static.wadsnet.net
	[65.114.88.197])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BE0E8240
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Oct 2006 16:36:28 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hejsv7321.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 26, 2006 at 01:02:30PM +0200, Takashi Iwai wrote:
> You cannot remove XXX_MODELS.
> The size of *_brd_tbl[] must be defined as the max number of models.
> Otherwise you might access to outside the array since the driver
> checks the value of *_brd_tbl[model].

Ahh, yes. Whoops. 

> Also, some lines you added exceed 80-columns rule.  I know there are
> still more lines over 80 chars,  but let's follow the standard coding
> style at least for new codes.

Ok, will do. I'm sending a separate patch which just adds 9205
dmic support and we can address the 927x/9227 issue separately.

-Matt

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
