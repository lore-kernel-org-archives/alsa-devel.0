From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Experimental USB audio support
Date: Fri, 31 May 2002 20:09:31 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CF759EB.981BEADE@boosthardware.com>
References: <s5hy9e2hk02.wl@alsa2.suse.de>
		<3CF5B58B.59E5A233@boosthardware.com>
		<s5hwutkhhhj.wl@alsa2.suse.de>
		<3CF74113.46D53687@boosthardware.com>
		<s5hofewhd1u.wl@alsa2.suse.de> <s5hk7pkh9pi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> now a new version is cvs.  it dumps the descriptor at
> /proc/asound/cardX/descriptor.  if the cvs servers is not sync'ed,
> please let me know.  i'll send you a patch.
> 

Will try now just recompiling the kernel. Can't get 2.4.19-pre9-ac3 to
work though :(

> btw, you might try another hub module.  for uhci there are two
> modules, uhci and usb-uhci.  i'm not sure which one is better,
> though.
> 

They are in the process of deciding at the moment over in usb land. We
have until the end of June to make ourselves heard. Currently there are
4 different versions in circulation and the head of development wants to
cut that down to one. So we should do some testing with regards to
latency before they make the final decision. I'm assuming that the URB
code is relevant to Audio latency.



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
=======================================================================

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
