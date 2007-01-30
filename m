From: Tim <terminator356@users.sourceforge.net>
Subject: Re: ice1712 IPGA and ADC controls
Date: Tue, 30 Jan 2007 23:01:45 +0000 (UTC)
Message-ID: <loom.20070131T000127-424@post.gmane.org>
References: <loom.20070120T001557-202@post.gmane.org>
	<200701262325.33755.gineera@aspect135.co.uk>
	<20070127123807.GA2662@localhost.localdomain>
	<200701282259.52583.gineera@aspect135.co.uk>
	<s5h7iv61116.wl%tiwai@suse.de>
	<20070129191551.GA2673@localhost.localdomain>
	<loom.20070130T064723-509@post.gmane.org>
	<s5hac00ojg0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

Takashi Iwai <tiwai <at> suse.de> writes:
> A question from usability viewpoint is what is the good way to handle
> two linked volumes.  For example,
> 
> 1) two volume bars can be changed at any time.  If one of them is
>    changed, another is automatically set (jumps) to zero.
> 2) when one volume is set to non-zero, another is visiblly disabled.
>    to zero and cannot be changed.  Once after both are set to zero,
>    both become accessible.
The answer is obvious - combine them into one control! He he...



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
