From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Alsa and hdspmixer segfault
Date: Fri, 01 Oct 2004 13:49:18 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096652957.24868.35.camel@krustophenia.net>
References: <200410011526.i91FQbeq001324@sanctuary.aproximation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200410011526.i91FQbeq001324@sanctuary.aproximation.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: thewade <pdman@aproximation.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-10-01 at 11:26, thewade wrote:
> p.s. I have 2.6.9-rc3 kernel. I get errors when I try to apply the
> latest low latency patch:
> http://people.redhat.com/mingo/voluntary-preempt/voluntary-preempt-full-2.6.9-rc2-mm4-S7
> Any tips? (hdspmixer is more important than this)

Well, it's obvious why it doesn't work.  You say you have 2.6.9-rc3, but
the S7 patch is against 2.6.9-rc2-mm4, as the name clearly indicates. 
You need to get that kernel to apply S7.

Lee




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
