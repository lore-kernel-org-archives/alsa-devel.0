From: d <dieb13@klingt.org>
Subject: Re: Problems with HDSP Multiface+CardBus
Date: Thu, 12 Jun 2003 20:03:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EE8C06B.1090003@klingt.org>
References: <cd0c7150ee2ca9bc60925c63d149d3a5@essej.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <cd0c7150ee2ca9bc60925c63d149d3a5@essej.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jesse Chappell <jesse@essej.net>
List-Id: alsa-devel@alsa-project.org



Jesse Chappell wrote:
>  But a word of warning if you do get sound going
> eventually: 32768 for the LineOut(headphone) port is *way* too
> hot for headphones plugged directly in.  I had to crank it down to 4000 
> to get a sane maximum volume.  You don't want to damage your headphones
> or your ears.....

that's interresting. 32767 has always been fine for me (on headphones 
just like on line-outs), and all descriptions about the mixer-matrix say 
32767 means 0db. even sinewaves with 0db are loud but not distorted on 
my headphones...

btw: does anybody have a "complete" description of the possibilities for
amixer -c 1 cset numid=XYZ ???

thanks&regards
d13b




-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
