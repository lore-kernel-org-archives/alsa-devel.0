From: Jesse Chappell <jesse@essej.net>
Subject: Re: Problems with HDSP Multiface+CardBus
Date: Thu, 12 Jun 2003 14:32:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5ec5dab668378a9a0eedac678095e3bb@essej.net>
References: <1055442508.416.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1055442508.416.3.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

 > On Thu, 2003-06-12 at 14:03, d wrote:
 > > that's interresting. 32767 has always been fine for me (on headphones 
 > > just like on line-outs), and all descriptions about the mixer-matrix say 
 > > 32767 means 0db. even sinewaves with 0db are loud but not distorted on 
 > > my headphones...
 > 
 > technically, it's unity gain at 32768 and +6db at 65535.
 
Different headphones have different sensitivities, and line level
can get pretty hot electrically.  But I was surprised at how far down
I had to set it though.  I wonder if I was getting the signal
from channels 1 & 2 through several paths summing on each other.
It is a bit confusing.

David S (or Thomas C), what are the chances the work you guys
have done (independently) on a UI hdsp mixer could be released?  I think 
I'll be needing some easier control.  I'll be tempted to write my own if
nothing shows up to work with soon ;)

jlc


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
