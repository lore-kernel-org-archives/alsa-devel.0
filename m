From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [lack of] dynamic detection/loading of modules
Date: 27 Feb 2003 12:35:00 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046378100.22559.23.camel@cmn37.Stanford.EDU>
References: <E18oElA-0005cD-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18oElA-0005cD-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Ivica Bukvic <ico@fuse.net>, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >lists about this and to do it cleanly it would be nice to have available
> >in /proc/asound the list of modules currently loaded. That is not
> >available today (I think Takashi said he might add that)."
> 
> cat /proc/modules | grep '^snd'

This relies in an (AFAIK) unenforceable convention (all modules that
start with "snd" are alsa modules). I think the information has to come
from within the alsa driver, or from some place that actually knows that
the module _is_ an alsa module. IMHO a name is not enough. 

-- Fernando




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
