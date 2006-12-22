From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: meet trouble in user the ALSA?
Date: Fri, 22 Dec 2006 09:00:18 +0100
Message-ID: <1166774418.10691.281652219@webmail.messagingengine.com>
References: <001a01c72593$9c11c920$0b96a8c0@Thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <001a01c72593$9c11c920$0b96a8c0@Thomas>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "thomas.luo" <thomas.luo@ieee.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

thomas.luo wrote:
> when i use the aplay test.wav.
> the program shows:
> ALSA lib pcm.c:2143:(snd_pcm_open_noupdate) Unknown PCM default
> 
> #
> #  ALSA library configuration file
> #
> .........
> pcm.as352x {
> type plug
> slave  {
> pcm {
>     type hw
>     card 0
>     }
> #format "S16_LE"
> #channels 2
> rate "unchanged"
> }
> }

Are you using the original ALSA configuration files?
If not, did you define the "default" device?


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
