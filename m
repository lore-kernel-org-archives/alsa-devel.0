From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: CMI8768 patch, softvol mixer slider
Date: Sat, 19 Feb 2005 02:56:49 -0500
Message-ID: <1108799809.9005.3.camel@krustophenia.net>
References: <92C0412E07F63549B2A2F2345D3DB515F7D63F@cm-msg-02.cmedia.com.tw>
	 <4216EE28.6040702@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4216EE28.6040702@gmx.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: t.schorpp@gmx.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-02-19 at 08:43 +0100, thomas schorpp wrote:
> hmm, if read the docs right its userspace.
> 
> how about getting it in the kernel and calling it snd_x_csoftmix ?

Why?  It works fine in userspace.  The whole point of alsa-lib is to get
things like software volume control and mixing and sample rate
conversion that don't need to be in the kernel out of the kernel.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
