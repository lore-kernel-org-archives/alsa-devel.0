From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: hdsp vs 16bit vs dmix
Date: Tue, 13 Jan 2004 18:24:33 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4003B951.3040808@boosthardware.com>
References: <3FFC41E9.3050501@boosthardware.com>	<s5hn08yznzf.wl@alsa2.suse.de>  <3FFD7C0E.5000505@boosthardware.com> <1073916082.17803.12.camel@lotte.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Justin Cormack wrote:
>
> 
> I think it may be something else in the hardware setup, as it works fine
> for me. Are the disks running dma? Is there some interrupt oddness? What
> kernel is it? What kind of machine? What filesystem? The fact that it
> works with JACK suggests that it is a small delay that aplay doesnt cope
> with well.
> 

Thanks. After this and Takashi's message I have ben convinced to look 
into the kernel and latency stuffs again.




-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================


  Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
