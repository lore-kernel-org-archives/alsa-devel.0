From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: alsa timer slippage
Date: Wed, 17 Dec 2003 15:44:49 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312171544.49508.cannam@all-day-breakfast.com>
References: <E1AVXB7-00025m-JG@sc8-sf-list2.sourceforge.net> <200312150953.08559.cannam@all-day-breakfast.com> <Pine.LNX.4.58.0312171610420.2053@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312171610420.2053@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Pedro Lopez-Cabanillas <plcl@telefonica.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 17 Dec 2003 3:13 pm, Jaroslav Kysela wrote:
> Thanks for insigh to the problem. Can you try the attached patch?

Yes, that's a success.  Thank you.  It's still not absolutely perfect, 
but it's significantly better than the original version.  I've seen 
one slippage (of about 40ms, under load) in about twelve minutes of 
testing -- enough to know there's still a problem in there somewhere, 
but perhaps acceptable for a non-low-latency kernel and the like.


Chris



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
