From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: PCM format 20 bit
Date: Sun, 22 Oct 2006 20:56:15 +0200
Message-ID: <20061022205615.1e697eae.pochini@shiny.it>
References: <B9FFC3F97441D04093A504CEA31B7C41EC8304@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <B9FFC3F97441D04093A504CEA31B7C41EC8304@msilexch01.marvell.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Assaf Hoffman <hoffman@marvell.com>
Cc: rita@marvell.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 22 Oct 2006 18:11:55 +0200
"Assaf Hoffman" <hoffman@marvell.com> wrote:

> My HW supports 20-bit sample using 32-bit phy frame. As I understand,
> the only way the ALSA supports the 20-bit sample is 24-bit frame
> (SNDRV_PCM_FORMAT_x20_3xE).
>
> Please advice.

If it's 20 bits left-aligned in 32 bits, you can use S32_LE or similar
formats. For example the old echoaudio cards based on the DSP 56301 use
S32_LE but only the upper 20 bits contain data.


--
Giuliano.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
