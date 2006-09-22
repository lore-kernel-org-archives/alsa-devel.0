From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: alsa resampler comstraints.
Date: Fri, 22 Sep 2006 18:25:24 +0200
Message-ID: <1158942324.23828.271594430@webmail.messagingengine.com>
References: <4512FBE8.6060905@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <4512FBE8.6060905@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> I want to document some of the constraints of the alsa resampler.
> Here is what I understand, and I would like someone to verify my 
> statements before I document them.
> 
> 1) The buffer and period sizes for the sound card hardware to resampler 
> are limited to the max buffer and period sizes available on the 
> hardware. As a result, the available buffer and period sizes vary 
> depending on hardware utilised.

Yes.  This is true for most of the plugins.

> 2) The resampler converts one hardware period size at a time. This 
> results in the buffer and period size constraints explained in (1) 
> arriving at the application as a direct ratio of source and destination 
> sample rate.

Yes.

> The above 2 points were true some time ago. Has anything changed?

That part of the resampler hasn't changed.


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
