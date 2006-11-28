From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: different between "default" and "hw:0,0"?
Date: Tue, 28 Nov 2006 12:11:00 -0500
Message-ID: <1164733862.1701.10.camel@mindpipe>
References: <BAY127-W126B9E39CB4FA3B9ED5A58C9E50@phx.gbl>
	<1164730102.29695.57.camel@mindpipe>  <456C6A83.4090709@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <456C6A83.4090709@schinagl.nl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Oliver Schinagl <oliver@schinagl.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-11-28 at 17:57 +0100, Oliver Schinagl wrote:
> This would only apply to the PCM/data side of Alsa right? Not the 
> control/mixer part, as from what I gatherd from the alsa wiki, 'default' 
> is just a name for card 0.
> 
> Other than that, how can I still use software mixing, but force an 
> application to use hw1 instead of hw0?

No, default just refers to the default PCM, not the default card.  The
full device name is default:X where X is the card number.  The card
number just defaults to 0 if you don't specify it.

To use the default PCM of card 1, your app should use "default:1".

Lee



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
