From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: softvol  plugin
Date: Sat, 19 Feb 2005 22:08:46 +0100
Message-ID: <4217AADE.6010005@gmx.de>
References: <92C0412E07F63549B2A2F2345D3DB515F7D63F@cm-msg-02.cmedia.com.tw>	 <4216EE28.6040702@gmx.de> <1108799809.9005.3.camel@krustophenia.net>	 <42178828.2020002@gmx.de> <1108840309.10705.6.camel@krustophenia.net>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108840309.10705.6.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Sat, 2005-02-19 at 19:40 +0100, thomas schorpp wrote:
> 

> 
> 
> I think you missed my point.  There is a PCM slider for cards with no
> hardware volume control.  It's provided by the softvol plugin, which is
> part of alsa-lib, which lives in userspace.  Since it works fine in
> userspace, there's no reason for it to be in the kernel, other than to
> provide software volume control for OSS apps using the in-kernel OSS
> emulation.  The OSS API is deprecated, so there's no way the kernel
> developers will bloat the kernel by letting in software volume control
> for the sole purpose of supporting a deprecated API.

yes, agree.

ill check my installation.

schorpp@tom1:~$ dpkg -l alsa* |grep 1.0.8
ii  alsa-base      1.0.8-5        ALSA driver configuration files
ii  alsa-oss       1.0.8-1        ALSA wrapper for OSS applications
ii  alsa-utils     1.0.8-2        ALSA utilities
schorpp@tom1:~$
schorpp@tom1:~$ dpkg -l libasound* |grep 1.0.8
ii  libasound2     1.0.8-2        ALSA library
ii  libasound2-dev 1.0.8-2        ALSA library development files
ii  libasound2-doc 1.0.8-2        ALSA library developer documentation
ii  libasound2-plu 1.0.8-2        ALSA library plugins
schorpp@tom1:~$

sorry, i cant get a pcm master slider on any mixer.

> 
> Also keep in mind we are talking about the cheapest of the cheap
> hardware.  They are probably saving a penny or two per board, by wasting
> everyone's CPU cycles to do volume control in software.  The actual fix
> is to get a real sound card.

fine then.

> 
> Lee
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
