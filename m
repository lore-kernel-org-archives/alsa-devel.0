From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: hdsp9652+alsamixer -> kernel panic
Date: Sat, 31 May 2003 14:15:50 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305311412450.856-100000@ecabase.localdomain>
References: <E19LQBJ-00080C-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19LQBJ-00080C-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 29 May 2003, Paul Davis wrote:

>>> ah. are you running on an SMP system with current ALSA CVS? if so, its
>>> broken within the "core" of ALSA. you will need to back up to April
>>Hmm, anyway to easily and reliably reproduce the bug?
> run jack? :))

Well, I've done a lot of testing during the last few days (including 
running jack :)), sometimes with both soundcards running at the same time, 
and still no oopses (system uptime now 5days). So ALSA+SMP seems to work 
fine at least on some systems.

Btw; kernel is 2.4.19 with ll-patches.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
