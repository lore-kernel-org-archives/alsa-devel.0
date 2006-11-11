From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: SB16 ISA max frequency bump to 48kHz
Date: Sat, 11 Nov 2006 04:53:02 +0100
Message-ID: <4555491E.8060800@keyaccess.nl>
References: <455420809a154@wp.pl> <s5hirhncyyl.wl%tiwai@suse.de>
	<4554961A.5070509@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4554961A.5070509@keyaccess.nl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:

> Takashi Iwai wrote:
> 
>> Krzysztof Helt wrote:
> 
>>> This patch  bumps maximum frequency for ISA SB16 to 48kHz. I
>>> tested it on three cards: SB16 non-pnp, SB16 pnp and SB AWE64
>>> (all ISA boards).
>>
>> Looks fine.  Could you give sign-off for commit?
> 
> Sorry, but I'd have to be very mistaken if the SB16 supports 48000 in 
> hardware. The 4000-44100 is correct.

Confirmed. Although nothing complains with the proposed patch, audio 
sampled at 48000 just plays too slow. Not exactly 48000/44100 too slow 
(a song that lasts 3:21 takes 3:33, which would be 45295) but too slow.

So, please don't apply (when I was searching around, I did find that it 
probably should be 5000-44100 instead of 4000-44100).

Rene.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
