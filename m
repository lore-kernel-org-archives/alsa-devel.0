From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Re: pause - resume playback
Date: Tue, 18 May 2004 15:09:33 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1084907373.2924.14.camel@localhost>
References: <40AA6304.4090601@gmx.at>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40AA6304.4090601@gmx.at>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Cc: Openvortex <openvortex-dev@nongnu.org>, Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Wilfied,

Thanks for the patch. I'm applying it know, and submitting a new patch:

http://galadriel.mat.utfsm.cl/~mjander/aureal/alsa/aureal-2.6.6.diff.gz

Its the same as 2.6.5 plus your resume fix.

Best Regards

Manuel

On Tue, 2004-05-18 at 21:24 +0200, Wilfried Weissmann wrote:
> hi,
> 
> i still need to resetup the dma registers to get the right samples after 
> resuming audio playback. i thought that this has something to do with 
> the samples crossing the 4k alignment boarders, but in my tests all 
> samples were properly aligned.
> the attached patch applies aganist kernel 2.6.6 with the latest aureal 
> fastplay/slowrecord patch applied.
> 
> bye,
> wilfried




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
