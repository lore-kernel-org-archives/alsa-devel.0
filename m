From: Vince <fuzzy77@free.fr>
Subject: Re: [OOPS] Alsa 0.9.4 / kernel 2.6.0-test1-mm1
Date: Mon, 21 Jul 2003 16:14:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F1BF563.4060507@free.fr>
References: <Pine.LNX.4.44.0307211547570.26922-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307211547570.26922-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 21 Jul 2003, Vince wrote:
> 
> 
>>Sorry, I still get the oops with the patch...
> 
> 
> Please, change '(src_rate * 105) / 105;' expression from the patch
> to '(src_rate * 105) / 100;'...
> 

I already did (see my last mail)... and still the oops. :-(



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
