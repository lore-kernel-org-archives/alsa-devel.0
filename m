From: Vince <fuzzy77@free.fr>
Subject: Re: [OOPS] Alsa 0.9.4 / kernel 2.6.0-test1-mm1
Date: Mon, 21 Jul 2003 16:11:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F1BF490.5070500@free.fr>
References: <Pine.LNX.4.44.0307211436010.3903-100000@pnote.perex-int.cz>	<3F1BEB61.9040004@free.fr> <s5h8yqsj86y.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yqsj86y.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 21 Jul 2003 15:32:17 +0200,
> Vince wrote:
> 
>>Sorry, I still get the oops with the patch...
> 
> 
> perhaps you built the modules without frame pointer?
> 
> 

Indeed:

diablo:/usr/src/linux-2.6.0test1# grep FRAME .config
# CONFIG_FRAME_POINTER is not set

Should I make a build with framepointers ?




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
