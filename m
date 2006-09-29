From: "James Courtier-Dutton" <james.dutton@gmail.com>
Subject: Re: Alsa driver data transfer problem: the MSB is
	changed to 1
Date: Fri, 29 Sep 2006 13:14:04 +0100
Message-ID: <ad2655cb0609290514s549bbceflec2d770dafbe73eb@mail.gmail.com>
References: <001901c6e2da$216e9140$9b01a8c0@LiYong>
	<s5hirj82lm3.wl%tiwai@suse.de> <006b01c6e367$3e3ba230$9b01a8c0@LiYong>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <006b01c6e367$3e3ba230$9b01a8c0@LiYong>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: YongLi <sdshliyong@163.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 29/09/06, YongLi <sdshliyong@163.com> wrote:
> If I perform this command:
>
> cat test.txt > /dev/dsp
>

That command does not specifiy to /dev/dsp what format the file is.
I.e 8 bit audio or 16bit audio. The OSS api specifies a default
assumed value. Now, if the sound card itself cannot handle the assumed
value, it will automatically adjust the format so that some sound
plays.

As I said before, use aplay instead of cat.

James

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
