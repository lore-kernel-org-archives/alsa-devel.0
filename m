From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: ALSA compatibility to WM8750 codec and MPlayer!
Date: Fri, 15 Sep 2006 11:17:10 +0100
Message-ID: <1158315430.22950.17.camel@localhost.localdomain>
References: <20060915100651.98020.qmail@web8505.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060915100651.98020.qmail@web8505.mail.in.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "D. Krishna Mohan" <krishna_danim@yahoo.co.in>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-09-15 at 11:06 +0100, D. Krishna Mohan wrote:
> Hi i am presently working with WM8750 Audio codec. My query is
> wheather or not ALSA support WM8750 Audio Codec. If yes what are the
> interfaces ALSA provides for this codec.

WM8750 is supported under ALSA. It's available as as part of ASoC and is
available here:-

http://www.rpsys.net/openzaurus/patches/alsa/

More info here:-

http://www.rpsys.net/openzaurus/patches/alsa/info.html

>    Also How MPlayer communicates with kernel(or ALSA) and to driver
> finally to control audio.How should i proceed with this task. I donot
> know anything about ALSA and MPlayer's interfaces.Please help me!
>  

Alsa and Mplayer get on just fine. Mplayer uses alsa-lib for
communication with the alsa-kernel core (including the drivers and audio
hardware).
 
mplayer -ao alsa file.mp3

Will make mplayer use the alsa interface instead of OSS.

Liam




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
